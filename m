Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B14B7C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbiBPBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:03:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiBPBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:03:12 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B088792
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:03:01 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220216010259epoutp040c5a2b1855f033cff437fce62fdca581~UHpLVmaJX1566415664epoutp04k
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220216010259epoutp040c5a2b1855f033cff437fce62fdca581~UHpLVmaJX1566415664epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644973379;
        bh=Awd+MxxFbtV7nsHD33wuxQC5grRtG3mHSq7dK59Ip0U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YTYoPDzXemWlbUSfBrrZFRu0AUkGhaitpWIx9v3p7fsIw6qIkKfeGoyv30JFkHCCL
         YCaoP151ckgIrk7Nm+bRkuqq6vokIs3kIylAvvftI/gavBjFGFgnVeYUuLVcDJX2Ae
         UNt+eT9DqnTtuYo5oO5/aRcwkDhU8vXPOI3TQs/8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220216010259epcas1p42e1b1380db091eec12a4b8ea4fea3471~UHpLDJ2MX1084010840epcas1p4H;
        Wed, 16 Feb 2022 01:02:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.236]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jz07M5pGbz4x9Q7; Wed, 16 Feb
        2022 01:02:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.CF.21932.93D4C026; Wed, 16 Feb 2022 10:02:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220216010249epcas1p13569dacb88d41777a867b3c02028b3b3~UHpBpNL3o1064010640epcas1p1U;
        Wed, 16 Feb 2022 01:02:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220216010249epsmtrp24ea739aed7984bffc102b2560a86a860~UHpBogacL1794217942epsmtrp29;
        Wed, 16 Feb 2022 01:02:49 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-e7-620c4d39d5b1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.A2.29871.93D4C026; Wed, 16 Feb 2022 10:02:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220216010249epsmtip288660afb9f53840dc26134583062d02c~UHpBcEXZq0599805998epsmtip2i;
        Wed, 16 Feb 2022 01:02:49 +0000 (GMT)
