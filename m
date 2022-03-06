Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A94CEC72
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiCFRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:21:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9D245AD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 09:20:26 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220306172020epoutp04305ab74922ff63ffd2bfbd0d7c95b810~Z2lpEo7-j2293122931epoutp04L
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:20:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220306172020epoutp04305ab74922ff63ffd2bfbd0d7c95b810~Z2lpEo7-j2293122931epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646587220;
        bh=A7KtOLPZVWFsTO7OyVJwzwhNGBs0pLNxtYLHY9E2064=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Pw6O4R9DeADOuTyYWYE7AtbFH7wn5gS95CTbJKXhFv9jnL9coDGsEVGrPxQkkG4HG
         SSt7ft4azzJ3xZVNs4o1oZPj9iuFm0ZIKU99MOJZsRUC8nTGhmbu8J1EOATEe2BPY/
         3wlGADPwk6vRp5g9v/FuNDLxwRoYUSoeeru+gGqI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220306172018epcas5p269b68ed09ef06e9929a232957712581e~Z2loB3rEI0288402884epcas5p2b;
        Sun,  6 Mar 2022 17:20:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KBSyj4GpNz4x9Pv; Sun,  6 Mar
        2022 17:20:13 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.2E.46822.9CAE4226; Mon,  7 Mar 2022 02:09:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220306172013epcas5p4650d57c16461a6f0934875a396c1df55~Z2lisXH8p0834708347epcas5p4Z;
        Sun,  6 Mar 2022 17:20:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220306172013epsmtrp15653eecf51c292eaf7a54cf168c733a2~Z2lirkx_R0697306973epsmtrp1d;
        Sun,  6 Mar 2022 17:20:13 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-9d-6224eac978bc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.C7.29871.C4DE4226; Mon,  7 Mar 2022 02:20:13 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220306172011epsmtip26592aa2c1d88224622690ca207b7ea3d~Z2lhc-cwI0078500785epsmtip20;
        Sun,  6 Mar 2022 17:20:11 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220304122424.307885-2-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: describe
 known hardware and its interrupts
