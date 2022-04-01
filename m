Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C714EE7AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbiDAFQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiDAFQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:16:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F662261301
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:14:58 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220401051456epoutp0334174abe34cad024c895d42bbd21051a~hrdt6A3MO2645826458epoutp03t
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:14:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220401051456epoutp0334174abe34cad024c895d42bbd21051a~hrdt6A3MO2645826458epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648790096;
        bh=zWZLPSSISjiFTmW1ZkI756AoY5PvxUxkz4eHhpfrd70=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jYFjYGuOIDXOVK1sWCwLB3u9O5XHY4Kw7ddLcf9m4N2nbK/YwNcuW1nGTUuf/TaDW
         t68H2szJ2zSYoW+O6zb98quIGwQ2ejh/SB54MxaK7SYa7tHNQ7wAnPBoKS2u1mBNBs
         a4DZCjrBdTl0Fwd8Xt/HzwytwzW27yxdi0UGEA0U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220401051456epcas5p3a678c6bc453a9a945cbb04b919e8e565~hrdtYQKQO1668716687epcas5p3y;
        Fri,  1 Apr 2022 05:14:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KV7dl02JRz4x9QS; Fri,  1 Apr
        2022 05:14:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.CC.06423.54A86426; Fri,  1 Apr 2022 14:14:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220401051444epcas5p33affb4dc505675a890c3b4c1e21ac0f5~hrdixZ73L1487714877epcas5p3c;
        Fri,  1 Apr 2022 05:14:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220401051444epsmtrp1a5a17c97637bc71bbac3f1b953504e10~hrdiwb9W30435804358epsmtrp1b;
        Fri,  1 Apr 2022 05:14:44 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-1d-62468a45a05a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.32.03370.44A86426; Fri,  1 Apr 2022 14:14:44 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220401051442epsmtip1ef15f4a13ad7526b4990e8202be216fe~hrdg6HM9O3041330413epsmtip1b;
        Fri,  1 Apr 2022 05:14:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'kernel test robot'" <lkp@intel.com>