Subject: Re: [PATCH 1/4] extcon: int3496: Make the driver a bit less verbose
To:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5c632a6c-cb85-a941-1ad3-b0ed20b2082b@samsung.com>
Date:   Wed, 16 Feb 2022 10:27:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211228170141.520902-1-hdegoede@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTQNfSlyfJoPmjrsWb49OZLC7vmsNm
        cbtxBZvFjbkmDiwebQvsPd7vu8rm0bdlFaPH501yASxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QAuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQWmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ89p7mAouc1UcnjKbqYHxAUcXIweH
        hICJRMf5wC5GLg4hgR2MEidfTmWDcD4xSnyeP50dwvnGKLG2fSVLFyMnWMfJ5r1MEIm9jBIf
        pt1jhnDeM0qs6dgGViUs4COx7WYPK4gtIhAkceP7CjCbWcBd4tqkBWA1bAJaEvtf3GADsfkF
        FCWu/njMCHITr4CdxL77/iBhFgFViWvNG9hBbFGBMImT21oYQWxeAUGJkzOfgI3hFLCSOLt/
        PjvEeHGJW0/mM0HY8hLb384Bu01C4C+7xOrmicwQP7tItGwPhXhGWOLV8S3sELaUxOd3e9kg
        6psZJRpe3GaEcHoYJY4+64N631hi/9LJTCCDmAU0Jdbv0ocIK0rs/D2XEWIxn8S7ryC/g+zi
        lehoE4IoUZa4/OAuE4QtKbG4vZNtAqPSLCTvzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYEJ
        PLKT83M3MYLTopbFDsa5bz/oHWJk4mA8xCjBwawkwht3ljNJiDclsbIqtSg/vqg0J7X4EKMp
        MIAnMkuJJucDE3NeSbyhiaWBiZmRsYmFoZmhkjhv79TTiUIC6YklqdmpqQWpRTB9TBycUg1M
        5Z/mLitffPuAjlLiuduVSewrtrya/ay+NrZDcfubzV19u5ofc8fynVcpfMvZUdWovFBaI2Nb
        cmjbr3gHM8FnK1JPy+6c/9p3embIzzMCmipXp/w6bHX03LptXp+Yt8tNe1LwcSqD+aqq+Iim
        KcK+yxYvCGBzeCm04skuaSPJu48uWmQq/hDuKPoh//u1PIutSBbjhD7DLtabRmGny77dWrli
        5Txjr3RR9cfrY8SkP//61hK4Zk2N82GeLyZSR08s3HrYNu3Dn+03FgilblGbncrEqSLyVkZw
        Ue/8WK3YHZqH3z5MYkz+y3pNzFTMOPKbfpLe3ditmjYTpu9Ob5y19abFhSn/VJUfyjDUsm92
        VWIpzkg01GIuKk4EADoR8/4UBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK6lL0+SQc8JcYs3x6czWVzeNYfN
        4nbjCjaLG3NNHFg82hbYe7zfd5XNo2/LKkaPz5vkAliiuGxSUnMyy1KL9O0SuDLmtfcwFVzm
        qjg8ZTZTA+MDji5GTg4JAROJk817mboYuTiEBHYzStxrb2WDSEhKTLt4lLmLkQPIFpY4fLgY
        JCwk8JZRYuaVGhBbWMBHYtvNHlYQW0QgSGLC/g3sIDazgLvEtUkLWCBm9jJKtN/dxgSSYBPQ
        ktj/4gbYfH4BRYmrPx4zgsznFbCT2HffHyTMIqAqca0ZYo6oQJjEziWPwVp5BQQlTs58wgJi
        cwpYSZzdPx9ql7rEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELSsoCRZRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnB8aGnuYNy+6oPeIUYmDsZDjBIczEoivHFn
        OZOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYKr8u930
        /EL2tVcy046q9AnLKaZc3bHY9+SyrnSrlF/fa14nWF0/kyN085hBoGbTh81eT4/UuV17ksf3
        o2jdy4dXzyy+NyWeQZDp8GodST2JD9dl7UoFcnPkq96W/pD4zhG7JWuFj02Zqcr5lPCTfNc0
        Tsi/Lvrw9qTJyuaJ21c8TE3YUH9Za+++m9YGLTxugfavEh+u7im59eL1FKaOids3L/ux9d2M
        eLuJV7kyim5P+2F3zDFrH/sB9yfxmwJ/fHnk8dU+aML7J0Ii5haPQnbOOpJyNpBR/WOFr6fd
        TcEfx2KZE7grn23Il+jtLTpn+pdjKrf4/iXeeW2CznMTC5bMzbnx/+/Z1UkT2iREHgkqsRRn
        JBpqMRcVJwIAMj7pL/4CAAA=
X-CMS-MailID: 20220216010249epcas1p13569dacb88d41777a867b3c02028b3b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211228170156epcas1p2a0dea22755f2336b01c6e06b289d9583
References: <CGME20211228170156epcas1p2a0dea22755f2336b01c6e06b289d9583@epcas1p2.samsung.com>
        <20211228170141.520902-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 2:01 AM, Hans de Goede wrote:
> On all devices which I have with an INT3496 ACPI device,
> there is only an ID pin defined.
> 
> Change the log-messages about not being able to get GPIOs for
> "VBUS EN" and "USB MUX" to use dev_dbg().
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-int3496.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index fb527c23639e..df6ab4ef46f5 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -121,11 +121,11 @@ static int int3496_probe(struct platform_device *pdev)
>  
>  	data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", GPIOD_ASIS);
>  	if (IS_ERR(data->gpio_vbus_en))
> -		dev_info(dev, "can't request VBUS EN GPIO\n");
> +		dev_dbg(dev, "can't request VBUS EN GPIO\n");
>  
>  	data->gpio_usb_mux = devm_gpiod_get(dev, "mux", GPIOD_ASIS);
>  	if (IS_ERR(data->gpio_usb_mux))
> -		dev_info(dev, "can't request USB MUX GPIO\n");
> +		dev_dbg(dev, "can't request USB MUX GPIO\n");
>  
>  	/* register extcon device */
>  	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
> 

Applied them (patch1-4). Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
