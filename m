Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7014CD2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiCDKxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiCDKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:53:20 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB182C120
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:52:30 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220304105224epoutp0385d13cd7f56cc0ce3cae010c95f4f3e6~ZKAXpQl_Q2658626586epoutp03f
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:52:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220304105224epoutp0385d13cd7f56cc0ce3cae010c95f4f3e6~ZKAXpQl_Q2658626586epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646391144;
        bh=IqjGG5gTAEe8MAFYqpzVbmWNZh7XqdnqmK39BGPv7iA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=jsVVDBc1Ghqu1wwiAToFsc34ZtbZpcrGf0I0uMHwp0TLjeHjnPcTbcHp5C4j/giAU
         PJRtMp2ma4VMilBStBpTCoQfDdN8VqDtlnia1YSfKBSgvIy/wbASKjaPGU3uCMCvl0
         DZ1cPusFz2BuQ8lQ6TstGJ4ma+pNBQTj8OjRKDek=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220304105224epcas5p27f971c1f2927d860aa1ac26eb706b93f~ZKAXNZENN2471624716epcas5p2j;
        Fri,  4 Mar 2022 10:52:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K94S16Dl7z4x9QP; Fri,  4 Mar
        2022 10:52:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.A5.46822.13DE1226; Fri,  4 Mar 2022 19:42:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220304105203epcas5p4bad72af5c65a394c985594d27d43aa22~ZKADziS8w2870828708epcas5p4R;
        Fri,  4 Mar 2022 10:52:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220304105203epsmtrp247d5aa702c85b46d3bc702d30562b9d4~ZKADyzdtg1618816188epsmtrp2V;
        Fri,  4 Mar 2022 10:52:03 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-64-6221ed31969a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.06.29871.35FE1226; Fri,  4 Mar 2022 19:52:03 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220304105201epsmtip2362eb481517d156b079bb5fce9e31ab3~ZKACi83JK2530825308epsmtip2y;
        Fri,  4 Mar 2022 10:52:01 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: describe known
 hardware and its interrupts
Date:   Fri, 4 Mar 2022 16:22:00 +0530
Message-ID: <000001d82fb5$e1c43d30$a54cb790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQAsgU4oHbexaMbuAER6VWMFWIAhCQJxTl5cr/LdYGA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmhq7hW8Ukg4snNCzmfZa1mH/kHKvF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZtO49wm6xedNUZgcOj1kNvWwem1Z1snncubaHzePduXPs
        HpuX1Ht83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITujZ/cFtoInUhXvH1o1ML4W7mLk5JAQMJH4PGc/SxcjF4eQwG5GielXXkM5
        nxglbn5azQbhfGOU+D/lKhtMS+/cfawQib2MEh/vdEBVvWSU2LhvHjNIFZuArsSOxW1gCRGB
        S0wSJzpamEASnAIeEqfXtYGNEhbIlHjc8okFxGYRUJFY/2QlI4jNK2ApcaFtCRuELShxcuYT
        sBpmAXmJ7W/nMEOcoSDx8+kyVhBbRMBKYumRp+wQNeISL48eYQdZLCEwk0Pi0rROFogGF4n9
        vU1QPwhLvDq+hR3ClpL4/G4vUJwDyM6W6NllDBGukVg67xhUq73EgStzWEBKmAU0Jdbv0odY
        xSfR+/sJE0Qnr0RHmxBEtapE87urUJ3SEhO7u1khbA+JlS/OQQNuNqNE++4WtgmMCrOQfDkL
        yZezkHwzC2HzAkaWVYySqQXFuempxaYFRnmp5fAIT87P3cQITq1aXjsYHz74oHeIkYmD8RCj
        BAezkgivpaZCkhBvSmJlVWpRfnxRaU5q8SFGU2DQT2SWEk3OByb3vJJ4QxNLAxMzMzMTS2Mz
        QyVx3tPpGxKFBNITS1KzU1MLUotg+pg4OKUamHpmT2KV+trWkb0tecL9CKW5tTNtVn5LOyzr
        5fWs4bDlqqdcBw5P6fdac2frvtTdqnN/2rT+0N7zoXmZC4vJzu+ROwwdXe62Hzy4U2LT6h6R
        ggvarzZp/vVovTtlc4DttsIqCQeVO/UXztxfuVTwqOdDhvSaE5x2EyRer7GznPCdXdV/5Zx0
        xuYqjhrVcwXv6r8ESt+t5dg9x6Zzyv53tusqdqbOcJ7XnC74u/8TQ3942ez1XlLdmybGHOUJ
        DD8U8+xa6fUZa52qWvb9W7tYyuvqq8qY88XCs2y4Dr4IVJ7nZWbTrRfGEJdgeer4rI8RhWnq
        dtfs181dIc5R9Ir3UWTFi3aPI/kRzEkKNf75z5VYijMSDbWYi4oTAXY1lBE2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvG7we8Ukg999fBbzPstazD9yjtVi
        49sfTBabHl9jtbi8aw6bxYzz+5gsWvceYbfYvGkqswOHx6yGXjaPTas62TzuXNvD5vHu3Dl2
        j81L6j0+b5ILYIvisklJzcksSy3St0vgyujZfYGt4IlUxfuHVg2Mr4W7GDk5JARMJHrn7mPt
        YuTiEBLYzSjxeeFmNoiEtMT1jRPYIWxhiZX/nrNDFD1nlNi0qJERJMEmoCuxY3EbG0hCROAG
        k8T0AzeZIKpmMkp07v4NNopTwEPi9Lo2MFtYIF3i4s1/YN0sAioS65+sBLN5BSwlLrQtYYOw
        BSVOznzC0sXIwcEsoCfRthGshFlAXmL72znMEBcpSPx8uowVxBYRsJJYeuQpO0SNuMTLo0fY
        JzAKzUIyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwFGlp
        7mDcvuqD3iFGJg7GQ4wSHMxKIryWmgpJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTDVOasGL3BfoyPfobLxQInAHp57haYXbtiZLBQODfNS0J8dd/3r
        7DXMisd5toackhY4e9Z7qcoU9h4Bs801u97cDFjceHfZXa/v73q3vBW6IJDOwPrar3aeVn3S
        18P+TSX9Ww9+2Hg94/2MrVXhVoEng84uZFF4c6rSmXvxJN78uRYXXLerZB+Q9O5IveTkt8Fa
        5cCff5P8c5fercv/Y8a2bBHzn+dX/rSGGO+rcIh+3uS7ozbSx8B649RW+//X81lVjb3qXz/8
        tiStJLNdW/PUlaJ6txPv1PJDDrrN3rD4fOq9txeez5iy+HF5V/NDOX1t1+kTtxrt0/r+vaN8
        9ssLgaz7fe8nLVgo8lZm7n5uJZbijERDLeai4kQAxhTn8hEDAAA=
