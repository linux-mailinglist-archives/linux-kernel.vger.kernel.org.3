Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDD500AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbiDNKTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242221AbiDNKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5E675614;
        Thu, 14 Apr 2022 03:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DB661E6D;
        Thu, 14 Apr 2022 10:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D6C385AD;
        Thu, 14 Apr 2022 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931420;
        bh=L/NB4rzDeYZP76iJZTy6KlNtSXg0xl8lH/8ohgfvkKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5L13H5/m1NvdvUOF3hB9aUimAOQOoBPHea7cI/AXUdggD2uIVGTtgEKlT1LHFzDk
         9uDFeqB60bJQyI9fNUgoiK78YuyoSZjazmVWuoxdasOm5U7uVQrtF0VeVPQFmp0oYI
         ozJLUA8nplc9DmwreRPzOcZobemWM3uHD4kn2vBcQfzVKIAO8ihpn6V4R44GyieXC+
         ip8M/F8MmE5Rcb75/G/ugg9bpoKzYy1vgNe5WwIMHsi4pWgXT7qhLMulZ6+txq5Xiz
         I5cIDHUW9mP7u1+ESQ5JOxwhSSNW+69SWTNbTe1Nf4ieKkyfIcjPVLzHHxMXkR6rJI
         LThYNJjzv8tyQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: qcom: sm8450-qrd: Enable spi and i2c nodes
Date:   Thu, 14 Apr 2022 15:46:30 +0530
Message-Id: <20220414101630.1189052-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414101630.1189052-1-vkoul@kernel.org>
References: <20220414101630.1189052-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the i2c5, spi4, spi18 and spi19 nodes which were tested on qrd
board along with related qup nodes and gpi_dma0

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 9526632d4029..1e87a083816e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -342,10 +342,22 @@ vreg_l6e_1p2: ldo6 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	status = "okay";
 	firmware-name = "qcom/sm8450/adsp.mbn";
@@ -366,6 +378,18 @@ &remoteproc_slpi {
 	firmware-name = "qcom/sm8450/slpi.mbn";
 };
 
+&spi4 {
+	status = "okay";
+};
+
+&spi18 {
+	status = "okay";
+};
+
+&spi19 {
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <36 4>;
 };
-- 
2.34.1

