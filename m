Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC644C9782
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiCAVGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiCAVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:06:10 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB270CC0;
        Tue,  1 Mar 2022 13:05:28 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso708376ooc.7;
        Tue, 01 Mar 2022 13:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LA63EIWpIZ22OioRlWHUUutV4ScbviS709H8bVJmJVw=;
        b=pTQHDno2TVxEXCEJTsduRzK2MbYJ28YtDyqyH6WzwshIil4LItmhhv5mWLZqX9ZJ/u
         L1ERTiS8TWxJXZ8hwXDQ2OVVYrNgz3qWSU9S8jlTOJtIBRkCAN3GtsL206tR3GrNkzbr
         j0Kq5Q9R2WqEmYiZZSDAL70ptMUT/WWVxowq+SnWT38kH3mcrDrMeNLzW/eNEmUFwbs3
         rSmw/Uv9tjluMZTrVUjX2rSY41Pksv8y/ACS7RiQZUZ0DrJQzgQcc1aBnAGnYNXaI9dW
         LOlF8oojWAfeKA8MoAgnj5yvpW2sqaieNKA2VBde9Hvsoe31T5tBabeVOwwcupu2lRyS
         Q3Ew==
X-Gm-Message-State: AOAM5331j/1rm6/VWp5FaMwXf/plmfGizRSY5CRlKd7UpdjLw4JQOGTm
        nxBSMMY0fd6PQQgKt0oRUA==
X-Google-Smtp-Source: ABdhPJyfiQHVEpQyGjJIrnx0etDK7qNmr6LLYws42hGF8QBlc1/VXskb0M4ja4dcze527igdCgI0Hw==
X-Received: by 2002:a05:6870:63a7:b0:d9:9e33:c9d4 with SMTP id t39-20020a05687063a700b000d99e33c9d4mr98939oap.69.1646168728216;
        Tue, 01 Mar 2022 13:05:28 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id t7-20020a9d5907000000b005afa4058a4csm7125244oth.1.2022.03.01.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:05:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display/msm: Drop bogus interrupt flags cell on MDSS nodes
Date:   Tue,  1 Mar 2022 15:05:13 -0600
Message-Id: <20220301210513.1855076-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
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

The MDSS interrupt provider is a single cell, so specifying interrupt flags
on the consumers is incorrect.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/msm/dpu-msm8998.yaml          | 4 ++--
 .../devicetree/bindings/display/msm/dpu-qcm2290.yaml          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
index 167bc48748d7..2df64afb76e6 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml
@@ -155,7 +155,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
 
-    display-subsystem@c900000 {
+    mdss: display-subsystem@c900000 {
         compatible = "qcom,msm8998-mdss";
         reg = <0x0c900000 0x1000>;
         reg-names = "mdss";
@@ -192,7 +192,7 @@ examples:
             clock-names = "iface", "bus", "mnoc", "core", "vsync";
 
             interrupt-parent = <&mdss>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupts = <0>;
             operating-points-v2 = <&mdp_opp_table>;
             power-domains = <&rpmpd MSM8998_VDDMX>;
 
diff --git a/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml b/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
index 8766b13f0c46..28617bc1d2ff 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml
@@ -197,7 +197,7 @@ examples:
                 power-domains = <&rpmpd QCM2290_VDDCX>;
 
                 interrupt-parent = <&mdss>;
-                interrupts = <0 IRQ_TYPE_NONE>;
+                interrupts = <0>;
 
                 ports {
                         #address-cells = <1>;
-- 
2.32.0

