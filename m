Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D8C4D0656
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiCGSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiCGSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:22:34 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0F82D08
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:21:39 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220307182137epoutp02c2deb06ce59f19ef8f101df4752ac788~aLEcJsR0J3120131201epoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:21:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220307182137epoutp02c2deb06ce59f19ef8f101df4752ac788~aLEcJsR0J3120131201epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646677297;
        bh=/J+z6G42rWkxE8lu/uL7Rm+nMfgqe+5jZvMCgeeEWfY=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=R8F+5QO8jTyoTNeT95BT0wOlZxmePeLkqV3CbnpKVMrZ94fbx1QH20xIxLTnZbCvp
         EJf+nMxtwk/CNIIFa9UwonoDp6PW/9Xdhwvakmu2OAq7kgR5QPepY8XGgXTwva48d5
         6SK02zmVTx2IxHQkgKMIrhec0VGiRRmAr+qndsdk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220307182136epcas5p4337edae5bcac87f910a0b77ed170ea3d~aLEa_kO-s3151331513epcas5p4J;
        Mon,  7 Mar 2022 18:21:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KC6Gz3Dccz4x9Pr; Mon,  7 Mar
        2022 18:21:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.1D.46822.97A46226; Tue,  8 Mar 2022 03:10:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220307182131epcas5p266101e33fa3d9e181ace27e833047be4~aLEWX_u5I0752707527epcas5p2M;
        Mon,  7 Mar 2022 18:21:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307182131epsmtrp2f67a7a71de449a2e899da573da6036d7~aLEWXPQ1Y0032100321epsmtrp2m;
        Mon,  7 Mar 2022 18:21:31 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-7b-62264a79d757
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.E1.29871.B2D46226; Tue,  8 Mar 2022 03:21:31 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220307182130epsmtip2691ead9ace9d1e46069f48ea33f55583~aLEVUAL4I1136311363epsmtip23;
        Mon,  7 Mar 2022 18:21:29 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 0/7] tty: serial: samsung: minor fixes/cleanups
