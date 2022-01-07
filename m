Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9948487BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348728AbiAGSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:29 -0500
Received: from mout.perfora.net ([74.208.4.196]:58721 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348699AbiAGSEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:22 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N2EcM-1mNKSy2nHS-013fy9;
 Fri, 07 Jan 2022 19:04:03 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/14] arm64: defconfig: build r8169 as a module
Date:   Fri,  7 Jan 2022 19:03:06 +0100
Message-Id: <20220107180314.1816515-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KfeUfQlxgHiBHMuf7O8TOC6N3mwRdl4YQFc/41lH8FYgb7Aj4XA
 kv0ocRy/6bZRmbpPVZKro/L8aycd6zhhrDDANAuDMC6drCQSqnNcplq+5Ur8NsUg14XPuoE
 LpqZLAHis9FN8mKF4W/aWZg0io/aN2kky3FsR/nmrEN2ewybbE4ksYnqBIgdwlKFaB4LlrS
 vV+MVueeaHCPCMvK50vIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fuKF+yrb/Qw=:L1MbYfDkroLCbqZtaEAqLS
 4Vpkl6hAjK6kXxh0vOeahnJRBYCCnzNLpekwK4d+EYzLuotrSD/+8e+ksZJ4RxhQcXTc1AnBd
 oZY+Hx05vJwRM8iHgqZTrlbRsQCR99nB3z7asfrRJjRyArZc3qlrr0XG8nvRU/XD0s4fvI591
 GXaWB3+LMhMKlYN2/d3EiW931S3sAgpx72kZEigAeuD4WimZ8uuoVgnBB7zIC3c2OFWHj56yx
 +eQmetetiHst8JqydD9dltJ11qJrCTSIp2z+junq8X/u7l8LUzxrA8M1cN46voa/8/4Y0lsxn
 xfnHh4C6pr9WoHsoyPFh6zjtg7qBmKB37JbKzkQr4hN+wpt8E0FIpiE1azfEUfSaw56e7sbkv
 nkbJQkA8JXyVL1fdA1+xF1mMHKIqBnN8PHA2M/aFZD9tiFUta+pJE5Hm5fu0UxrMb/mkAuMpa
 cCgkOlnnwG7iUm6cVWE+cGVULaFCgyO/QKA/o9ZjQnccB+QN7VyXWtVgvx1rTfj5K1z9xXA3l
 gm6nkNXvIrz0FxEkCDLJPOAZ8Et1Y+5TzCbG29NPU8NnAtI5MBA5rKg6p/h9x4sEf2zOSVZEW
 c84B3uA7T03jj3wxGoylpGBNeLLiNJGtHc2OTB3EGFkR8l8t2H86no4DdUyn3i3IdOYMt2zD8
 a20jOR/Kn/Argpjz2fEQXqjb18Jz0wll10kpwtngKn9TpVgqXT2G1cayn5tnzMkIdeX0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Realtek Gigabit Ethernet driver as a module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a18785a827dc..86d39d8456c1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -338,6 +338,7 @@ CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
 CONFIG_RMNET=m
+CONFIG_R8169=m
 CONFIG_SH_ETH=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
-- 
2.33.1

