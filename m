Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB974DA0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350365AbiCORDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350468AbiCORDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:03:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E757B3B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:01:54 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220315170149epoutp02163960477a83be6ece7c31f49e21fee4~cnJDb75ng0296002960epoutp02d
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:01:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220315170149epoutp02163960477a83be6ece7c31f49e21fee4~cnJDb75ng0296002960epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647363709;
        bh=APM5XsSU1XQd07vu+tjYn7WYhHEeAhdWMLL1ugsN9XM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Aw5dAa6R66yRQOdsFj8+XjgfUrkWUrHQPLYHG4lFRvsj5C8hkG5pqEWLzZk9lJOLF
         1l/d3oQMrKE0CdzPpZElDBrjOGAxQ9GQiDzT6PHO82xuSyI/NyrNQaezCT83nWVWj2
         yMSKDh0w7ehURj72m0LvlEAIOuot5tBZ6TB/HnN0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220315170148epcas5p3197505665d1d45755cd7dff5229a8f16~cnJCOvyQQ0601406014epcas5p3G;
        Tue, 15 Mar 2022 17:01:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KJ07C6r60z4x9Pp; Tue, 15 Mar
        2022 17:01:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.74.06423.776C0326; Wed, 16 Mar 2022 02:01:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220315170143epcas5p2d633d14d347a2c2b2c2743450c08abce~cnI9g0xey1706417064epcas5p2H;
        Tue, 15 Mar 2022 17:01:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220315170143epsmtrp1e7ed44caa429ca8723d2755ed3faf782~cnI9f_7Ak1691216912epsmtrp1B;
        Tue, 15 Mar 2022 17:01:43 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-61-6230c6774e31
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.CE.03370.776C0326; Wed, 16 Mar 2022 02:01:43 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220315170141epsmtip2eb5d7f4857fca19018b8d7ca1b718367~cnI8LxV9s2201222012epsmtip2T;
        Tue, 15 Mar 2022 17:01:41 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220314181948.246434-2-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 2/5] ARM: dts: s5pv210: align EHCI/OHCI nodes with
 dtschema
