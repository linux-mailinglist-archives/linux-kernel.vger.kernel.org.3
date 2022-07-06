Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E256869D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGFLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiGFLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:17:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A927FCA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:17:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220706111730epoutp035021d70a02ef48b4b6d7a4bd06ec3e86~-OVrrG17n0958309583epoutp03P
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220706111730epoutp035021d70a02ef48b4b6d7a4bd06ec3e86~-OVrrG17n0958309583epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657106250;
        bh=mEp1Ytia5XfoOiJJahtLIvRrxdq+mPkzPHGdTPXkRiw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WN0Fypv2Tmq+qFWPMArAVfabNDD/xpfyGaSehiXrlu395iy0kLkUENJS4JHswRVp2
         tJu5RuK5pwfFOQWqQ6oT/EeZio//6To4+zeRCC0pd+BIwjMOMbKpNpcZKLClEAGHxu
         fy3WQVzR0b7CIE+9+o827xFuU+Ot83ySfcMq/MWY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220706111730epcas5p203f98539f4163b4894a34fa40836be7f~-OVrQj8WN1410114101epcas5p2F;
        Wed,  6 Jul 2022 11:17:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LdH7n6crwz4x9Q2; Wed,  6 Jul
        2022 11:17:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.21.09662.F3F65C26; Wed,  6 Jul 2022 20:17:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220706111719epcas5p490363d14d75a351f22cc92b420eb551c~-OVhrFm8e0303103031epcas5p4s;
        Wed,  6 Jul 2022 11:17:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220706111719epsmtrp25eb6c825b80b2c1996fbc53cdc7a888d~-OVhqGGCR3210832108epsmtrp2R;
        Wed,  6 Jul 2022 11:17:19 +0000 (GMT)
X-AuditID: b6c32a49-885ff700000025be-3b-62c56f3f6982
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.9A.08905.F3F65C26; Wed,  6 Jul 2022 20:17:19 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220706111718epsmtip120f86c899049ddf5d977882d98e4272c~-OVge1Kst1250112501epsmtip1Y;
        Wed,  6 Jul 2022 11:17:18 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20220706095037.78542-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/3] dt-bindings: soc: samsung: exynos-pmu: add
 reboot-mode
