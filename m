Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6905C49F6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiA1KHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:07:38 -0500
Received: from foss.arm.com ([217.140.110.172]:33940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242760AbiA1KHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:07:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A520113E;
        Fri, 28 Jan 2022 02:07:37 -0800 (PST)
Received: from e126387.arm.com (unknown [10.57.5.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7B53F766;
        Fri, 28 Jan 2022 02:07:35 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        krzk@kernel.org, biju.das.jz@bp.renesas.com,
        enric.balletbo@collabora.com, agx@sigxcpu.org, spujar@nvidia.com,
        alexander.stein@ew.tq-group.com, yuzenghui@huawei.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable modules for arm displays
Date:   Fri, 28 Jan 2022 10:07:20 +0000
Message-Id: <20220128100720.87803-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Key devices that support displays on SoCs like the Komeda DRM driver, the
older HDLCD were not enabled by default and should be so displays can work
out of the box on defconfig. Also Candence I2C support should be enabled so
the PHY and thus displays can work too.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..87edd79dac99 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -469,6 +469,7 @@ CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
 CONFIG_I2C_CROS_EC_TUNNEL=y
+CONFIG_I2C_CADENCE=m
 CONFIG_SPI=y
 CONFIG_SPI_ARMADA_3700=y
 CONFIG_SPI_BCM2835=m
@@ -678,7 +679,9 @@ CONFIG_VIDEO_OV5645=m
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_DRM=m
 CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_HDLCD=m
 CONFIG_DRM_MALI_DISPLAY=m
+CONFIG_DRM_KOMEDA=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_EXYNOS=m
 CONFIG_DRM_EXYNOS5433_DECON=y
-- 
2.25.1