Date:   Mon, 7 Mar 2022 23:51:28 +0530
Message-ID: <000201d83250$2b1fb3a0$815f1ae0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJNNL4wI7r1IeeqxSWm7dk8MPZOAGoAYk8rET1w7A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmpm6ll1qSwYSjVhbNi9ezWbybK2Ox
        8e0PJotNj6+xWlzeNYfNYsb5fUwWZxb3sjuwe8xq6GXz2LSqk81j/9w17B6bl9R7fN4kF8Aa
        lW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SEkkJZ
        Yk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7
        4+bPuWwFb3kqvtz7x9LA+IGri5GTQ0LARKLz6hymLkYuDiGB3YwS59paWSCcT4wSp7/0M0I4
        3xgl9uxfzwTTcrS5hRkisZdRYuOC1WwQzktGiW8TlzCDVLEJ6ErsWNwGlhAR2MAkceneVLB2
        TgF3ia7Jz8BsYQE3ic6j11m7GDk4WARUJA4szgAJ8wpYSlzf28sKYQtKnJz5hAXEZhaQl9j+
        dg4zxBUKEj+fLgOrERGwkrhz4DcTRI24xMujR9ghano5JCZ/5QQZLyHgIjHlQjxEWFji1fEt
        UCVSEp/f7WWDKMmW6NllDBGukVg67xgLhG0vceDKHBaQEmYBTYn1u/QhFvFJ9P5+wgTRySvR
        0SYEUa0q0fzuKlSntMTE7m5WiBIPiflnNSHhNItR4mfzbMYJjAqzkLw4C8mLs5C8Mgth8QJG
        llWMkqkFxbnpqcWmBUZ5qeXw2E7Oz93ECE6gWl47GB8++KB3iJGJg/EQowQHs5II7/3zKklC
        vCmJlVWpRfnxRaU5qcWHGE2BwT6RWUo0OR+YwvNK4g1NLA1MzMzMTCyNzQyVxHlPp29IFBJI
        TyxJzU5NLUgtgulj4uCUamBycHxwblJNnWvb3MTso6ouR5p/98T9qS+e4lBwnT8zMkqje5Jk
        1Y2CpPv6kr5H/MJWeVX9MhbfKSJ8/XTJE59raUd/mGQ7bc521O15/fGqmI/dz+iX2z26U3+0
        9x03DzL0twjnYg4RE5vq17bITv+gzn3diQarFslziWg9epSvVC/CNWna/ITcGe3t/fv3Z6qv
        l8oriFo7Wzu/z7g8cFblYZOQiIO3jHx1I360fXhWc/vbTrXfjZLvpe8mGFyKE1y0e62R9lED
        r8ON/L842AXvlLnccLgSutviwJ/CeXYXAiff+fjc0Onx+YpUvvbAOJeISe9VlrUty/i9Vt3d
        yWK2r8rVBQqKfw63Gcw+p8RSnJFoqMVcVJwIAHpITVYpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK62r1qSwY/zbBbNi9ezWbybK2Ox
        8e0PJotNj6+xWlzeNYfNYsb5fUwWZxb3sjuwe8xq6GXz2LSqk81j/9w17B6bl9R7fN4kF8Aa
        xWWTkpqTWZZapG+XwJVx8+dctoK3PBVf7v1jaWD8wNXFyMkhIWAicbS5hbmLkYtDSGA3o8S/
        3m2sEAlpiesbJ7BD2MISK/89B7OFBJ4zSuxamQNiswnoSuxY3MYGYosIbGGSWPQtDmLQDEaJ
        SVt+M4IkOAXcJbomP2MCsYUF3CQ6j14HWsDBwSKgInFgcQZImFfAUuL63l5WCFtQ4uTMJywg
        JcwCehJtG8GmMAvIS2x/O4cZ4hwFiZ9Pl7FCrLWSuHPgNxNEjbjEy6NH2CcwCs1CMmkWwqRZ
        SCbNQtKxgJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcLRoae5g3L7qg94hRiYO
        xkOMEhzMSiK898+rJAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgm
        y8TBKdXAdFg4qXapx4M50jv+WBtL/vU0bmf44Ro0V6r4sk24xpmslw5P5NgVzmudOFC/9o8H
        5wLj8+ozIhh3ypQnyhvNzG/jONB86ALziUM8/Y++/34y52GjSd+2h0pvuNcuYV8cv8TpwhKB
        a6kVib6akwXsnv9xm6S/aseilzMnRR/Mmr4wY6r9r/BXver/1sxlDP93/WV7v9uBTr2isCu3
        ZWZoRp3ZFXh07afC6O1rT0m8XPQraOqn14Lmre/Ck5/olDjrf6/MN9oW/sg1+dc5ibladxav
        0JoquOlQ9kyFA/55r2ecvtlXUOUXc6ar4Mr/aufPpicmuL/l+OMp2hoS7as9e9Ez22OBL6b+
        41XIX3xkWbwSS3FGoqEWc1FxIgCyfnN5BQMAAA==
X-CMS-MailID: 20220307182131epcas5p266101e33fa3d9e181ace27e833047be4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307080826epcas5p13d71054f6b461cff91edbbb2cf42491a
References: <CGME20220307080826epcas5p13d71054f6b461cff91edbbb2cf42491a@epcas5p1.samsung.com>
        <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, March 7, 2022 1:38 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>serial@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH v2 0/7] tty: serial: samsung: minor fixes/cleanups
>
>Hi,
>
>Changes since v1:
>1. Patch 3: remove unneeded parenthesis and module alias change (Jiri).
>2. Patch 3: move unrelated "constify" bits to patch 6.
>3. Patch 5: fix typo.
>4. Add review tags.
>
>Best regards,
>Krzysztof
>
>Krzysztof Kozlowski (7):
>  tty: serial: samsung: embed s3c24xx_uart_info in parent structure
>  tty: serial: samsung: embed s3c2410_uartcfg in parent structure
>  tty: serial: samsung: constify s3c24xx_serial_drv_data
>  tty: serial: samsung: constify UART name
>  tty: serial: samsung: constify s3c24xx_serial_drv_data members
>  tty: serial: samsung: constify variables and pointers
>  tty: serial: samsung: simplify getting OF match data
>
> drivers/tty/serial/samsung_tty.c | 225 +++++++++++++++----------------
> 1 file changed, 109 insertions(+), 116 deletions(-)
>

For this series feel free to add
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Sanity tested on Exynos7 Espresso board, boot log and other console prints
after boot looks fine, so

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

>--
>2.32.0


