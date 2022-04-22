Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23E50C11D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiDVVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiDVVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:37:37 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DD108418;
        Fri, 22 Apr 2022 13:38:37 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e5e433d66dso9826008fac.5;
        Fri, 22 Apr 2022 13:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gc9s0Nu7Dy/f5W0uxa+JhgkFQnmycRULJWoNHmae7s=;
        b=ncaO34IJogP1mgaQ3nbV7FVqEO7jjCRXrmDhouJnUUMJ5xrYuIsHu9zYvqM7e/lANx
         iS+uucK5ze7WiIbHNESTa4E9spsA9psXg9Fha/98LujYvOA16QMKQ72W8QxRypmskmO+
         Wuqb3gvfEexyzBXkXMFK5ptt8rgrgMo3G3WcSr171pV0jrYtW8BmYqrpXEe6CRT4Tue4
         uOYlDzVVtG5tPBt44LAIMjzTtsn4585YyhnvTMk+w1zYrgVyVP7HuGGWPAXpCurodvAz
         Mp5MAj5nObUACMBTEMtWUsVz6uIl/wBewjHeXNsE+laRPn6djRfga01Hblwi4ullI19N
         Wl+g==
X-Gm-Message-State: AOAM531kviFrfwDo/qYgA5HV3m+Yqbi42K5OgrzeMVxpQFTf6psizYrf
        DE/e3ofm487Y6skRkbF+ONRu/P28Jg==
X-Google-Smtp-Source: ABdhPJy1+14fIkK9Z0u5jvsEPpFvTFjZbVR5xwcjkuW3Qq+dGls5tB9qudMev6OqfOIz/ed6iA+g2g==
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id a22-20020a056870619600b000e1e1a25c65mr2782990oah.190.1650655278243;
        Fri, 22 Apr 2022 12:21:18 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id bd32-20020a056870d7a000b000d43d4d2de1sm937317oab.5.2022.04.22.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:21:17 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: iommu: Drop client node in examples
Date:   Fri, 22 Apr 2022 14:21:03 -0500
Message-Id: <20220422192104.2591462-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to show consumer side in provider examples. The ones
used here are undocumented or undocumented in schemas which results in
warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ----------
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml      | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 97e8c471a5e8..e0389539194f 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -173,13 +173,3 @@ examples:
                              <&larb3>, <&larb4>, <&larb5>;
             #iommu-cells = <1>;
     };
-
-  - |
-    #include <dt-bindings/memory/mt8173-larb-port.h>
-
-    /* Example for a client device */
-    display {
-           compatible = "mediatek,mt8173-disp";
-           iommus = <&iommu M4U_PORT_DISP_OVL0>,
-                    <&iommu M4U_PORT_DISP_RDMA0>;
-     };
diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
index 783c6b37c9f0..672a0beea600 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
@@ -86,16 +86,6 @@ examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
 
-    gsc_0: scaler@13e00000 {
-      compatible = "samsung,exynos5-gsc";
-      reg = <0x13e00000 0x1000>;
-      interrupts = <0 85 0>;
-      power-domains = <&pd_gsc>;
-      clocks = <&clock CLK_GSCL0>;
-      clock-names = "gscl";
-      iommus = <&sysmmu_gsc0>;
-    };
-
     sysmmu_gsc0: iommu@13e80000 {
       compatible = "samsung,exynos-sysmmu";
       reg = <0x13E80000 0x1000>;
-- 
2.32.0

