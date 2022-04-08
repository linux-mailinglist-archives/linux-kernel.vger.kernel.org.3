Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6954F8C73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiDHDFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiDHDFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:05:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2911DD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:03:41 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220408030338epoutp02c1a173d0f00be27880a4437be3935d68~jzMFAFauJ1695116951epoutp02I
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:03:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220408030338epoutp02c1a173d0f00be27880a4437be3935d68~jzMFAFauJ1695116951epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649387018;
        bh=NqnIwYUo6niXNmWjuw14e36GtazGL6Nf5Zv0Vep+wGQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iJasyV43RmJQC/Ajgqu43vfcBKIIgTZcGDu2RsoHFgMvftOj4euURnO2TQgrWv9iM
         eEeHyhA51MxDJCtkhdK2Fjxbclho5ScCmmfkOVoq6EeXCVm31sUYj1r9BpyiV63cvS
         6ChvPdN4gcPaD+iWsyQBOnZv6ftleRWhdvs5nEJE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220408030338epcas5p3ea48e7ae232b11e4415ee868d3ed3087~jzMEKWfBC0231302313epcas5p36;
        Fri,  8 Apr 2022 03:03:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KZNNy36LBz4x9Q1; Fri,  8 Apr
        2022 03:03:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.32.06423.FF5AF426; Fri,  8 Apr 2022 12:03:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220408030327epcas5p44b95cb7b423f1a21b52d250bcf4de4a6~jzL6XASwC3226932269epcas5p4r;
        Fri,  8 Apr 2022 03:03:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220408030327epsmtrp2baaa5716cd2e0f04104662370e67d348~jzL6WR6cq0577705777epsmtrp2e;
        Fri,  8 Apr 2022 03:03:27 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-10-624fa5ff320e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C4.24342.FF5AF426; Fri,  8 Apr 2022 12:03:27 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220408030325epsmtip16e87273227a4af2a00c8ff49367ec743~jzL4Sh8N70208202082epsmtip1Q;
        Fri,  8 Apr 2022 03:03:25 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Rob Herring'" <robh@kernel.org>
In-Reply-To: <20220407192611.15353-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [RESEND PATCH] dt-bindings: usb: samsung,exynos-usb2: include
 usb-hcd schema
