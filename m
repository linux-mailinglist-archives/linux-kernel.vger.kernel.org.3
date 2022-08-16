Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4B595986
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiHPLJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiHPLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:09:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD9100946
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:36:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so18132593ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bI7Y225GCpQ4NdJRGg8+FzYb7W08NKsY6HOs76y3GX8=;
        b=5pvZMceVU+vt/halR4ASWruqRlsrJFiGvHKGtnsoWzFkwgfV4vnNUJh2p3QtpY9xr1
         8Zxx5WK/YSwesSB4IgIX9mGPRIJoVpRDIWhJOi0iZSRxEIoNcYdW5s5q3u3QQKidVkrS
         IXIh3BTy5OdIHU5JffTMASUOV7XuPLqeT70DB7exqRFB/teb7ucp1/bEjEo2EGD7GaSY
         a8ZbMxx9Y4zUB/VuFs1TJPMeHtkaeHHa+nZY6PvZrsTsw8E+UBaxNpMNdbofHyHF6jlg
         DVk4+zHzEEjF2oFaF7U4oTWrTr+YcXnM9TsvLqURCLRIwSNchDKaT6efN6ibCKh/WBhX
         yJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bI7Y225GCpQ4NdJRGg8+FzYb7W08NKsY6HOs76y3GX8=;
        b=md6NELj5G2usCgJR3VWaAtA0hL3NLYJ2GAbq7/0wxMq1pk1mAx259gAHLgRqDydcR+
         lzq7AnLAn+0cm6XG6fFgRa8ObVjJHXbTXqUBTyqY7jq7yhrf35+YXL4qEZTFPUF+xF7Q
         FrilySmxxS3+CkfCqPh4PVT3CeNbgi4R3WTpS78MvZe4B35L3yq4uogp3y8ryaDcLftM
         ZYCy1XJjykC/VwBtBCnDJBSeQ8P3QMJzqgqAyrROWus4ZDvtaM3V1ds2YvKaz7hD71MG
         wF7gT5gcEL5URs/AVINXGsL51NkG6/ifTzw+c4GpTbVgfeW9kQwgLp7x57uXPBYCmG4T
         UeEQ==
X-Gm-Message-State: ACgBeo1kdyqNGyOVwLHmRHWRWumjFMjPri6Cj543gxmS/CUuCsYKKvVn
        9VJ/+O3CPVhaHFQ93087NBTw5w==
X-Google-Smtp-Source: AA6agR56VBuI9frf3ORaTQsmlP25dS59QhJ5fbrC1X4vbMonLouSSlVNSuudiw3lYIiJYzAiVXCI4A==
X-Received: by 2002:a17:907:1611:b0:733:636:5686 with SMTP id hb17-20020a170907161100b0073306365686mr13181883ejc.226.1660646179611;
        Tue, 16 Aug 2022 03:36:19 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-78.zg.cable.xnet.hr. [94.253.165.78])
        by smtp.googlemail.com with ESMTPSA id o24-20020aa7dd58000000b0043d742104efsm8175945edw.19.2022.08.16.03.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:36:19 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] arm64: dts: microchip: use "okay" instead of "ok"
Date:   Tue, 16 Aug 2022 12:36:13 +0200
Message-Id: <20220816103613.22806-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT specification only allows "okay", and for projects like U-boot
status = "ok" won't enable the device at all.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 4d55ae868b50..80217d5f3f66 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -529,7 +529,7 @@ i2c_sfp20: i2c_sfp20 {
 };
 
 &mdio3 {
-	status = "ok";
+	status = "okay";
 	phy64: ethernet-phy@64 {
 		reg = <28>;
 	};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index ec90bda7ed6a..0760cf2e48bc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -208,7 +208,7 @@ sfp_eth63: sfp-eth63 {
 };
 
 &mdio0 {
-	status = "ok";
+	status = "okay";
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 	};
@@ -284,7 +284,7 @@ phy23: ethernet-phy@23 {
 };
 
 &mdio1 {
-	status = "ok";
+	status = "okay";
 	phy24: ethernet-phy@24 {
 		reg = <0>;
 	};
@@ -360,7 +360,7 @@ phy47: ethernet-phy@47 {
 };
 
 &mdio3 {
-	status = "ok";
+	status = "okay";
 	phy64: ethernet-phy@64 {
 		reg = <28>;
 	};
-- 
2.37.2

