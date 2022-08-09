Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE458D0FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbiHIADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHIADH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:03:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B790916590;
        Mon,  8 Aug 2022 17:03:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s11so733991qtx.6;
        Mon, 08 Aug 2022 17:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0vJOHKFBTjReQiciwGJs8MU84pqoq/FtbgACoNpaTeQ=;
        b=Xvw4gbEOFrC4qcS/bD1MwL56IBXBsMGVu4xQCOQUySNzRCWkiejAW2c9h0U0ry6oN2
         QpawVtvW5FJCkgLlZrLfw5Tz1WPWW2hFEq6sy05Pqf/E0UOAwVBtEEYdULDcKg0LHJ09
         IQQuRQs5inCbjM7lcRCTw6M0/MlcjIXJUrXTmryJS45wQV2tfKDyRR1XZATbpgN2D2uK
         JcOSPk+U3TJXB1hX7Mr7UWOHWKM+eJGgxOQ6HNTCaN8SIkBdhhEEqsOYlWqKTGdwLWqn
         iGn+BFY0XA4EWGzg+pR8OYufekzru5OB26ds1HbQe7Q0S9de23V7LaGMc/oqOrr6Nhzv
         JCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0vJOHKFBTjReQiciwGJs8MU84pqoq/FtbgACoNpaTeQ=;
        b=CivfCmz5eQHrY6gUjmpMMkAAV+eMvvgEjC0zvPUu094M8RhVjcxunpKOhQNpUXP96r
         kcGk+jJcIoWDpVrGz7FE4GyebRZxzLUZTyHFCbv60rhES/BF/eh/a76HvhGZQZxPa/la
         yneuRjJMKh3rVivQPa6xf417L7ndS18RH+cozIqPQYUeYmfCepYgnfxcCcLewb6xgGsv
         CyYJfIW2simfimJH/ZYbVyWAepo5Sy71neRK0H31tGam543ltGUZMARGNvax5slsFaTL
         4tGTg9W0sLY1zCHFb3J5AHxX0RFmDstNk2T6sgCZiEkPvVAeUFYuqoGcyP4OFAH5Ll0y
         rXnQ==
X-Gm-Message-State: ACgBeo0umNS1xsmeb5lDHcBPNqFVJfkzt6Qy+41SCjADBdoWeJ2KY/rJ
        vE5ZCnNuFgIT30UWxXLu8cw=
X-Google-Smtp-Source: AA6agR6THagCHv9NPktVyODlio/ByMdWfyEqjuQq2j6ziaNkiXLeRmCuKLCFoYl7euzKsmGe44eYdg==
X-Received: by 2002:a05:622a:1806:b0:343:236:2971 with SMTP id t6-20020a05622a180600b0034302362971mr3299107qtc.379.1660003385655;
        Mon, 08 Aug 2022 17:03:05 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2036:c00:e57a:4cf3:aa55:7079])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a430400b006b5988b2ca8sm10265719qko.40.2022.08.08.17.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:03:05 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     guptarud@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v2 1/2] ARM: msm8960: Rename cxo_board to cxo-board and add alias
Date:   Mon,  8 Aug 2022 20:02:59 -0400
Message-Id: <20220809000300.6384-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808234723.5184-2-guptarud@gmail.com>
References: <20220808234723.5184-2-guptarud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames cxo_board to be up to date with the current naming
style. It also adds an alias.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
v2:
 - Group the correct changes together

 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 drivers/clk/qcom/gcc-msm8960.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 0e099aa7c889..2ed969785b78 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -58,7 +58,7 @@ cpu-pmu {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index 051745ef99c8..56ce05a846dd 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3624,7 +3624,7 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (!match)
 		return -EINVAL;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 19200000);
+	ret = qcom_cc_register_board_clk(dev, "cxo-board", "cxo", 19200000);
 	if (ret)
 		return ret;
 
-- 
2.25.1