Date:   Fri, 8 Apr 2022 08:33:23 +0530
Message-ID: <000001d84af5$37e001e0$a7a005a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFuzieljrADWxPIJnfTI8Y9r+zgewKpefSQraMCHrA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmuu7/pf5JBl+umVrMP3KO1aJ58Xo2
        i74XD5kt9r7eym6x6fE1VovLu+awWcw4v4/JYtGyVmaL1r1H2C3+79nB7sDlsWlVJ5vHnWt7
        2Dz2z13D7rF5Sb3H501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7Izrty5wlawXKji04nHjA2M7fxdjJwcEgImEismnGXvYuTiEBLY
        zSix6OgqVgjnE6PE0UUtLBDON0aJOaua2WFabq7tY4JI7GWUmN1zlBnCecko0b2ghRWkik1A
        V2LH4jY2kISIQBuzxPlJxxhBEswCqhJz/vxiBrE5BVwkfny8A9YgLBAt8fjUJzCbRUBF4t6H
        Z2A2r4ClxKzTCxkhbEGJkzOfsEDMkZfY/nYOM8RJChI/ny4DqxcRsJKY/Gcr1C5xiZdHj4B9
        JyGwkkPiy9urQEUcQI6LxN/jpRC9whKvjm+Bek1K4vO7vWwQJR4Si/5IQYQzJN4uX88IYdtL
        HLgyhwWkhFlAU2L9Ln2ITXwSvb+fMEF08kp0tAlBVKtKNL+7ygJhS0tM7O5mhbA9JO4+2M8y
        gVFxFpK/ZiH5axaS+2chLFvAyLKKUTK1oDg3PbXYtMAwL7UcHt/J+bmbGMFJVstzB+PdBx/0
        DjEycTAeYpTgYFYS4a3K9UkS4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnANJ9XEm9oYmlg
        YmZmZmJpbGaoJM57On1DopBAemJJanZqakFqEUwfEwenVANT2BuLP1y1Z64ynyzo/zrt7bqE
        xC/3bu80mtc9y+TnvNl65Uo/9lzuUop+LLun4Phi3inqi+de3/6r4NQEdQdbw7M2t5betH5f
        ff/b5kfV9gcOst84xNC8NpLbXs2d5YrtFNMThUrluet3GfNx9YYm3bxxpDbJ2Um6J3p26MRN
        23Oq5iRnl3C1PiiN+3VGnWGxUyLb/0nWkhe+3RdcxdZ8l8s1xt1x5aangRvtQ6PES5Y+eePY
        7/Q8JzCtu5737JE03lzZW84HJSeFXGX78ZXz+TqWzUvVudxvT98z+4zIL70UiZlC32RjEkM2
        l5tdrTTevGq5mkfIxIX2y6fv2ZPiFbvr2BPBWYE/f6sdfJjYo8RSnJFoqMVcVJwIALQW1pM7
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvf/Uv8kg54dUhbzj5xjtWhevJ7N
        ou/FQ2aLva+3sltsenyN1eLyrjlsFjPO72OyWLSsldmide8Rdov/e3awO3B5bFrVyeZx59oe
        No/9c9ewe2xeUu/xeZNcAGsUl01Kak5mWWqRvl0CV8aVO1fYCpYLVXw68ZixgbGdv4uRk0NC
        wETi5to+JhBbSGA3o8S6n4IQcWmJ6xsnsEPYwhIr/z0HsrmAap4zSmzb95cRJMEmoCuxY3Eb
        G0hCRKCHWeLf+yNgHcwCqhJz/vxihpg6lVFibZcOiM0p4CLx4+MdVhBbWCBSonl6K9ggFgEV
        iXsfnoHFeQUsJWadXsgIYQtKnJz5hKWLkQNopp5E20ZGiPHyEtvfzmGGOE5B4ufTZWCtIgJW
        EpP/bIWqEZd4efQI+wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIjjMtzR2M21d90DvEyMTBeIhRgoNZSYS3KtcnSYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmCcXJuWxHu2fUzJFRn5GwTv+FwbLvM23y
        Pmw8scM95bn9x8wKkX2Tl6yS4lm+95rcv1faz/XTLTwKAlPCzzB4H5zAeSx3ncqppy+MwoOX
        /2vd1/tv/bNcrodHeHw279t8QOD5x+SjIv+bf3huKRTpdjH+sN5073vW9dJzeSN/Wf5/aXfn
        rm+nnESYNEuMSdqXySbS/htXtPqrnuO5pHRi4VLJQpuo5xHXg2sO/7XSlE5bYbY7q1W49sM0
        h/wmmRMBa0sKtRcaZxmzhLRN23361dMItQ2TVq1U3npl8mSNV6dNnd5IaZZ7X+svFDh85NVu
        W63jv6WnaK7505S14N7CGuPLSQGLW3nr7y3+f0nHQomlOCPRUIu5qDgRACZlYqgiAwAA
X-CMS-MailID: 20220408030327epcas5p44b95cb7b423f1a21b52d250bcf4de4a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220407192621epcas5p12f91bf50c90695f6e4547c7d5fe7037a
References: <CGME20220407192621epcas5p12f91bf50c90695f6e4547c7d5fe7037a@epcas5p1.samsung.com>
        <20220407192611.15353-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, April 8, 2022 12:56 AM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-usb@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Rob Herring
><robh@kernel.org>
>Subject: [RESEND PATCH] dt-bindings: usb: samsung,exynos-usb2: include
>usb-hcd schema
>
>Remove parts duplicated with usb-hcd.yaml DT schema and include it
directly.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Reviewed-by: Rob Herring <robh@kernel.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> .../bindings/usb/samsung,exynos-usb2.yaml         | 15 ++-------------
> 1 file changed, 2 insertions(+), 13 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-
>usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-
>usb2.yaml
>index 340dff8d19c3..d51f91d1139f 100644
>--- a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
>+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
>@@ -15,9 +15,6 @@ properties:
>       - samsung,exynos4210-ehci
>       - samsung,exynos4210-ohci
>
>-  '#address-cells':
>-    const: 1
>-
>   clocks:
>     maxItems: 1
>
>@@ -46,15 +43,6 @@ properties:
>       Only for controller in EHCI mode, if present, specifies the GPIO
that
>       needs to be pulled up for the bus to be powered.
>
>-  '#size-cells':
>-    const: 0
>-
>-patternProperties:
>-  "^.*@[0-9a-f]{1,2}$":
>-    description: The hard wired USB devices
>-    type: object
>-    $ref: /usb/usb-device.yaml
>-
> required:
>   - compatible
>   - clocks
>@@ -64,6 +52,7 @@ required:
>   - phy-names
>
> allOf:
>+  - $ref: usb-hcd.yaml#
>   - if:
>       properties:
>         compatible:
>@@ -73,7 +62,7 @@ allOf:
>       properties:
>         samsung,vbus-gpio: false
>
>-additionalProperties: false
>+unevaluatedProperties: false
>
> examples:
>   - |
>--
>2.32.0


