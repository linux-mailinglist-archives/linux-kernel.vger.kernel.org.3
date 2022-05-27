Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F39535783
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiE0CXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiE0CXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:23:44 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DCEE27A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:23:42 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220527022339epoutp013a4b5d0245636e249c5487bc27897d12~y1QJctlFW1441914419epoutp01T
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:23:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220527022339epoutp013a4b5d0245636e249c5487bc27897d12~y1QJctlFW1441914419epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653618219;
        bh=s2MmHWQpAI5TzBRvIxt2lTABEbM+jnc9MwnjQ5g6Gkk=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=UIqzidW+efYkcuBDALVPrwZze22L3J3fT4Q/OGhAJ9hNt9400gvyIAAjnO+2N1VRI
         qnofE1It/sISB8tNNfX+7j4KF5xnrqdlQkB5+uGyWKFglfMWEOEyJIbCWubKb7W+h+
         Kd4yHWFTEeO/nf+m7GlusihTXFfUdiND50liXuic=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220527022338epcas5p3e800afaa72b71f73647ab56da7a727b6~y1QJECkgh1694716947epcas5p3S;
        Fri, 27 May 2022 02:23:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L8TBH359Cz4x9Q5; Fri, 27 May
        2022 02:23:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.82.09827.52630926; Fri, 27 May 2022 11:23:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220527022333epcas5p44304f5f84734be410e981c73390a470c~y1QD7Cr8n0235002350epcas5p4_;
        Fri, 27 May 2022 02:23:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220527022333epsmtrp24cb6a0e932270d32b5cb0e9b5953bf2d~y1QD6Yiol0125701257epsmtrp27;
        Fri, 27 May 2022 02:23:33 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-d2-629036258078
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.1F.08924.52630926; Fri, 27 May 2022 11:23:33 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220527022332epsmtip1b628263f1036d9e8641082c72a8f9057~y1QCr2OlZ2133521335epsmtip1w;
        Fri, 27 May 2022 02:23:31 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/2] arm64: dts: exynos: adjust whitespace around '='
