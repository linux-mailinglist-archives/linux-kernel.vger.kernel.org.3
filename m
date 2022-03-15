Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8384DA0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350390AbiCORDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiCORD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:03:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD6580C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:02:15 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220315170214epoutp03f061cf1fff876af863006efa2ffcd044~cnJac2erD1968219682epoutp03Z
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220315170214epoutp03f061cf1fff876af863006efa2ffcd044~cnJac2erD1968219682epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647363734;
        bh=VESMb3rAMIAUAY9mid/3f+3njlkjcjxCVvw2x1Oj3nA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=EukwgK0h8JuAJo2K6GyVpny6w4XVzMsFs4XOT65Dw/cROaZdnS0mFDMUkkpU8xNME
         km8jhvp7WIUUUfDImXARHU18da3hwI5BL0OQ5xTIPhsNGm2GdVZ/LMP1HkscbaUsio
         dSUtIUCNfkCXkqzqleMfC5fbIE+lcmK8mR1kIJyA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220315170213epcas5p282de7a24b7485ace181c3e38df1a6486~cnJZ54eQT2791127911epcas5p2J;
        Tue, 15 Mar 2022 17:02:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KJ07j1h8xz4x9Pv; Tue, 15 Mar
        2022 17:02:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.A4.12523.196C0326; Wed, 16 Mar 2022 02:02:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220315170208epcas5p150748d4782e6c146900067156e752a7c~cnJVDSopC0356203562epcas5p1e;
        Tue, 15 Mar 2022 17:02:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220315170208epsmtrp1d51a9783c36d4c84f77e7c21c083d026~cnJVCct-l1691216912epsmtrp1E;
        Tue, 15 Mar 2022 17:02:08 +0000 (GMT)
X-AuditID: b6c32a4a-5a1ff700000030eb-ed-6230c69195ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.CE.03370.096C0326; Wed, 16 Mar 2022 02:02:08 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220315170207epsmtip23b86591d68f3e44bab430ab6c43cedcb~cnJTs12y52321423214epsmtip2O;
        Tue, 15 Mar 2022 17:02:07 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 1/5] ARM: dts: exynos: align EHCI/OHCI nodes with
 dtschema on Exynos4