Date:   Tue, 15 Mar 2022 22:31:40 +0530
Message-ID: <063501d8388e$58a74ba0$09f5e2e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQB7dPZKCRCsS+x0KxttMJEPHi23NwGCWbcmAZz2MFCvYTfs4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpm75MYMkgyvrjCzmHznHatG8eD2b
        xctZ99gsNr79wWSx6fE1VovLu+awWcw4v4/JYtGyVmaL1r1H2B04PWY19LJ5bFrVyeaxf+4a
        do/NS+o9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdsXvrYraCdzwVDesLGxhfcXUxcnJICJhIvFi+nAXEFhLYzSix6Fk5hP2J
        UeLMBesuRi4g+zOjRM/mG0BFHGANex/VQ8R3MUpMbbvKCuG8ZJS4u+0sE0g3m4CuxI7FbWwg
        CRGBX0wSaxtusIIkOAU8JHpuLgBbJywQKNE74SpYnEVAVeLf/INsIDavgKXE9VlT2CFsQYmT
        M5+A1TMLyEtsfzuHGeJsBYmfT5eB9YoIOEnsnPkXqkZc4uXRI+wgiyUEZnJIPL9+EKrBRWJn
        1xtWCFtY4tXxLewQtpTEy/42dojXsiV6dhlDhGskls47xgJh20scuDIH7HtmAU2J9bv0IVbx
        SfT+fsIE0ckr0dEmBFGtKtH87ipUp7TExO5uqKUeEhNugVwPCqubjBJXO2cyTWBUmIXky1lI
        vpyF5JtZCJsXMLKsYpRMLSjOTU8tNi0wzEsth8d2cn7uJkZwWtXy3MF498EHvUOMTByMhxgl
        OJiVRHjPvNBPEuJNSaysSi3Kjy8qzUktPsRoCgz6icxSosn5wMSeVxJvaGJpYGJmZmZiaWxm
        qCTOezp9Q6KQQHpiSWp2ampBahFMHxMHp1QDk4z+y+nO66KFkpwP3NnJHlqhwBrBzOIv81HD
        sTZD7Y9Bl2BrtdT1tIMSXVprXwvreJ/M91TbMqWxrvv+6oOL9JSXKzywXPqxVG+b95LcLEtv
        yboX7h8LLXbrMNxmPtpqfeW7c1mhq7jY8ntKnjbPt+7K998xr9upXGGVbtymO6dni2/eKbWr
        3We3x9mzlxOvK66d572FXVTm8evn4arS3/+dufRz20aJlPe2Bz+lbwk0Of2JmV9EuVrL1qil
        V2rlg3DdlZsenzg6j/PMtIXye+wqTYyXqrw83j05onzG8yWv3qvsanLfejsiws5RT342U7Dl
        ucSgwLDV6rF//je4fGxZ7azFq+v7Rid1x1kNJZbijERDLeai4kQAa3UgCTQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvG75MYMkgznL+SzmHznHatG8eD2b
        xctZ99gsNr79wWSx6fE1VovLu+awWcw4v4/JYtGyVmaL1r1H2B04PWY19LJ5bFrVyeaxf+4a
        do/NS+o9Pm+SC2CN4rJJSc3JLEst0rdL4MrYvXUxW8E7noqG9YUNjK+4uhg5OCQETCT2Pqrv
        YuTiEBLYwShxuO86WxcjJ1BcWuL6xgnsELawxMp/z9khip4zSuy92cAKkmAT0JXYsbgNrEFE
        oIFZ4spjAYiiq4wSN8/9ZgZJcAp4SPTcXMACsk1YwF/ixzwmkDCLgKrEv/kHwXp5BSwlrs+a
        wg5hC0qcnPkErJxZQE+ibSMjSJhZQF5i+9s5zBD3KEj8fLqMFWKtk8TOmX9ZIGrEJV4ePcI+
        gVFoFpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjSEtr
        B+OeVR/0DjEycTAeYpTgYFYS4T3zQj9JiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLp
        iSWp2ampBalFMFkmDk6pBqaaq6nHksQ46hmsS8Pf7C869drm79lES/fti1t6NybPreq8EVUy
        MbxEZHdQ/gHVNQuuX655+nvOlDLfJFHrnCPnxBsmvj4qnDRb7VK3YC/7rVn3pP/v+RueEy6a
        81hKWOnAafFVf+WfP+1ad/vOwf1eYmtE3XJbSgRUt7c8aDpYVbtrwWO912oCny36+YPMeufd
        fxe3WE/FZX5+1VvZlr9Lgt5GHpRr19j43dOsqs1c+Jzhw0ZvnTf/sqsC15/Qy0ti+GNWK2d+
        5s9hlbTqWwWx/PO8djyI+sg958rnufc1H4aF9c9g2qXwdWO0vfnvVe0Ot6q0e+W+1p7d8/tD
        r62NXRyT/LWD5pfeFmov26PEUpyRaKjFXFScCADtBNZmDwMAAA==
X-CMS-MailID: 20220315170143epcas5p2d633d14d347a2c2b2c2743450c08abce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314182015epcas5p37973443e3daafcab8b5d45a042f6a56c
References: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
        <CGME20220314182015epcas5p37973443e3daafcab8b5d45a042f6a56c@epcas5p3.samsung.com>
        <20220314181948.246434-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
>Subject: [PATCH 2/5] ARM: dts: s5pv210: align EHCI/OHCI nodes with
>dtschema
>
>The node names should be generic and USB DT schema expects "usb" names.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
Probably you can squash this with the 1/5 patch

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> arch/arm/boot/dts/s5pv210.dtsi | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/boot/dts/s5pv210.dtsi
b/arch/arm/boot/dts/s5pv210.dtsi
>index 353ba7b09a0c..a7aca54832d9 100644
>--- a/arch/arm/boot/dts/s5pv210.dtsi
>+++ b/arch/arm/boot/dts/s5pv210.dtsi
>@@ -427,7 +427,7 @@ usbphy: usbphy@ec100000 {
> 			status = "disabled";
> 		};
>
>-		ehci: ehci@ec200000 {
>+		ehci: usb@ec200000 {
> 			compatible = "samsung,exynos4210-ehci";
> 			reg = <0xec200000 0x100>;
> 			interrupts = <23>;
>@@ -444,7 +444,7 @@ port@0 {
> 			};
> 		};
>
>-		ohci: ohci@ec300000 {
>+		ohci: usb@ec300000 {
> 			compatible = "samsung,exynos4210-ohci";
> 			reg = <0xec300000 0x100>;
> 			interrupts = <23>;
>--
>2.32.0


