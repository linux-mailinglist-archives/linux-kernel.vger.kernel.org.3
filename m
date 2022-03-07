Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E668C4D0626
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiCGSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiCGSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:17:19 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549F75E69
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:16:22 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220307181616epoutp01e3bca416dde6cb17c0719f5d95a651c4~aK-xQgEZf0767007670epoutp01D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:16:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220307181616epoutp01e3bca416dde6cb17c0719f5d95a651c4~aK-xQgEZf0767007670epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646676976;
        bh=+DoYqIP57CK30qeEszS0FSuPgQHsdE9AmjYT9fqaiY8=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=VUtydj3bNltVpXLs+6lpqVbi1uFYaA6EYA//vyrvac2hVd2m+9ni801l2KipbLcU+
         hDz0jLG9WALzMtaYG1/6/cdMmxDXoHGQ2AsSq/ZkS87t6YCUb5lPyaVIEx/Ap7gjAP
         8sZLX1lNDjzSPnvYw+MmxqueIgNJSXu4BFxTdqEs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220307181615epcas5p342477b57f086c1d54502b559c5b55440~aK-wr4shN0547805478epcas5p36;
        Mon,  7 Mar 2022 18:16:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KC68p3h7kz4x9Pq; Mon,  7 Mar
        2022 18:16:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.BC.46822.93946226; Tue,  8 Mar 2022 03:04:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220307181609epcas5p1dee884f7f426b64ee5915f507c1fb696~aK-qjlWmv0140301403epcas5p1b;
        Mon,  7 Mar 2022 18:16:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307181609epsmtrp2c90c3afdfefa8eedbdb3c0d001bd3d0e~aK-qix9hX3020530205epsmtrp2z;
        Mon,  7 Mar 2022 18:16:09 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-fa-6226493981c0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.C1.29871.9EB46226; Tue,  8 Mar 2022 03:16:09 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307181607epsmtip150e77f72df12ff26f43123b50e3d891b~aK-pYRZNs2332523325epsmtip19;
        Mon,  7 Mar 2022 18:16:07 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220307080925.54131-6-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 7/7] tty: serial: samsung: simplify getting OF match
 data