In-Reply-To: <20220331194526.52444-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] pinctrl: samsung: staticize fsd_pin_ctrl
Date:   Fri, 1 Apr 2022 10:44:41 +0530
Message-ID: <000a01d84587$661eb6a0$325c23e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHzvMFjJH2rpLTrq9uN+E9KR2gT2QKFP4/HrI9q6lA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmuq5rl1uSQc8nNosD7w+yWJw/v4Hd
        Yu/rrewWU/4sZ7LY9Pgaq8Xm+X8YLS7vmsNmMeP8PiaLV82P2CwOv2lntVi16w+jA7fHzll3
        2T0W73nJ5LFpVSebx51re9g8Ni+p9+jbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv
        4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAblRTKEnNKgUIBicXFSvp2NkX5pSWpChn5
        xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR0tfewF2/kr+r+3sTUw7uLtYuTg
        kBAwkZhx262LkYtDSGA3o8SPA33MEM4nRol3L/azQTifGSUm/tvB2MXICdax4MsPJhBbSGAX
        o8Sxn6EQRS8ZJQ6uOg6WYBPQldixuA2sW0RgPbNEw5dtYN3MApoSC2a9YQGxOQVcJD5t6gOz
        hQVsJY5u3M4OYrMIqEjceLqDFcTmFbCUmDflBwuELShxcuYTFog58hLb385hhrhIQeLn02Vg
        9SICVhLvux+xQtSIS7w8eoQdouYIh8TfRyEQP7tIzLvrDhEWlnh1fAtUiZTEy/42dogSD4lF
        f6QgwhkSb5evh/rdXuLAlTksICUgn6zfpQ+xiE+i9/cTJohOXomONiGIalWJ5ndXWSBsaYmJ
        3d2sELaHxNZft1knMCrOQvLWLCRvzUJy/iyEZQsYWVYxSqYWFOempxabFhjmpZbDIzs5P3cT
        Izj5annuYLz74IPeIUYmDsZDjBIczEoivFdjXZOEeFMSK6tSi/Lji0pzUosPMZoCw3ois5Ro
        cj4w/eeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cAU+e38P4nF
        7JUMn6wtj57KP6Z3YXuom+++rDdsNz9ITG8smhO61kPCkanwmTLrvnshLIdX7bPIn1a0iHdf
        7QO1V/8XyPt/LzALsshtjGzdekT9xewpGScrX0/WfzPpy9H503YfmfA50X76gwMiNm9jOQS4
        VVPryjqO8KlM4z3642WDAeuhe3nB80Tq+RU53vVt2VTG3/7FTmmByv1NCx4d1ulOLpp5dMfp
        U5NlvnWImzmuufVwIvfxTXZCi+tkm1dUaDWyr0zeOmV23kGhnSmsLRrze7QPMFZbJH/plFEv
        6zkctfnM47vZl/hfSV8SyliQfP6T3zbflYtDlX6efRFwf4c5r5sax4tDZTlys2/vUWIpzkg0
        1GIuKk4EAES9xotHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnK5Ll1uSwYo7ahYH3h9ksTh/fgO7
        xd7XW9ktpvxZzmSx6fE1VovN8/8wWlzeNYfNYsb5fUwWr5ofsVkcftPOarFq1x9GB26PnbPu
        snss3vOSyWPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZHS197AXb
        +Sv6v7exNTDu4u1i5OSQEDCRWPDlB1MXIxeHkMAORol1XS0sEAlpiesbJ7BD2MISK/89Z4co
        es4ocerLAkaQBJuArsSOxW1sIAkRge3MEg8OTQPrZhbQlFgw6w0LRMdURomGo/1sIAlOAReJ
        T5v6wIqEBWwljm7cDraCRUBF4sbTHawgNq+ApcS8KT9YIGxBiZMznwDZHEBD9STaNjJCzJeX
        2P52DjPEdQoSP58uA2sVEbCSeN/9iBWiRlzi5dEj7BMYhWchmTQLYdIsJJNmIelYwMiyilEy
        taA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOBK1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeq7Gu
        SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw+TPxZdRs
        jn93YvvOy6+nRhSHLdTa32Xgssut6KD1kwkukaVnE1b6ua8N+CU388eBr+w/cvV7pr6dXaTf
        XRjuf4i/61icdMjCzfYH8k9t/O4afevX0byXCpdm9Hk75aRc95yYqsWbUSE/M74k6BtLW9bn
        s1U734QU+uybub1cb/3N5wva1LKe6QvmzT2vb+XVGi9x88aUzykWrUqP9n6/fU2jmTFd9l+Q
        nMF9/5+eTubSPqbHFLomv5xrkxVUk2Dksii+m62t93K4ct/ik99mfZ6tJb565qwVO4IWReTN
        3//yzKqXHhfOMVtWZHCHi6hVXU5LdVvQ+EvvWQzH+V8tn8sCTNXWuS4/9lzz8QEZJZbijERD
        Leai4kQAsOFjtzMDAAA=
X-CMS-MailID: 20220401051444epcas5p33affb4dc505675a890c3b4c1e21ac0f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220331194535epcas5p12503b9e75eb7e1147c1f6ab4548756ac
References: <CGME20220331194535epcas5p12503b9e75eb7e1147c1f6ab4548756ac@epcas5p1.samsung.com>
        <20220331194526.52444-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, April 1, 2022 1:15 AM
>To: Tomasz Figa <tomasz.figa@gmail.com>; Krzysztof Kozlowski
><krzk@kernel.org>; Sylwester Nawrocki <s.nawrocki@samsung.com>; Alim
>Akhtar <alim.akhtar@samsung.com>; Linus Walleij <linus.walleij@linaro.org>;
>Ajay Kumar <ajaykumar.rs@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>gpio@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; kernel test robot
><lkp@intel.com>
>Subject: [PATCH] pinctrl: samsung: staticize fsd_pin_ctrl
>
>struct fsd_pin_ctrl is not used outside of the file, so it can be made
static.  This
>fixes sparse warning:
>
>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c:773:31: sparse:
>    symbol 'fsd_pin_ctrl' was not declared. Should it be static?
>
>Reported-by: kernel test robot <lkp@intel.com>
>Fixes: 0d1b662c374c ("pinctrl: samsung: add FSD SoC specific data")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Thanks Krzysztof.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>index d291819c2f77..cb965cf93705 100644
>--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>@@ -770,7 +770,7 @@ static const struct samsung_pin_bank_data
>fsd_pin_banks2[] __initconst = {
> 	EXYNOS850_PIN_BANK_EINTN(3, 0x00, "gpq0"),  };
>
>-const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
>+static const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
> 	{
> 		/* pin-controller instance 0 FSYS0 data */
> 		.pin_banks	= fsd_pin_banks0,
>--
>2.32.0


