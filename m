Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC85D46D476
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhLHNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:35:37 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:15492 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhLHNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638970324; x=1670506324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TY56zgAQOkoPTGFWpyt2EmMS4xIRb8tsNHpW/kK5u9o=;
  b=Hd177mNOlG6up9eCOGSMoPSwEGrK2ZSuZ190XVC/VYo/7s5+9Ogenxmj
   TfrV/qIq1LlVqL/n8gjnwgB0vTfaIHxvXYmv1AqBHBXk+n780IcU/ETRG
   cxYixclzxvmlMauoW12SJXfOX35f/m/BR+JzbpDyZyD40Ku0mYGBX6OXy
   XcCtLj4eoj18wfI3LhR8lMBLDM0km2GzXs7X+KsuvCQQJnU5F89Rj8i+8
   wmW+aqYaC7L58CsdPZwC64tOQI9W5rlzfT8DVch95ytR5PtjiAF8O0RN2
   ovTIxsbBnA79v5aikQF8YSDimdqWfExz2jtXtsbgMLR4RCrReHXbOFuJ3
   A==;
IronPort-SDR: CemCYyJJEaC/ZZ6yPAmD9UQ93E4Sdu91E/4YBRMj4rdoVnaSTzcpioEwxs0UE0E9swLaoJvnP+
 xxfC185pLcMkkQ0f8eMuGyRqNY7CCo5S5y/4WBViXsgfo3a7VAUPNl6jfbUIfDwbHBRO7rKUln
 S9EXtLWn0gQpUnzFvYl8kwO66C6Nv2AxnfsPRk0Z/k25RqFb93xUTe7brl6Qjp6o10XL7CEkuM
 Ck7sCOyE7G+IA7lEHTLgCesGteX+CHhVc9ym+9U630BiVyqANrjWaxz4Gfwel53hUoswRSWYoG
 aI4luFFhIEUNvIjwFiHEq1Kg
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="141718629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 06:32:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 06:32:03 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 06:32:01 -0700
From:   <nicolas.ferre@microchip.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] clk: at91: clk for 5.17
Date:   Wed, 8 Dec 2021 14:31:45 +0100
Message-ID: <20211208133145.28267-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Stephen,

Here are the clk changes for 5.17 which collect changes to the lan966x product
line. We agreed to include these Microchip patches into the at91 branch with
Kavyasree and Horatiu.

Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-at91-5.17

for you to fetch changes up to 5ad5915dea0047a6376d8f809ea3470ef68b1f92:

  clk: lan966x: Extend lan966x clock driver for clock gating support (2021-12-08 11:19:20 +0100)

----------------------------------------------------------------
AT91 clk driver changes for 5.17:

- Lan966x Generic Clock Controller driver and associated DT bindings
- Lan966x clock driver extended to support clock gating

----------------------------------------------------------------
Horatiu Vultur (4):
      clk: gate: Add devm_clk_hw_register_gate()
      dt-bindings: clock: lan966x: Extend for clock gate support
      dt-bindings: clock: lan966x: Extend includes with clock gates
      clk: lan966x: Extend lan966x clock driver for clock gating support

Kavyasree Kotagiri (3):
      dt-bindings: clock: lan966x: Add binding includes for lan966x SoC clock IDs
      dt-bindings: clock: lan966x: Add LAN966X Clock Controller
      clk: lan966x: Add lan966x SoC clock driver

 .../bindings/clock/microchip,lan966x-gck.yaml      |  60 +++++
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-gate.c                             |  35 +++
 drivers/clk/clk-lan966x.c                          | 293 +++++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h      |  34 +++
 include/linux/clk-provider.h                       |  23 ++
 7 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
Nicolas Ferre
