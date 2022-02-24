Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810594C29AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiBXKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiBXKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:37:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4733E96
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:36:37 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220224103631epoutp042a95f8a4a99f55737490347ab3a38bb4~WsoOGXlgX0341003410epoutp04W
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220224103631epoutp042a95f8a4a99f55737490347ab3a38bb4~WsoOGXlgX0341003410epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645698991;
        bh=TrZS5Sc3kEWVfqvt+x2vV2GRttmuUfucMUFHzxpFFo4=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=H89DwBRcFTgLM33Axshnse2swztjOgLMUAwH8XHXXrhlr9QnB4bFTu5NyWLc2FGZ6
         BB9bPjPe30r2Ma2svQPjgnFmZXBf5MBG488Twk8Q4JnZEt23LCvvE6Gulo4kImEC65
         msH1Qi0532mYR+seLd8F5DZGToEzyvpqLAxyAM9w=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220224103631epcas5p37b8d245b6393bbde7ea2d9119a432737~WsoN0qqHF0549105491epcas5p3H;
        Thu, 24 Feb 2022 10:36:31 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-e4-62175ee8797e
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.93.46822.8EE57126; Thu, 24 Feb 2022 19:33:12 +0900 (KST)
Date:   Thu, 24 Feb 2022 15:55:44 +0530
Message-ID: <1601902218.1030861.1645698344460@mail-kr5-1>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] android-recommended.config: change
 BACKLIGHT_LCD_SUPPORT to LCD_CLASS_DEVICE
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Onkarnath <onkarnath.1@samsung.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        "maennich@google.com" <maennich@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220211093444.661285-1-onkarnath.1@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20220224102544epcms5p548fa94cdf86b8105a5a66055437bc82e
Content-Type: multipart/mixed;
        boundary="----=_Part_1030860_60501293.1645698344459"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7bCmuu6LOPEkg1OH+S2aF69ns7i8aw6b
        xbe9b9gtVvR8YLX4v2cHu8WkHVIWh07OZXRg91iwqdRj06pONo/9c9ewe0yZe4TVo2/LKkaP
        z5vkAtiiuGxSUnMyy1KL9O0SuDJWTnzDWnBKumLB+qmsDYxHJbsYOTkkBEwk+v4dYe1i5OIQ
        EtjNKLH733V2kASLgKrE7TOrmUFsXgFLifmr/gPFOYBsQYm/O4RBTGGBdInpi8NAKoQEFCUu
        zFjDCBE2kPi1VQMkzCagJ7Fq1x4WkOkiApsYJd587WEBSTALTGOU2Lg0HeIEXokZ7U9ZIGxp
        ie3LtzKC2JwCdhKntv1lhIiLStxc/ZYdxn5/bD5UXESi9d5ZZghbUOLBz91QcRmJ1Zt7wRZL
        CHQzSqx/txfKmcEo0fNoGlSHucT6JaugprpInN69mA3iulCJhUefsELEZSWmnlrHBBHnk+j9
        /YQJ5uod82BsVYmWmxtYYT74/PEj1DceEqtOToEGbiujxO23/1kmMMrPQoTjLCTrIGx5ie1v
        5zCDlDALaEqs36UPEVaTmNL/hQ3CNpNoaJ/KAmErSkzpfsi+gJF9FaNkakFxbnpqsWmBUV5q
        uV5xYm5xaV66XnJ+7iZGcOLS8trB+PDBB71DjEwcjIcYVYDaH21YfYFRiiUvPy9VSYTXtFAs
        SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6fQNiUIC6YklqdmpqQWpRTBZJg5OqQam+iiRBxq7
        d9961bAgQFJ52slfdY/Onz42q33vkkLTIvt9KxOldNhYF52eejPyygXp0Ovxl/7fZ7aVcEpi
        faOkbld2Nef9gY+aTdvzWSK0jP7/un8tzvL+nDWxe5eJaqolrV4w5W+t1l6nAyqmm6XNnG67
        zg9jXLP5S9Dd9Vuzns5sPl7n01R9/MvOzDf89d6PeH7KWm3t2JE1/+e73RJ2Z2ODj+Zp7nh5
        cpOBidTzg4pHf923fhHf+C1xDa/Zv+P8tfffBbtPur4g5bjFXemXzXcqhPdM+ZgdwlW++2yp
        6NMFJjsaUtY7lYssnvap+cxMr5pEmfDenGVnlPxzaqoviF/R2fkiftkH6ayfP85XrFViKc5I
        NNRiLipOBADiNB8b1wMAAA==
