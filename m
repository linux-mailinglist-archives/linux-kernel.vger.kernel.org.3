Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2ED4A73B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbiBBOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:51:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:39360 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345159AbiBBOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643813458; x=1675349458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dd3qfG+MZDrzIPyDzwKeChb5w5M9qgLZ0uwvyZmbVNo=;
  b=VMXBYZVzcPTmmBMfbXtYZICxm6NaJ//ZGWUcNuo6k7XnpZ69Iu03G+oo
   60cW/Ib0r/eWzzr4zowQuoBJerIZqxIpeBlIMdN7QeS+KUTf9ApP0e6U+
   4bL58xa1P52R/E+P4cA0uM3LxBIdOt5KFy8nPvjSXFy08i3LQvWKKA6AV
   yuK6HSAYMVfY8dsNJd4yzBCn3nWbfW8v2wlcqPUPK4Ae5TKIbUHD2iwpZ
   Mq3ZFOcS79T7z3sYhlvQzPTjUvgVjj54WWWACDzI9w7Efxt0wWpZzsMgg
   rcNIh7+7NUy4bJlo8qikZmyBRvmjYCXbzpx+OTh7YaPao8ZtD61+JPO4b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246757900"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="246757900"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:50:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="566009404"
Received: from mwnuczyn-mobl.ger.corp.intel.com (HELO localhost) ([10.249.137.160])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 06:50:49 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v7 03/13] ARM: dts: aspeed: Add PECI controller nodes
Date:   Wed,  2 Feb 2022 15:48:28 +0100
Message-Id: <20220202144838.163875-4-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202144838.163875-1-iwona.winiarska@intel.com>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PECI controller nodes with all required information.

Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 11 +++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 11 +++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index f14dace34c5a..fa8b581c3d6c 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -392,6 +392,17 @@ uart_routing: uart-routing@9c {
 				};
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2400-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				cmd-timeout-ms = <1000>;
+				clock-frequency = <1000000>;
+				status = "disabled";
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7495f93c5069..4147b397c883 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -516,6 +516,17 @@ ibt: ibt@140 {
 				};
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2500-peci";
+				reg = <0x1e78b000 0x60>;
+				interrupts = <15>;
+				clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				cmd-timeout-ms = <1000>;
+				clock-frequency = <1000000>;
+				status = "disabled";
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index c32e87fad4dc..3d5ce9da42c3 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -512,6 +512,17 @@ wdt4: watchdog@1e7850c0 {
 				status = "disabled";
 			};
 
+			peci0: peci-controller@1e78b000 {
+				compatible = "aspeed,ast2600-peci";
+				reg = <0x1e78b000 0x100>;
+				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
+				resets = <&syscon ASPEED_RESET_PECI>;
+				cmd-timeout-ms = <1000>;
+				clock-frequency = <1000000>;
+				status = "disabled";
+			};
+
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-- 
2.34.1

