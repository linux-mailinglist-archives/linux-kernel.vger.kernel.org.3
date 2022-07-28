Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563CD583CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiG1LQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiG1LQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:16:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2263912;
        Thu, 28 Jul 2022 04:16:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m8so1728051edd.9;
        Thu, 28 Jul 2022 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1hcQDsRPMnRc56BCmzgeV/mUPsQfxRSFDip2MB+Kss=;
        b=q70S7u6oJiCsrKuJPZt99845aiVMvcyznOEvoqs0xtppse3X4bNHBeucluhRlRIB17
         Hfee1lCq6qk0BFvYf6Kxex6JHeLUqa0j5St90+LzbAuGcEjWJHeUHp94UZj79kp/LuEr
         T0g8u5bXJB+FohCvoHnyQ2UdhGA3louCqsa2EhAWJnxcTJ71rzBtLPFEeAqhWCnQ0crA
         J1I6FZFBCVI961ESYAn/cRc1haxmewRSJP3Eqr8OrdTyxXjE7F/5B4k//Ak41fu0fRQ0
         4CqeUpIQK8IYOOjG3SJRnmatNbV3W7EV2XCoZ0WQX/fEPbk8anmDRVxlLPUx9UVy1Qh5
         3QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1hcQDsRPMnRc56BCmzgeV/mUPsQfxRSFDip2MB+Kss=;
        b=4vm8Hfynp/dtSv++K1LfsCt9AKiMS1mkL6fYkKJY5akmxpfMzv4yB088bs1eOwMeef
         p1N/l4Obn0BTbr5J0NSP/oKqUcTYWaCPEPOzOHeVAdYQCcq9C1B28zqGVG5PxMtgEGqr
         uyjolKavdba5aYa6onCGwYIoH8CTiYlHhYssBdmJiJqIN7+b8Wnmlz52bgN/MTKAQpHl
         nJ5khiqyvYBKAPk98QnVL7ek/Q1OjhJHt7DKArJWaYYUv21kpUuS2r4jiT9rqE0cudnx
         4AoZayY8dRbJ+g+kc/0BWLkmXpL1rhQzQFeJA1gyzmSOYjwYXZ5qBByEwjOKbXtD4brr
         XYxA==
X-Gm-Message-State: AJIora8nm/F1SV82yAfYHEpe6UfA/Bbca8vf9uIppf1g7SpSdzSO/sOj
        I3YN2cW19G6/XMuj7thDtdY=
X-Google-Smtp-Source: AGRyM1voPgPgibrhvl7h3F9hwBmh2W/rUdGDc8VASe+RSNb8IV4fCxzHIbqAtTVnhr2RBOEovu7gaQ==
X-Received: by 2002:a05:6402:4cc:b0:43c:cd5c:dcfb with SMTP id n12-20020a05640204cc00b0043ccd5cdcfbmr4601784edw.277.1659006984597;
        Thu, 28 Jul 2022 04:16:24 -0700 (PDT)
Received: from brandenburg.sect.tu-berlin.de ([130.149.39.100])
        by smtp.gmail.com with ESMTPSA id vj16-20020a170907131000b006fec27575f1sm295803ejb.123.2022.07.28.04.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:16:21 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: qcom: msm8960: add reference to sleep_clk
Date:   Thu, 28 Jul 2022 13:16:02 +0200
Message-Id: <20220728111603.30503-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the reference of sleep_clk to the same as qcom-apq8064.dtsi.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e8cd1c9c0..991eb1948 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -71,7 +71,7 @@ pxo_board: pxo_board {
 			clock-output-names = "pxo_board";
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
-- 
2.34.1