Date:   Sun, 6 Mar 2022 22:50:10 +0530
Message-ID: <000401d8317e$706f1cc0$514d5640$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF3mhFkGb8Ybu5ilR4JKjDBi+CLBwJb5505Ae63bI6tUXOZYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhu7JVypJBn+n8FjM+yxrMf/IOVaL
        jW9/MFlsenyN1eLyrjlsFjPO72OyaN17hN1i86apzA4cHrMaetk8Nq3qZPO4c20Pm8e7c+fY
        PTYvqff4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbGvNNiBZNkKha+WcLewLhFpIuRg0NCwETi/xe3LkYuDiGB3YwSG399YYJw
        PjFK3Jz2mxnC+cYosezsQ7YuRk6wjll929ggEnsZJb5//AXlvGSUePu8kR2kik1AV2LH4jaw
        hIjAJSaJEx0tTCALOQU8JJ4uEgSpERbIkTjzv5MJxGYRUJF4cGwh2AZeAUuJXRfbmCFsQYmT
        M5+wgNjMAvIS29/OYYa4QkHi59NlrCC2iICTRNPUlYwQNeISL48eYQfZKyEwk0Pi7dJrUA0u
        EhO/zGSHsIUlXh3fAmVLSbzsb2OHBEa2RM8uY4hwjcTSecdYIGx7iQNX5rCAlDALaEqs36UP
        sYpPovf3EyaITl6JjjYhiGpVieZ3V6E6pSUmdnezQtgeEquOnIIG1U1GiW2PZrFOYFSYheTL
        WUi+nIXkm1kImxcwsqxilEwtKM5NTy02LTDKSy2HR3dyfu4mRnBa1fLawfjwwQe9Q4xMHIyH
        GCU4mJVEeO+fV0kS4k1JrKxKLcqPLyrNSS0+xGgKDPqJzFKiyfnAxJ5XEm9oYmlgYmZmZmJp
        bGaoJM57On1DopBAemJJanZqakFqEUwfEwenVAOT5twFiz8d6L9z7HvQnTK9rsgZOusKPpQ8
        3PfqapTslev3hbKUevpfKqzQnXcyZaao++w3nDN0ufNu/mm5vK5G/p1AVVPPzbr1abLPYjUW
        LjX54ug3xTz9zP2HC+XvLA1mWXr80cG38cWCyWcCp5b8XfviS1j746eHWFQ6IkO5nn3aO33J
        NL57Umr5aUv/R7/skEn7dHdnctbCJ4uYAxvPNHL+PfBRr3K+TZyhi22x8NVmBqa/V7XjWB9e
        /vil727vbsbDe3acmmrHxHztZD5LgsKEyIVzW9gmqh3f8s6+gOWg+qRtvuuUo+4v0d4unjEl
        037VsvyExpibFrHiy3dk9m8/22YndULiopPN4uW8W5VYijMSDbWYi4oTAfhQiTg0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvK7vW5UkgwuXmSzmfZa1mH/kHKvF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZtO49wm6xedNUZgcOj1kNvWwem1Z1snncubaHzePduXPs
        HpuX1Ht83iQXwBbFZZOSmpNZllqkb5fAlTHvtFjBJJmKhW+WsDcwbhHpYuTkkBAwkZjVt40N
        xBYS2M0ocfqHLURcWuL6xgnsELawxMp/z4FsLqCa54wSvQ9OgCXYBHQldixuYwNJiAjcYJKY
        fuAmE8Skq4wSrXeiuhg5ODgFPCSeLhIECQsLZEksWLINrJdFQEXiwbGFYIt5BSwldl1sY4aw
        BSVOznzCAtLKLKAn0baRESTMLCAvsf3tHGaIexQkfj5dxgpiiwg4STRNXQlVIy7x8ugR9gmM
        QrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHD9amjsY
        t6/6oHeIkYmD8RCjBAezkgjv/fMqSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8s
        Sc1OTS1ILYLJMnFwSjUwObIWuZnt9fDfo3PanW/ixf9TXN0rzwiulJA0eWP5uWCb7reaJ0rf
        PsdaZVfUflFxWb6GcfmOg5cnyC8N4lL6yTOtqi055Evy2QmODyR9nO5/P57xOqlkqkSwwGmd
        46vq5eXtgzrE1ksczJKJ5eJ7uOnwUfEf1j2nds5Xdd1969rirWvu9ld8F87iur/L5tifmUrO
        Wd//bvG1OHpgdQj/h2OmR43Y45gVlL7LCczOLiyb/z1w8dm9HMtnSD24Xbx1Stz2laKPlGfo
        xOxhtX/16NcMnhVnleR+BMXJrf7/6ETBqqd76kxTXrybKTp9S/1EtbOrT01LWpH94pD3kqbN
        Cekv7iUFRH96t2rxp582SbVKLMUZiYZazEXFiQDSaFJ8DgMAAA==
X-CMS-MailID: 20220306172013epcas5p4650d57c16461a6f0934875a396c1df55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220304122515epcas5p2c0835d037d950d786b4da1a19e467eac
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
        <CGME20220304122515epcas5p2c0835d037d950d786b4da1a19e467eac@epcas5p2.samsung.com>
        <20220304122424.307885-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Friday, March 4, 2022 5:54 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Subject: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: describe known
>hardware and its interrupts
>
>Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer
>block, so only two compatibles were used so far (for Exynos4210 and
>Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
>However the Exynos4210 flavor actually differs by number of interrupts.
>
>Add new compatibles, maintaining backward compatibility with Exynos4210,
>and constraints for number of interrupts.  This allows to exactly match the
>Exynos MCT hardware.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> .../timer/samsung,exynos4210-mct.yaml         | 67 ++++++++++++++++++-
> 1 file changed, 64 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
>index f11cbc7ccc14..1584944c7ac4 100644
>--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yam
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
>@@ -63,6 +74,56 @@ required:
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
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - tesla,fsd-mct
>+    then:
>+      properties:
>+        interrupts:
>+          minItems: 16
>+          maxItems: 16
>+
> additionalProperties: false
>
> examples:
>--
>2.32.0