Date:   Mon, 7 Mar 2022 23:46:06 +0530
Message-ID: <000001d8324f$6b2c9a40$4185cec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGoAYk8Q04rU2h+MYSS22x/2RnCswLpcBE3AkLWjums6zlaEA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmhq6lp1qSQX87t0Xz4vVsFu/mylhs
        fPuDyWLT42usFpd3zWGzmHF+H5PFmcW97A7sHrMaetk8Nq3qZPPYP3cNu8fmJfUenzfJBbBG
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2hpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO
        WP98MUvBLb6K6av/sDUwPuHpYuTkkBAwkTi4cR1LFyMXh5DAbkaJi8t3MEE4nxglFq18zQjh
        fGOU2HrgORNMy/Pj69ghEnsZJS5s/QLlvGSUaJn2hg2kik1AV2LH4jY2kISIwAYmiUv3poK1
        cwq4SzS0bmAEsYUFgiR2Nj9jAbFZBFQkvu08xg5i8wpYSry8cJcFwhaUODnzCZjNLCAvsf3t
        HGaIMxQkfj5dxgpiiwg4Sdz8eZEZokZc4uXRI2AXSQi0ckhcX/iXFaLBReJc+y6oH4QlXh3f
        wg5hS0l8frcX6FIOIDtbomeXMUS4RmLpvGMsELa9xIErc1hASpgFNCXW79KHWMUn0fv7CRNE
        J69ER5sQRLWqRPO7q1Cd0hITu7tZIUo8JH7c0YME1XVGie6Ln5knMCrMQvLkLCRPzkLyzCyE
        xQsYWVYxSqYWFOempxabFhjlpZbDIzw5P3cTIziNanntYHz44IPeIUYmDsZDjBIczEoivPfP
        qyQJ8aYkVlalFuXHF5XmpBYfYjQFhvxEZinR5HxgIs8riTc0sTQwMTMzM7E0NjNUEuc9nb4h
        UUggPbEkNTs1tSC1CKaPiYNTqoFJddPuxMVnpT43KyzN6Di1t8XPsiJNeX26sKFUifhSjUuX
        pv4Kel0mJvFyt91nrZ9Lz7PdPbX2vKHitbf13mK2E2MEp316fTtRMikuw2nGPYWNDP+r6hae
        WFkpcej5CdUL3D+Psyt9Ee7TEVyScOZHeEyeyiXOGZvyj729w6Tz2EVQwy8jZv2uqesPCr9g
        4k5t2e4easW/aa7JznKm1smm/oaqf58t/PQ+/e8tHo/E+QHtLcpTpS75NnlURP4pslP18uY9
        9v5/wY+uaUdjnz3T9Nm5qpq/zfnv9QvbnarSl8bznjH1+rVgv+i0RrE0Waenz1RPczYviLBw
        uX2fyV5E4e6fTxG13wTO1z5eqP9XiaU4I9FQi7moOBEA+elMTywEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnO5Lb7UkgzmbWS2aF69ns3g3V8Zi
        49sfTBabHl9jtbi8aw6bxYzz+5gszizuZXdg95jV0MvmsWlVJ5vH/rlr2D02L6n3+LxJLoA1
        issmJTUnsyy1SN8ugStj/fPFLAW3+Cqmr/7D1sD4hKeLkZNDQsBE4vnxdexdjFwcQgK7GSX6
        nixghEhIS1zfOIEdwhaWWPnvOVTRc0aJ1ytegCXYBHQldixuYwOxRQS2MEks+hYHUXSZUWJd
        wysWkASngLtEQ+sGsKnCAgESs86sA2tmEVCR+LbzGJjNK2Ap8fLCXRYIW1Di5MwnQDYHB7OA
        nkTbRrBWZgF5ie1v5zBDHKQg8fPpMlaIvU4SN39eZIaoEZd4efQI+wRGoVlIJs1CmDQLyaRZ
        SDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjhgtzR2M21d90DvEyMTBeIhR
        goNZSYT3/nmVJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYqlncAvdu7Q6Yxyt7qF7CiaHYz+d+0qZHLzNFE2qKjrI+rt2z/2+eS/HGrZW1u2vV1ZfP
        2XXZb9u9eqe4XW7ddS57W0X5pqcefLrMI3Cqfan9X7m0pYqRd9UOZPAvuq9w7/d6p2t+/7pO
        LPqXyDLriUZQi0hIDfvHm2tmlfzddPtZ00dGvS8J85Tcdy3bu6appvi7XIHuMzOG3Fep079b
        57585ihV2nxr6Y/XkWtfXbO58vi7dI/2Dv+8WSrSL8r0WOa0v1si77mpuedOm2ZUxyLVg979
        XT8f2lu8X/74mePCPR8/CNQtlDfxk1/OeDv3ntF2XznRNxv5jI6tOLjIvXYbm/N66ytvLjKI
        3jlmrcRSnJFoqMVcVJwIAEZVzAcHAwAA
X-CMS-MailID: 20220307181609epcas5p1dee884f7f426b64ee5915f507c1fb696
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307080948epcas5p2cfb6ad93e628461366b03203a884e0e6
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
        <CGME20220307080948epcas5p2cfb6ad93e628461366b03203a884e0e6@epcas5p2.samsung.com>
        <20220307080925.54131-6-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, March 7, 2022 1:39 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>serial@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH v2 7/7] tty: serial: samsung: simplify getting OF match
data
>
>Simplify the code with of_device_get_match_data().
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> drivers/tty/serial/samsung_tty.c | 13 +++----------
> 1 file changed, 3 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/tty/serial/samsung_tty.c
>b/drivers/tty/serial/samsung_tty.c
>index 3ffae912217c..61c530bb377f 100644
>--- a/drivers/tty/serial/samsung_tty.c
>+++ b/drivers/tty/serial/samsung_tty.c
>@@ -2150,23 +2150,16 @@ static int s3c24xx_serial_init_port(struct
>s3c24xx_uart_port *ourport,
>
> /* Device driver serial port probe */
>
>-#ifdef CONFIG_OF
>-static const struct of_device_id s3c24xx_uart_dt_match[]; -#endif
>-
> static int probe_index;
>
> static inline const struct s3c24xx_serial_drv_data *
>s3c24xx_get_driver_data(struct platform_device *pdev)  {  #ifdef CONFIG_OF
>-	if (pdev->dev.of_node) {
>-		const struct of_device_id *match;
>-
>-		match = of_match_node(s3c24xx_uart_dt_match, pdev-
>>dev.of_node);
>-		return (struct s3c24xx_serial_drv_data *)match->data;
>-	}
>+	if (pdev->dev.of_node)
>+		return of_device_get_match_data(&pdev->dev);
> #endif
>+
> 	return (struct s3c24xx_serial_drv_data *)
> 			platform_get_device_id(pdev)->driver_data;
> }
>--
>2.32.0