X-CMS-RootMailID: 20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996
References: <20220211093444.661285-1-onkarnath.1@samsung.com>
        <CGME20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996@epcms5p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1030860_60501293.1645698344459
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

[ping]

> with commit '8c5dc8d9f19c ("video: backlight: Remove useless
> BACKLIGHT_LCD_SUPPORT kernel symbol")'code of BACKLIGHT_LCD_SUPPORT
> is removed from kernel, and control shifted to LCD_CLASS_DEVICE only
> thus updating android recommended config also.
>  
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> ---
>  kernel/configs/android-recommended.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  
> diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
> index eb0029c9a6a6..0869095ff345 100644
> --- a/kernel/configs/android-recommended.config
> +++ b/kernel/configs/android-recommended.config
> @@ -7,7 +7,6 @@
>  # CONFIG_PM_WAKELOCKS_GC is not set
>  # CONFIG_VT is not set
>  CONFIG_ARM64_SW_TTBR0_PAN=y
> -CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_BLK_DEV_DM=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> @@ -86,6 +85,7 @@ CONFIG_JOYSTICK_XPAD_FF=y
>  CONFIG_JOYSTICK_XPAD_LEDS=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_KSM=y
> +CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LOGIG940_FF=y
>  CONFIG_LOGIRUMBLEPAD2_FF=y
>  CONFIG_LOGITECH_FF=y
> -- 
> 2.17.1
 
 
------=_Part_1030860_60501293.1645698344459
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBbUEFUQ0ggMS8xXSBhbmRy
b2lkLXJlY29tbWVuZGVkLmNvbmZpZzogY2hhbmdlIEJBQ0tMSUdIVF9MQ0RfU1VQUE9SVCB0byBM
Q0RfQ0xBU1NfREVWSUNFDQogICAgICBGcm9tICAgICAgIDogT25rYXJuYXRoIEVuZ2luZWVyL1N5
c3RlbSBTL1cgR3JvdXAgL1NSSS1EZWxoaS9TYW1zdW5nIEVsZWN0cm9uaWNzDQogICAgICBTZW50
IERhdGUgIDogMjAyMi0wMi0xMSAxNTowNiAgR01UKzU6MzANCiAgID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
ICAgICAgICAgICAgICAgICAgTmFtZSAgICAgICAgICAgICAgICBUeXBlICAgICAgICAgIEpvYiBU
aXRsZSAgICAgICAgICAgICAgICAgICAgICAgRGVwdC4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQ29tcGFueSAgICAgICAgICAgICAgICANCiAgID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KICAgICAg
cm9iaEBrZXJuZWwub3JnICAgICAgICAgICAgICAgIFRPDQogICAgICBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnICAgQ0MNCiAgICAgIE1hbmluZGVyIFNpbmdoICAgICAgICAgICAgICAgICBD
QyAgICAgICAgIFN0YWZmIEVuZ2luZWVyICAgICAgICAgICAgIFN5c3RlbSBTL1cgR3JvdXAgL1NS
SS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNzwqANCiAgICAgIFZhbmVl
dCBOYXJhbmcgICAgICAgICAgICAgICAgICBDQyAgICAgICAgIEFzc29jaWF0ZSBBcmNoaXRlY3Qg
ICAgICAgIFN5c3RlbSBTL1cgR3JvdXAgL1NSSS1EZWxoaSAgICAgICAgICAgICAgIFNhbXN1bmcg
RWxlY3Ryb25pY3MNCiAgICAgIG1hZW5uaWNoQGdvb2dsZS5jb20gICAgICAgICAgICBDQw0KICAg
ICAgT25rYXJuYXRoICAgICAgICAgICAgICAgICAgICAgIENDICAgICAgICAgRW5naW5lZXIgICAg
ICAgICAgICAgICAgICAgU3lzdGVtIFMvVyBHcm91cCAvU1JJLURlbGhpICAgICAgICAgICAgICAg
U2Ftc3VuZyBFbGVjdHJvbmljcw0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

------=_Part_1030860_60501293.1645698344459--