Date:   Fri, 27 May 2022 07:53:31 +0530
Message-ID: <025601d87170$c324bbf0$496e33d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFpmbHODWxPexdb4OuWVEwoYvb1UgIH/dVSrf9uGzA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmuq6q2YQkg6vHzCzmHznHatH34iGz
        xd7XW9ktNj2+xmpxedccNosZ5/cxWbTuPcLuwO6xaVUnm8eda3vYPDYvqff4vEkugCUq2yYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGyyvP
        WAtW8FS0XWxjbWA8zdXFyMkhIWAicf//fTYQW0hgN6PE1B/eXYxcQPYnRokJL7tYIJzPjBIf
        n/WzwXT8XP+fCSKxi1HizJ4GVgjnJaPEjAXHGUGq2AR0JXYsbmMDSYgIbGKS+LJ/LztIglPA
        VaJx6nOwImEBT4l3G56AxVkEVCW2fbzEBGLzClhKdE+dwwZhC0qcnPmEBcRmFpCX2P52DjPE
        GQoSP58uY4WIi0u8PHoEbI6IgJXEpkV7mUEWSwi0ckismPgFqsFFYumkSewQtrDEq+NboGwp
        ic/v9gIt4wCyPSQW/ZGCCGdIvF2+nhHCtpc4cGUOC0gJs4CmxPpd+hBr+SR6fz9hgujkleho
        E4KoVpVofneVBcKWlpjY3c0KYXtIbF38BRpwMxgl2hdPZZ7AqDALyZezkHw5C8lnsxA2L2Bk
        WcUomVpQnJueWmxaYJSXWg6P8OT83E2M4PSp5bWD8eGDD3qHGJk4GA8xSnAwK4nwXnjamyTE
        m5JYWZValB9fVJqTWnyI0RQY9BOZpUST84EJPK8k3tDE0sDEzMzMxNLYzFBJnFfgf2OSkEB6
        YklqdmpqQWoRTB8TB6dUA1PS7edsCq97bLK0T33fL7Vs0UWtxY9UZjBr5J0JFE2M2url4Hfw
        2+XtJSxvM3q5d+y7L8ZdlSHArdH3fgqHjKPu5ayMZ5qZLEEzNx11+JXf3bXtOcM9T+f6aaW6
        LTNeSt4+tnf/3kUz9dnnX8uN42BauWF62VamWdFyTpHXGNbpCs1nP7fJfv2sD9saInPzb226
        GTlFVCgpoE9Tweh1y/Q+E01TMwb1ZzbGbotU53rM0OOalmb4UV/dldHAgjdqybt7zb/nCZzb
        8zumluGXx0KG2fZH7u9+PrH3XXyTbFzVZlnb7SpPdt8pmHrgfXOQucGebT3nHiQvUFOsOD+z
        8fOk5f1iPQe0d5T9LOdef0WJpTgj0VCLuag4EQCalf9+KAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK6q2YQkg0e9/Bbzj5xjteh78ZDZ
        Yu/rrewWmx5fY7W4vGsOm8WM8/uYLFr3HmF3YPfYtKqTzePOtT1sHpuX1Ht83iQXwBLFZZOS
        mpNZllqkb5fAlfHyyjPWghU8FW0X21gbGE9zdTFyckgImEj8XP+fqYuRi0NIYAejxJp5Oxkh
        EtIS1zdOYIewhSVW/nvODlH0nFFiS8sqZpAEm4CuxI7FbWwgCRGBbUwSq5r/sEFUTWOUuD/1
        PQtIFaeAq0Tj1OdgY4UFPCXebXgCNpZFQFVi28dLTCA2r4ClRPfUOWwQtqDEyZlPgHo5OJgF
        9CTaNoK1MgvIS2x/O4cZ4iIFiZ9Pl7FCxMUlXh49AjZSRMBKYtOivcwTGIVmIZk0C2HSLCST
        ZiHpXsDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhWtLR2MO5Z9UHvECMTB+Mh
        RgkOZiUR3gtPe5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi
        4JRqYFrLM1l2jlj2zuhXJvHZesauZkEH1rz1yT/V+PSqiMFZp5PrD347VGqdHxV3Ycmrdv4D
        +xLkfOTSDsxwqFnE8C259dKWGTv/an7p15qvPkWs3j3mjdKufbbfL83X4JmrF3BX1d1sy6K1
        H9oZjRVV5+xkVzNq+7ZbestfHv577MLP7lo1SW+bdJuvbGbGMfklCa3ivErBD2ac2fJr4ktx
        j3/ihjFRrLEGG1ecl/sXuv9TaOOmtQFp7AXhaTMfd4sWHe6/+kF1omyy3XrmfbzzbZWW7VUO
        b3jHcqBGLGuuj5yWa4NionmfSNE+L6lcA0/hQjHTI8qzNqYWLtrybEeoQfjFXS99PNlWZS5v
        +ydko8RSnJFoqMVcVJwIAG8qP8MEAwAA
X-CMS-MailID: 20220527022333epcas5p44304f5f84734be410e981c73390a470c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220526204331epcas5p1aceb59867294b847de073f397abc3798
References: <CGME20220526204331epcas5p1aceb59867294b847de073f397abc3798@epcas5p1.samsung.com>
        <20220526204323.832243-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, May 27, 2022 2:13 AM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 1/2] arm64: dts: exynos: adjust whitespace around '='
>
>Fix whitespace coding style: use single space instead of tabs or multiple
spaces
>around '=' sign in property assignment.  No functional changes (same DTB).
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>---
>
>Output compared with dtx_diff and fdtdump.
>---
> arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>index 0ce46ec5cdc3..5827e1228fa9 100644
>--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
>@@ -364,7 +364,7 @@ ufs_0_phy: ufs0-phy@17e04000 {
> 		};
>
> 		ufs_0: ufs0@17e00000 {
>-			compatible ="samsung,exynosautov9-ufs";
>+			compatible = "samsung,exynosautov9-ufs";
>
> 			reg = <0x17e00000 0x100>,  /* 0: HCI standard */
> 				<0x17e01100 0x410>,  /* 1: Vendor-specific
*/
>--
>2.34.1


