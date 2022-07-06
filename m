Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3985686AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiGFLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiGFLX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:23:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919FEAD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:23:24 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220706112322epoutp027d645ce50048fa4e393d157bd9b4bed3~-OazywJgB2008820088epoutp02N
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220706112322epoutp027d645ce50048fa4e393d157bd9b4bed3~-OazywJgB2008820088epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657106602;
        bh=dfUBcYQXdUrModIFjRat22irHZxbZCkVZLeW9qUuQ7g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SygnOOAsQCz2/2WGFiTQGBZy13ixlOZHGFqS8N7PZTy67ccYccWKLKrjkgQaeU/qT
         9ZVCX1TIjHDvQK4XEaHPVlrrSMO3oN/DHzayNqzc4968gv3euZFSHwrXEcnAMUSOm1
         kVf9ttyaMfGtMRfJ0vt6UsatPRJhWSBvu9tl+QVc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220706112322epcas5p3ba1853edd5400e0af9d5486cd485df79~-OazKGjoB1146611466epcas5p3J;
        Wed,  6 Jul 2022 11:23:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LdHGZ5g4Cz4x9Px; Wed,  6 Jul
        2022 11:23:18 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.72.09662.5A075C26; Wed,  6 Jul 2022 20:23:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220706112317epcas5p2bf746fe8180c17e7ce2d0d7b0d45b19c~-OauXyy2A3254232542epcas5p2z;
        Wed,  6 Jul 2022 11:23:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220706112317epsmtrp2e9bbd88042411f6cc15de0a8bb8e6bc7~-OauXE24v0416104161epsmtrp2T;
        Wed,  6 Jul 2022 11:23:17 +0000 (GMT)
X-AuditID: b6c32a49-885ff700000025be-ca-62c570a5fab4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.B6.08802.4A075C26; Wed,  6 Jul 2022 20:23:16 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220706112315epsmtip18760da57ee04c066b9fc2d5317e95e20~-OatOnst41449514495epsmtip17;
        Wed,  6 Jul 2022 11:23:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20220706095037.78542-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/3] dt-bindings: soc: samsung: exynos-pmu: use abolute
 ref paths
