Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA7473163
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbhLMQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:15:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25555 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhLMQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639412105; x=1670948105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aj1jLscTd8hqfDx51zkQXy34te0g7lf175kTteg7blc=;
  b=bZXBUF7PUmBib09vVuASqvT96MnDTRb4sYMMelgSZX/Mv9Fif/RfVgRS
   XUM5hIRMg0bd2DbX5o40xjv6rBrtXu1087gO2Yabq2fxNQsROhUmfejFV
   KEGguaP6UxCRsdUHtikWpw0Nfqwx4h3ESt5Deyl/lrVTBO8hT7DGFJUlU
   GjWarIUzBOUDkqd7UB3y5ZJl/C2uHlSDG1VF5quhzicko1Jd6DQeduBQ2
   jl3ZeSoJIH/7zDpb1LCP94sdfC4HqAJtnycP72bYqBl6Sd4epyyC2Tnzw
   BuiHWZYM/1qRWyaWAfSKtnTUS+NAhMe2FKPVI0LtK7OeDKPTlh/mcrOyq
   Q==;
IronPort-SDR: 0LCS69UiOgr0BMxl1dXM1FA+3fj2H0o5gNufGfQR+iwt0AGMiZ+EOFSaxtaY9rWN4QZpGx5OPh
 PkN7jGXryz1DFJRFQMB8baijW408PH8Gv+Rl7NZBZhFn17npCj4VvVHOgJtXmuDTXQEeOyozeL
 MxHoq27AZmHbgsibxwWgAw050SDDDEBF7cqaUtCd9qZmsXY/boAaEg8+R4Y4Y11n2qa27MYb6M
 DFY+BlPnZJrD2+R9WkSEZ9QRDw4y3WjO+nPgUl/otCwnmE5i+bzilhpRjG+oU9sBNTiye6l+GL
 eWhPjvotAVHGIGewBdFdw3Cr
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="146488750"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 09:15:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 09:15:03 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 09:15:01 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Hari Prasath <Hari.PrasathGE@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.17
Date:   Mon, 13 Dec 2021 17:14:51 +0100
Message-ID: <20211213161451.90786-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the dt changes for 5.17.
The QSPI nodes have their bindings translated to YAML and updated here:
https://lore.kernel.org/lkml/20211209122939.339810-1-tudor.ambarus@microchip.com/
They are not merged yet but I see no major push back as of today.
Moreover, one of the low priority fix below remove one of the error highlighted
during the conversion to YAML.

Thanks, best regards,
  Nicolas

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.17

for you to fetch changes up to 078c2a0e8e60bb3fe78cf50b5da1620a4e13e0cd:

  ARM: dts: at91: sama7g5ek: Add QSPI0 node (2021-12-13 14:48:04 +0100)

----------------------------------------------------------------
AT91 DT #1 for 5.17:

- 2 low priority fixes about pin function for sama7g5 and better
  tailored mmc interface on sama5d2 xplained
- Addition of the Microchip EVB-KSZ9477: a Gigabit Ethernet
  managed Switch Evaluation Board
- QSPI: addition of sama5d2 clock name and nodes for new sama7g7 and its
  associated Evaluation Kit

----------------------------------------------------------------
Hari Prasath (1):
      ARM: dts: at91: update alternate function of signal PD20

Mihai Sain (1):
      ARM: dts: at91: sama5d2_xplained: remove PA11__SDMMC0_VDDSEL from pinctrl

Oleksij Rempel (1):
      ARM: dts: at91: add Microchip EVB-KSZ9477 board

Tudor Ambarus (3):
      ARM: dts: at91: sama5d2: Name the qspi clock
      ARM: dts: at91: sama7g5: Add QSPI nodes
      ARM: dts: at91: sama7g5ek: Add QSPI0 node

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts    |   5 +-
 arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts | 209 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91-sama7g5ek.dts           |  73 +++++++++
 arch/arm/boot/dts/sama5d2.dtsi                 |   2 +
 arch/arm/boot/dts/sama7g5-pinfunc.h            |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                 |  30 ++++
 7 files changed, 318 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts

-- 
Nicolas Ferre