Date:   Tue, 15 Mar 2022 22:32:06 +0530
Message-ID: <063601d8388e$67b4c000$371e4000$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDbofKdOjbn+bqlGGr32iIPCHXdeQB7dPZKrrX9JfA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmuu7EYwZJBhsb2SzmHznHatG8eD2b
        xctZ99gsNr79wWSx6fE1VovLu+awWcw4v4/JYtGyVmaL1r1H2B04PWY19LJ5bFrVyeaxf+4a
        do/NS+o9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCd0Xt/BnPBOt6Klk3PWRsYV3B3MXJySAiYSJzov8/UxcjFISSwm1Fi4p6V
        bBDOJ0aJ0ws/MEI4nxkltnU1scK0PPixih0isYtR4tmUC+wgCSGBl0BOmyWIzSagK7FjcRvY
        KBGBX0wSaxtugHVzCnhI/Pr1CaxBWCBaYs3SVYwgNouAqsSTty+YQWxeAUuJM4f+s0HYghIn
        Zz5hAbGZBeQltr+dwwxxhYLEz6fLwGaKCFhJ/O96AFUjLvHy6BGw6yQEpnJInN/9FarBRWJC
        Sy8LhC0s8er4FnYIW0riZX8bkM0BZGdL9OwyhgjXSCyddwyq3F7iwJU5LCAlzAKaEut36UOs
        4pPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3dBw85DoXrodGtSzGSVOTprIPoFRYRaSL2ch
        +XIWkm9mIWxewMiyilEytaA4Nz212LTAKC+1HB7hyfm5mxjByVXLawfjwwcf9A4xMnEwHmKU
        4GBWEuE980I/SYg3JbGyKrUoP76oNCe1+BCjKTDoJzJLiSbnA9N7Xkm8oYmlgYmZmZmJpbGZ
        oZI47+n0DYlCAumJJanZqakFqUUwfUwcnFINTBpdsxaGlJU+XekaFmpiLvn3QUySZPcr/j35
        +y/XfroSufDRbLdP0cphZ3YxuR/8+zNaqlTv6IJvcRGVxhPvJMefthXOWqPk4B+rnXGY5TPn
        m7mfrqqmld5o6mY/wXYjtsOuS3qWwM3ZGX8+MF4Rv37p5pZAM/vDBR+vBCfP3LV5WlMWU9jn
        3Osnnk4MT+bWn1RRV9Lkl+YXtkZG+23LdqOjF1e/Ftnsdey9VbGaR3zklVPfN8Rovftb5rnm
        PIdrxqyvjL9Y3DPfvq+Z9W3no5WvJx29175H05ffdv3h952XWtqYCvbKXT2t/mpZpd9Lr2tn
        LDYFHM6bKfTryY5vMsm7OCUO/2uZVeYmIfTkvqcSS3FGoqEWc1FxIgDQXjgfNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvO6EYwZJBnuOyVrMP3KO1aJ58Xo2
        i5ez7rFZbHz7g8li0+NrrBaXd81hs5hxfh+TxaJlrcwWrXuPsDtwesxq6GXz2LSqk81j/9w1
        7B6bl9R7fN4kF8AaxWWTkpqTWZZapG+XwJXRe38Gc8E63oqWTc9ZGxhXcHcxcnJICJhIPPix
        ir2LkYtDSGAHo8SR7TuYIRLSEtc3TmCHsIUlVv57DlX0nFFiw71/YAk2AV2JHYvb2EBsEYEG
        ZokrjwUgimYySsw6fxisiFPAQ+LXr09gtrBApET/5edgG1gEVCWevH0BZvMKWEqcOfSfDcIW
        lDg58wlLFyMHB7OAnkTbRkaQMLOAvMT2t3OgjlOQ+Pl0GSvEXiuJ/10PWCBqxCVeHj3CPoFR
        aBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC40hLawfj
        nlUf9A4xMnEwHmKU4GBWEuE980I/SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Ykl
        qdmpqQWpRTBZJg5OqQYmm9SsDwy1B/YfzRR47HOI41hY0NcOJ4736m8C5n010DVd/Uk6uENg
        s+0rbTv1S4GxW25u8WKwuc3Cp718pc0Kx7dWF28/CjxqpbQj9t9EV9+I56xsUemMVbknPu14
        v8eY3190u4M+R5ioZTWzF7dfWtNrnf91N1I1A1gW7v6gMmGNt4ynvNfd9RfVAwWnWC4SFkoo
        4+Xk1g17fi+pfUu+lI1QwaPtCuy3kzfsXrzw/Lf1Ml0hmxaxGkkxXA+/u3hGq/CsypfLDAMu
        v1fr2bJdVC2SuWBuepjo9pifCy6t3MP9fpOq3paynzrie0JvWh56VqxhsWXFw41njfoM2/iT
        HQMFnketeHDJesKcU9+VWIozEg21mIuKEwHdqLF/EgMAAA==
X-CMS-MailID: 20220315170208epcas5p150748d4782e6c146900067156e752a7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314182016epcas5p1d733fcbac5bd4a0f554e7f601c399b5e
References: <CGME20220314182016epcas5p1d733fcbac5bd4a0f554e7f601c399b5e@epcas5p1.samsung.com>
        <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Monday, March 14, 2022 11:50 PM
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Alim
>Akhtar <alim.akhtar@samsung.com>; linux-usb@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>Subject: [PATCH 1/5] ARM: dts: exynos: align EHCI/OHCI nodes with dtschema
>on Exynos4
>
>The node names should be generic and USB DT schema expects "usb" names.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm/boot/dts/exynos4.dtsi | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos4.dtsi
>b/arch/arm/boot/dts/exynos4.dtsi index e81b3ee4e0f7..5fd17bc52321 100644
>--- a/arch/arm/boot/dts/exynos4.dtsi
>+++ b/arch/arm/boot/dts/exynos4.dtsi
>@@ -373,7 +373,7 @@ hsotg: hsotg@12480000 {
> 			status = "disabled";
> 		};
>
>-		ehci: ehci@12580000 {
>+		ehci: usb@12580000 {
> 			compatible = "samsung,exynos4210-ehci";
> 			reg = <0x12580000 0x100>;
> 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>@@ -384,7 +384,7 @@ ehci: ehci@12580000 {
> 			phy-names = "host", "hsic0", "hsic1";
> 		};
>
>-		ohci: ohci@12590000 {
>+		ohci: usb@12590000 {
> 			compatible = "samsung,exynos4210-ohci";
> 			reg = <0x12590000 0x100>;
> 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>--
>2.32.0