Date:   Wed, 6 Jul 2022 16:53:14 +0530
Message-ID: <02d501d8912a$c9dbaa60$5d92ff20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGv0xjueruurOeUsHbvEnIYv28ubAHrzfVgAZn0Pf2tpoDbUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpu7SgqNJBhuuKVpc3q9tMf/IOVaL
        vhcPmS32vt7KbrHp8TVWi8u75rBZzDi/j8mide8RdgcOj02rOtk87lzbw+axeUm9R9+WVYwe
        nzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAw
        MgUqTMjO2LlrIVPBD96Kjx+2sTUw/ufuYuTkkBAwkTg19xtLFyMXh5DAbkaJY+umMYIkhAQ+
        MUrc7nGGSHxmlPh4ejsjTMez7QfYIIp2MUp8XWEFUfSSUeLS6w9gRWwCuhI7FrexgSREBDYx
        SXzZv5cdJMEsoC+xsPMVWBGngIvEyutPWUFsYYFwiUkbljOB2CwCKhIfTr9hBrF5BSwldvx9
        xgRhC0qcnPmEBWKOvMT2t3OYIS5SkPj5dBnYHBEBJ4mljUsYIWrEJV4ePcIOcoSEwFwOibbt
        11kgGlwkdlz+yARhC0u8Or6FHcKWkvj8bi/Q1RxAtofEoj9SEOEMibfL10N9by9x4MocFpAS
        ZgFNifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4q1FJpiYnd3awww+fNjZjAqDgLyV+zkPw1
        C8n9sxB2LWBkWcUomVpQnJueWmxaYJiXWg6P7eT83E2M4FSq5bmD8e6DD3qHGJk4GA8xSnAw
        K4nwrpp0MEmINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wOTeV5JvKGJpYGJmZmZiaWxmaGS
        OK/X1U1JQgLpiSWp2ampBalFMH1MHJxSDUx5uidnKvDoXd96JGtRcGGuz72ZmZ8X6NlbftA+
        /qPbd0Jtso3ou+072vPld5TWh9xm3T6Nuflo8AmeQN/pPE8DfR1Fzwv3M185YMh/syl2csZ+
        A0c/Vac1/zQvC/4wTPp/qHmR/0KuYzqcE2LX5vwOu274WVB46sIcj2t7Q3eJpFWx73kc+vVT
        z7qb0bkbdy6/sqb4XnHVBLm6qudFodpi2a7t1758vd6uZ/9ngVzR9UTW9Zt0xD99vfBZ+dME
        19PCy33jMkv+q/5beWP/Dc4kTY8gWa707UvTE+YuWH+yJNHgy5Z3zwvmSly1eNDtbOC8ZN/J
        K8E/vuSsZ79wS+2X0jfNzROfa38wP5yd/Ha6EktxRqKhFnNRcSIAzDZ9NC4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTndJwdEkg7Z3NhaX92tbzD9yjtWi
        78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7Jo3XuE3YHDY9OqTjaPO9f2sHlsXlLv0bdlFaPH
        501yAaxRXDYpqTmZZalF+nYJXBk7dy1kKvjBW/Hxwza2Bsb/3F2MnBwSAiYSz7YfYOti5OIQ
        EtjBKLG+6TwLREJa4vrGCewQtrDEyn/P2SGKnjNKXJ35FKyITUBXYsfiNrBuEYFtTBKrmv+w
        gSSYBfQlFna+YoToOMso8a1xPStIglPARWLl9adgtrBAqMTHTauYQGwWARWJD6ffMIPYvAKW
        Ejv+PmOCsAUlTs58ArSNA2ionkTbRkaI+fIS29/OYYa4TkHi59NlYCNFBJwkljYugaoRl3h5
        9Aj7BEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiO
        Ki2tHYx7Vn3QO8TIxMF4iFGCg1lJhHfVpINJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2M
        FxJITyxJzU5NLUgtgskycXBKNTDZrXix+d/jyEtvl/zs33RY25Tp6i/RQ3XuT/t8D3Mligu9
        a33nWMK4snrzxI6kGFPe+Gdr6gTVj2Yfil9bp/jj2J6lhw7yuL04Zml8j/9F4I89P7Yz7rr1
        55pxzPkJdlaPgjOUG7bNiilgUv00Y+m9JWc1eqbuU2L+zRgk6rnJ+vcTG91TNvMiJRJ/Twq6
        aFyQ5exrZXTAwN7ilnWZzZrwsCflX9YXPN+6264n8aTNt6PMr0pPVs2qWhXf4Phyp73NhmOr
        fdfVvCqcHq3Qe87js1/UjSmSElOPVNixLL18xFCsWjh6dW3VBX+9Z8Z/9xcF6JyRLr+28MWN
        bBMP0413eP4qF2x6vzdXV9tcYMVGJZbijERDLeai4kQAfHX23RkDAAA=
X-CMS-MailID: 20220706112317epcas5p2bf746fe8180c17e7ce2d0d7b0d45b19c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220706095045epcas5p27a8694a7ba3f4d9af3c1a502235fdbf6
References: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
        <CGME20220706095045epcas5p27a8694a7ba3f4d9af3c1a502235fdbf6@epcas5p2.samsung.com>
        <20220706095037.78542-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Wednesday, July 6, 2022 3:21 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Chanho Park <chanho61.park@samsung.com>; Krzysztof Kozlowski
><krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 2/3] dt-bindings: soc: samsung: exynos-pmu: use abolute ref
>paths
>
>Preferred coding for referencing other schemas is to use absolute path.
>Quotes over path are also not needed.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>index a5d489acfdca..1835ca08416d 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>@@ -75,13 +75,13 @@ properties:
>     const: 3
>
>   syscon-poweroff:
>-    $ref: "../../power/reset/syscon-poweroff.yaml#"
>+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
>     type: object
>     description:
>       Node for power off method
>
>   syscon-reboot:
>-    $ref: "../../power/reset/syscon-reboot.yaml#"
>+    $ref: /schemas/power/reset/syscon-reboot.yaml#
>     type: object
>     description:
>       Node for reboot method
>--
>2.34.1