X-CMS-MailID: 20220304105203epcas5p4bad72af5c65a394c985594d27d43aa22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220225180401epcas5p35d6c09ca6da36289d66d1bb0dcdeffa1
References: <CGME20220225180401epcas5p35d6c09ca6da36289d66d1bb0dcdeffa1@epcas5p3.samsung.com>
        <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Friday, February 25, 2022 9:07 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Subject: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: describe known
>hardware and its interrupts
>
>Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer block,
>so only two compatibles were used so far (for Exynos4210 and
>Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
>However the Exynos4210 flavor actually differs by number of interrupts.
>
>Add new compatibles, maintaining backward compatibility with Exynos4210,
and
>constraints for number of interrupts.  This allows to exactly match the
Exynos
>MCT hardware.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
> .../timer/samsung,exynos4210-mct.yaml         | 55 ++++++++++++++++++-
> 1 file changed, 52 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>index f11cbc7ccc14..d4e23fd7a1da 100644
>--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
>+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yam
>+++ l
>@@ -19,9 +19,20 @@ description: |+
>
> properties:
>   compatible:
>-    enum:
>-      - samsung,exynos4210-mct
>-      - samsung,exynos4412-mct
>+    oneOf:
>+      - enum:
>+          - samsung,exynos4210-mct
>+          - samsung,exynos4412-mct
>+      - items:
>+          - enum:
>+              - samsung,exynos3250-mct
>+              - samsung,exynos5250-mct
>+              - samsung,exynos5260-mct
>+              - samsung,exynos5420-mct
>+              - samsung,exynos5433-mct
>+              - samsung,exynos850-mct
>+              - tesla,fsd-mct
>+          - const: samsung,exynos4210-mct
>
>   clocks:
>     minItems: 2
>@@ -63,6 +74,44 @@ required:
>   - interrupts
>   - reg
>
>+allOf:
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            const: samsung,exynos3250-mct
>+    then:
>+      properties:
>+        interrupts:
>+          minItems: 8
>+          maxItems: 8
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            const: samsung,exynos5250-mct
>+    then:
>+      properties:
>+        interrupts:
>+          minItems: 6
>+          maxItems: 6
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - samsung,exynos5260-mct
>+              - samsung,exynos5420-mct
>+              - samsung,exynos5433-mct
>+              - samsung,exynos850-mct
>+    then:
>+      properties:
>+        interrupts:
>+          minItems: 12
>+          maxItems: 12
>+

Probably you can update the list for tesla,fsd-mct as well in this patch
(as the support was added recently)

> additionalProperties: false
>
> examples:
>--
>2.32.0


