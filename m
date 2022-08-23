Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B559E965
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiHWRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiHWRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:48 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B60AC25E;
        Tue, 23 Aug 2022 07:57:45 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id v12-20020a9d7d0c000000b00638e210c995so9924421otn.13;
        Tue, 23 Aug 2022 07:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KlgGuD4Ropt00q+3PBD1uO0vFomMoCDePQdd5wGHVIY=;
        b=ccCtbFfrJgeLnsDaEbi64bsmbwbDc/eGm4MT7R2HiXoUXAWnJma4wYJibCuoAqj81u
         qyNKRFNTC+liOX/5Ju9QfWBW7ST/DisTH809V05gYezRA55nK9JutVksxtpRlNkKiyiV
         ynhZWc4+VJdLv0BVa7cebvf+q+xz+YRAWCucdjs1nxwYnAgK0O/WLMMUOWthXEdlg+S6
         05EZ4TbAUWbsIsSgl/qtJkK0c9U0iE1KEmX5CRZVSKzVkyXVUpCdKEzImo6DT4MC00Ol
         hra7C+avAhmVhKQpE/dYd4HoHlMiJ0AwmNPSDf6morZS948iD8F3icK5aCT4A11UeKQx
         j0vw==
X-Gm-Message-State: ACgBeo2rgapze7Nwy+l2RDYM1wfJp5/qQjJsLpLm6z42iIrqKs9Yr4jR
        NP4FY7oCMet0uJ9ZXXjtqQ==
X-Google-Smtp-Source: AA6agR674PIV086rHGCdQdraD7gGhkGpmf9VvJELSNqfoV3WZUxBi5lkBuO7P2w4Ehae1rDXBZan0g==
X-Received: by 2002:a9d:5508:0:b0:636:ee02:ff7c with SMTP id l8-20020a9d5508000000b00636ee02ff7cmr9920439oth.249.1661266664456;
        Tue, 23 Aug 2022 07:57:44 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: opp: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:48 -0500
Message-Id: <20220823145649.3118479-17-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 1 +
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index 59663e897dae..a202b6c6561d 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -40,6 +40,7 @@ properties:
 patternProperties:
   '^opp-?[0-9]+$':
     type: object
+    additionalProperties: false
 
     properties:
       opp-hz: true
diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index 14a7a689ad6d..df8442fb11f0 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -19,6 +19,7 @@ properties:
 patternProperties:
   '^opp-?[0-9]+$':
     type: object
+    additionalProperties: false
 
     properties:
       opp-level: true
-- 
2.34.1

