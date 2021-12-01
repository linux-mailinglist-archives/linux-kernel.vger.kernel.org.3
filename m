Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9B465293
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351549AbhLAQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:17:46 -0500
Received: from out0.migadu.com ([94.23.1.103]:60722 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351472AbhLAQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:15:57 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638375148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lFszSLMJlckqMgj199+C+7TCwWXJukck64IGKpiISBg=;
        b=i0yNjGxrUmQUBsNO+augWPsvo+7IopxwG1/mpq+SghSpQelceGeudz6JuXdcU/QG0wMqZX
        2eKeQfajrnSMdmH1s4Lk4fhveabBMLB+lSMYU/78bGQFqk3amfU+ANqSVmlLCkFh3DVdn+
        HEqEXjV2cwUpyWeFxXJDzfgA4IEJ5IU=
From:   richard.leitner@linux.dev
To:     richard.leitner@skidata.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: tegra: tamonten: Fix I2C3 pad setting
Date:   Wed,  1 Dec 2021 17:11:48 +0100
Message-Id: <20211201161148.238263-1-richard.leitner@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Leitner <richard.leitner@skidata.com>

This patch fixes the tristate configuration for i2c3 function assigned
to the dtf pins on the Tamonten Tegra20 SoM.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 02a1a4fa3a27..01e98605d5be 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -184,8 +184,8 @@ uca {
 			};
 			conf_ata {
 				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
-					"cdev1", "cdev2", "dap1", "dtb", "gma",
-					"gmb", "gmc", "gmd", "gme", "gpu7",
+					"cdev1", "cdev2", "dap1", "dtb", "dtf",
+					"gma", "gmb", "gmc", "gmd", "gme", "gpu7",
 					"gpv", "i2cp", "irrx", "irtx", "pta",
 					"rm", "slxa", "slxk", "spia", "spib",
 					"uac";
@@ -204,7 +204,7 @@ conf_csus {
 			};
 			conf_crtp {
 				nvidia,pins = "crtp", "dap2", "dap3", "dap4",
-					"dtc", "dte", "dtf", "gpu", "sdio1",
+					"dtc", "dte", "gpu", "sdio1",
 					"slxc", "slxd", "spdi", "spdo", "spig",
 					"uda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-- 
2.33.1

