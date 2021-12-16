Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCBC4773FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhLPOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:29 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7284 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbhLPOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663887; x=1671199887;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+/9U7AZvkFy7QZiEsOQz5DnCH3fW/bgOwemRF2u1f68=;
  b=h+vJqJ+/qG3bj8xKkr9JrAdh3N4zTqbRBdHUA7byAxnbu52pO0eJRAEr
   3FpcjFKoEQqIFL+tyAgvz2fX6OgCel4VQIPtEI3jEmt3PW1Epvh8e1jai
   Wrh0BC+lefzR6+rZ1wPoiLT6CYxLdnUN3wSR8ltfX+mUxojJg41zXaAlA
   /rMVJ0dJTspVQ6QkwS5+5tTsoShMtwdghKzNWlk/vWBg5p1HnQGw4+7qo
   NoNL/E9lzbtOubFE5E+ZEXGHK32sdSOunw06/vygi5Tdr33mIjeOtXiJQ
   wXnEVQUj8rs+r84ytu9xqbSi5v2DT7c6QwP61qFhXUYRyeFrMnYrhI1W2
   w==;
IronPort-SDR: xBIzMo/ENzCs2FxdLt/L7DcrH1cBNK7XwpH8hYY66NjEPOFvympPojTJe+zltRUR0F6FIBlUjr
 BDdOme5/hDfLyvGr0hU14BpTGO/Nc8wC+r6PUg0E4vUAW6QX0bb+N18XKfK433JB5kTNJGaeMl
 c1PAlL5nQZRTj8luHidH43A7wvhd39cj6p908UfqAAU1/4sKdJnZxj3Lgg2e7SgleIvk3CRwmK
 eUKnKEO3NbSvWhhm0mDEq8ge462PG9Yd+rZbdxZiB9NY9g7eY6eT+GLP7IBLuaRKTmEjXwNowZ
 NrCulgoTzGopRciYyUDzLyTv
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="155734017"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:25 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] ARM: at91: add cpu idle and cpufreq opps for sama7g5
Date:   Thu, 16 Dec 2021 16:13:30 +0200
Message-ID: <20211216141338.35144-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds CPU idle support for SAMA7G5. Along with this the
CPUFreq OPPs for SAMA7G5 and proper config has been added.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ARM: at91: ddr: remove CONFIG_SOC_SAMA7 dependency
  ARM: at91: ddr: align macro definitions
  ARM: at91: ddr: fix typo to align with datasheet naming
  ARM: at91: PM: add cpu idle support for sama7g5
  ARM: at91: Kconfig: select PM_OPP
  ARM: dts: at91: sama7g5: add opps
  ARM: configs: at91: sama7: enable cpu idle
  ARM: configs: at91: sama7: add config for cpufreq

 arch/arm/boot/dts/sama7g5.dtsi   | 37 ++++++++++++++++++++++++++++++++
 arch/arm/configs/sama7_defconfig |  9 +++++++-
 arch/arm/mach-at91/Kconfig       |  1 +
 arch/arm/mach-at91/pm.c          | 27 ++++++++++++++++++++++-
 arch/arm/mach-at91/pm_suspend.S  |  4 ++--
 include/linux/clk/at91_pmc.h     |  4 ++++
 include/soc/at91/sama7-ddr.h     | 15 ++++++-------
 7 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.32.0