Date:   Wed, 6 Jul 2022 16:47:17 +0530
Message-ID: <02d301d89129$f4e73770$deb5a650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGv0xjueruurOeUsHbvEnIYv28ubAHPHSLqAXpt5KqtqGEx4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhq5D/tEkg21nmSwu79e2mH/kHKtF
        34uHzBZ7X29lt9j0+BqrxeVdc9gsZpzfx2TRuvcIuwOHx6ZVnWwed67tYfPYvKTeo2/LKkaP
        z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnvFn9g6mgn69ideNclgbGKTxdjJwcEgImEjf3nWfpYuTiEBLYzSgxcf15ZgjnE6PE
        oX8/2UGqhAS+MUrcPcUM0/Hj/3Gojr2MEkfWH2SDcF4ySnwF2gFSxSagK7FjcRtYQkRgE5PE
        l/17wUYxC+hLLOx8xQhicwq4SGw/9R+sQVggUOLQyT1gNSwCKhI3u1eDxXkFLCVubb3HBmEL
        Spyc+YQFYo68xPa3c6BOUpD4+XQZK4gtIuAkcWv9ajaIGnGJl0ePsIMcISEwk0Oir2cnE0SD
        i8Tjw6/ZIWxhiVfHt0DZUhKf3+0FauYAsj0kFv2RgghnSLxdvp4RwraXOHBlDgtICbOApsT6
        XfoQq/gken8/YYLo5JXoaBOCqFaVaH53lQXClpaY2N3NCmF7SOzo3MM8gVFxFpLHZiF5bBaS
        B2YhLFvAyLKKUTK1oDg3PbXYtMAwL7UcHt/J+bmbGMHpVMtzB+PdBx/0DjEycTAeYpTgYFYS
        4V016WCSEG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4HJvS8knhDE0sDEzMzMxNLYzNDJXFe
        r6ubkoQE0hNLUrNTUwtSi2D6mDg4pRqYGHjl/B/uYeB9zCZcus+k9u5ehsaXv0u6p71V28ng
        6eaVwRr9cxuz/7YV6/5VLnfl+8rbGZXj/kScPTisdfmMVZsur5nTsONPjrzE+42bd/5L86/y
        Dz9UqrxS4TuHoadJSIvEt2/BZX+PNjLkLd/8LelmfNSJoMq+htgm3qDevKT9HrWmKsvUg/Iv
        VN1yv3ntUHDF9M/NlcUBEQ+1Ak0/fzla86ViqcbT4tOr763IDeW799xSkleLLercySs6LXMn
        u9dcEBPJMKl9s7vp+IQb90Urtl1lvTFZxrHuuPm6S7lRorwbZ6+fIyGht0K1ufOkgN6DN7FJ
        t7i605qv1xzb8ODU5Zc9YVrn4/hm8IYpsRRnJBpqMRcVJwIApBgbjzAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTtc+/2iSQdcEHYvL+7Ut5h85x2rR
        9+Ihs8Xe11vZLTY9vsZqcXnXHDaLGef3MVm07j3C7sDhsWlVJ5vHnWt72Dw2L6n36NuyitHj
        8ya5ANYoLpuU1JzMstQifbsErow3q38wFfTzVaxunMvSwDiFp4uRk0NCwETix//jLF2MXBxC
        ArsZJSYsvcsMkZCWuL5xAjuELSyx8t9zdoii54wSu6dcYQVJsAnoSuxY3MYGkhAR2MYksar5
        DxtIgllAX2Jh5ytGiI6zjBLLTu0FG8Up4CKx/dR/JhBbWMBfYs+xRrB1LAIqEje7V4PFeQUs
        JW5tvccGYQtKnJz5BOg+DqChehJtGxkh5stLbH87B+pSBYmfT5eBHSQi4CRxa/1qqBvEJV4e
        PcI+gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKj
        SktzB+P2VR/0DjEycTAeYpTgYFYS4V016WCSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUw2Xr/9M0OeChRe7eldv2DPdEedL/fLl9TYtFVn51+I4JKM
        6fphHy7PcvjkhZPp0u3ZU5sXO6dNinJWe382/2V5z4I/e9m/fzz+8/HbRUHem4q5azr1rv5P
        iKi4uezq2a0/dd4uXVc2014i8+2ezTKrHqw80y/14bSuvfTv9IKYpuitZe7MB9KOW4Rd7vs7
        +3W3xKEux6sHr8UWOM5X2Modu21C1NtF31OaPMxVRe2TnW5MKxP8lyLE3PY87Pacz4J5M0sY
        Q1v7MjodzCPsZvZbNm0qjVzVLFQbW7Kzps1/JZP96wnCRSIHIzaEtCQv6Yk64XbrwCbvI2o3
        0q51ZNXeU/cP6fLLa5mVy9i9WomlOCPRUIu5qDgRACaaJscZAwAA
X-CMS-MailID: 20220706111719epcas5p490363d14d75a351f22cc92b420eb551c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220706095045epcas5p448dc5cd55b065e5527acca9063439336
References: <20220706095037.78542-1-krzysztof.kozlowski@linaro.org>
        <CGME20220706095045epcas5p448dc5cd55b065e5527acca9063439336@epcas5p4.samsung.com>
        <20220706095037.78542-3-krzysztof.kozlowski@linaro.org>
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
>Sent: Wednesday, July 6, 2022 3:21 PM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Chanho Park <chanho61.park@samsung.com>; Krzysztof Kozlowski
><krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 3/3] dt-bindings: soc: samsung: exynos-pmu: add reboot-mode
>
>ExynosAutov9 gained a reboot-mode node, so document the property to fix
>warning:
>
>  exynosautov9-sadk.dtb: system-controller@10460000: 'reboot-mode' does not
>match any of the regexes: 'pinctrl-[0-9]+'
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> .../devicetree/bindings/soc/samsung/exynos-pmu.yaml         | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>index 1835ca08416d..13bb8dfcefe6 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
>@@ -74,6 +74,12 @@ properties:
>       Must be identical to the that of the parent interrupt controller.
>     const: 3
>
>+  reboot-mode:
>+    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>+    type: object
>+    description:
>+      Reboot mode to alter bootloader behavior for the next boot
>+
>   syscon-poweroff:
>     $ref: /schemas/power/reset/syscon-poweroff.yaml#
>     type: object
>--
>2.34.1


