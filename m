Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6375A6C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiH3S3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiH3S3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:29:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381262AB1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so12684536pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IVYpqdrEDbP/yo8j9YBCLt1dmps7l9gRH+pM/+p7PK0=;
        b=YtBwXyopWXDWizaP52Wx5ett0W5ma68cdHKgYA/VnhL+UajdN+vvPmhpNDqwHZ9sPc
         5DYqRxbypI8evgoIWu/JR7TWji1bf2rt0UooPbURH/FOXx9+nvYoiFpIKpz/SG0gKuKS
         QgE30jPF3qg2lBhkJH5PkmSJlHps93SVXE1Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IVYpqdrEDbP/yo8j9YBCLt1dmps7l9gRH+pM/+p7PK0=;
        b=iPdY2cCTiAMjZsaPjEqHBmUlS4Nx+0zjVl7MnpGgPPgyBjVQnaNyogN6UVPwkjPuj/
         dATwTRLwzFPpJ7cHL4C7oqedRf8UnbDIPTSG+GEiTCat5WtMC6mo4alEqpZcjkt4lhCU
         xve1808wYAWPq6krBUOc1rus5orHr2Bp4tMf65iAiQRbFxq730gZd/pq3vkrPhAQ+uPR
         SBcgcJo54QB4Gn1XSAnwtQn3NI4FuF26kSgJUE/0AVBu8VK0SL16aCqLCqikZ+7o8GTR
         eXO1pyP2tb9WjQpmkZT7Tq1C+ThdC3UGi6kGt6By5VmnuOlAcaZr82b6J/vU5kzxrSZt
         Gm/g==
X-Gm-Message-State: ACgBeo18ImFQ6J0+0JavbGc6iOxpfz3yJ1X+bjwHesbpcfy7hGNpwoXl
        jE9kVurtdxumW5i+k0Lq7ZaMAQ==
X-Google-Smtp-Source: AA6agR6FFNo461tgdKd7kvBaIfB0Xng/tcC7Z0YghFdKfYMadyAPf1NmWkHj0sN8Ld41DQKlDokUtA==
X-Received: by 2002:a17:90b:3511:b0:1f4:e0cd:1e04 with SMTP id ls17-20020a17090b351100b001f4e0cd1e04mr25365421pjb.154.1661884173694;
        Tue, 30 Aug 2022 11:29:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f016:d779:b6b0:fd9d])
        by smtp.gmail.com with ESMTPSA id u202-20020a6279d3000000b0052e37b32618sm9596358pfc.132.2022.08.30.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:29:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Jimmy Chen <jinghung.chen3@hotmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/3] arm64: dts: qcom: sc7280: Add herobrine-villager-r1
Date:   Tue, 30 Aug 2022 11:29:22 -0700
Message-Id: <20220830112818.v9.2.Iceba291b2b70eeca1fdf654a43f0484d34791024@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220830182923.3720287-1-dianders@chromium.org>
References: <20220830182923.3720287-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jimmy Chen <jinghung.chen3@hotmail.com>

This adds sc7280-herobrine-villager-r1.dts for villager device tree files.
Herobrine-r1 is exactly the same as -r0 except that it uses a
different audio solution (it uses the same one as the CRD).

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v7)

Changes in v7:
- Revise typo 'ARCG' to 'ARCH' in Makefile

Changes in v5:
- Revise rev0+ to rev0
- Add -r1 line to the Makefile

Changes in v4:
- ("...: Add herobrine-villager-r1") new for v4

 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-villager-r0.dts |  4 ++--
 .../boot/dts/qcom/sc7280-herobrine-villager-r1.dts | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index fa8f8b66bb02..a62a56fd27cb 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index 2cacafd8faa8..cbd8a2d1ef2a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -10,8 +10,8 @@
 #include "sc7280-herobrine.dtsi"
 
 / {
-	model = "Google Villager (rev0+)";
-	compatible = "google,villager", "qcom,sc7280";
+	model = "Google Villager (rev0)";
+	compatible = "google,villager-rev0", "qcom,sc7280";
 };
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
new file mode 100644
index 000000000000..c03b3ae4de50
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Villager board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-villager-r0.dts"
+#include "sc7280-herobrine-audio-wcd9385.dtsi"
+
+/ {
+	model = "Google Villager (rev1+)";
+	compatible = "google,villager", "qcom,sc7280";
+};
-- 
2.37.2.672.g94769d06f0-goog

