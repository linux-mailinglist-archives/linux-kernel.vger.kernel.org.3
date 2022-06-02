Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16353BE5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiFBTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiFBTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:06:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E02BFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:06:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w21so5553104pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+CJHPksJEyQ/br0kNUyJ2paAkEWbd02hKrM4zpgQyQ=;
        b=DftemrRpxgHU1PB1Zl247GpilafWiRfmuWeotJzMK1VZeLBmDqw1XVVJPA53kteARU
         XGS/yfyDrMHQslfTX7pA21vfF21sHFG2IfDmoRjE+eQqmxDRtPtj/UZEd+qxT++nSu4t
         82hhWgZnRfGVqVMT6G/+rQViZi921qzEPdObU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+CJHPksJEyQ/br0kNUyJ2paAkEWbd02hKrM4zpgQyQ=;
        b=oOcjHSAdjY/IsFNwakFmH2lQ3Jmtx+2Yu0Wk4afKBPq6k8stv0oCVcHO+/1O+o/Pn5
         Bg4f8WmvxYpSAM49yoSkjAIAPkUBsLEyqXCrFZcGTkXqOmFG7ouHMEkA0eOX3eTbOtki
         Bk7QXZDxonkTaEcI6qKThWdo4HdwqJXp3npdqWvuTJBlxKGy4kMGc9h2ZiELsFSW70wl
         UGZBM/MCw+nIoSfoIiEPk31VjdSEahR6NL9yLPukoqVbw1bPSmxTj3Z3knsuTGd/PCTy
         8ACIBSr+zFay4iyItTgP/LtROSZJwb6S+EzKDNZ4D64ufHSse1XGuy+pepcNOSN4dRk4
         r02Q==
X-Gm-Message-State: AOAM530T34wxZV1oJGS9arbFHR+JOODh+Ej/gL0gLhculcL/IW78A7Ly
        iodnCTQZOdrzb8Qz1rikO/LjlA==
X-Google-Smtp-Source: ABdhPJzTc/a6pzmNkyPjyl9vwfz3NHCs0ZPckhN2iQUoju04q2sVsqtxC4zMCL5PFu1/nbWvdqSF1Q==
X-Received: by 2002:a63:d446:0:b0:3fc:1370:798a with SMTP id i6-20020a63d446000000b003fc1370798amr5610931pgj.190.1654196783584;
        Thu, 02 Jun 2022 12:06:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6885:8b62:3875:9d55])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b0051878e8cc13sm4197895pfl.116.2022.06.02.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 12:06:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: Remove duplicate sc7180-trogdor include on lazor/homestar
Date:   Thu,  2 Jun 2022 12:06:21 -0700
Message-Id: <20220602190621.1646679-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180-trogdor-{lazor,homestar}-*.dtsi files all include
sc7180-trogdor.dtsi and sc7180-trogdor-lazor.dtsi or
sc7180-trogdor-homestar.dtsi, so including it here in the
sc7180-trogdor-{lazor,homestar}.dtsi file means we have a duplicate
include after commit 19794489fa24 ("arm64: dts: qcom: Only include
sc7180.dtsi in sc7180-trogdor.dtsi"). We include the sc7180-trogdor.dtsi
file in a board like sc7180-trogdor-lazor-r1.dts so that we can include
the display bridge snippet (e.g. sc7180-trogdor-ti-sn65dsi86.dtsi)
instead of making ever increasing variants like
sc7180-trogdor-lazor-ti-sn65dsi86.dtsi.

Unfortunately, having the double include like this means the display
bridge's i2c bus is left disabled instead of enabled by the bridge
snippet. Any boards that use the i2c bus for the display bridge will
have the bus disabled when we include sc7180-trogdor.dtsi the second
time, which picks up the i2c status="disabled" line from sc7180.dtsi.
This leads to the display not turning on and black screens at boot on
lazor and homestar devices.

Fix this by dropping the include and making a note that the
sc7180-trogdor-{lazor,homestar}.dtsi file must be included after
sc7180-trogdor.dtsi

Reported-by: Douglas Anderson <dianders@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Fixes: 19794489fa24 ("arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

It would be great to get this into -rc1 if possible to fix broken
display.

Changes from v1 (https://lore.kernel.org/r/20220520231355.1559104-1-swboyd@chromium.org):
 * Also do the same on homestar

I found that my script to check differences wasn't printing any
differences because of a typo, so I thought everything was fine when it
wasn't! Now I've checked and for boards using parade bridge chips quite
a few phandles are renumbered but they're the same logically as before
whereas as boards using the ti bridge chip only have a few lines
reordered.

 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 9b3e3d13c165..d1e2df5164ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -5,7 +5,7 @@
  * Copyright 2021 Google LLC.
  */
 
-#include "sc7180-trogdor.dtsi"
+/* This file must be included after sc7180-trogdor.dtsi */
 
 / {
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index fe2369c29aad..88f6a7d4d020 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -5,7 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor.dtsi"
+/* This file must be included after sc7180-trogdor.dtsi */
 
 &ap_sar_sensor {
 	semtech,cs0-ground;

base-commit: 19794489fa2474a55c00848e00ca3d15ea01d36c
-- 
https://chromeos.dev

