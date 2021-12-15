Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D852474F43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhLOAb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:31:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLOAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:31:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id BEEC91F45355
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639528287; bh=07m2Mj//13426umxuBSYqRK706zZCh+HwkJkV+wVXFw=;
        h=From:To:Cc:Subject:Date:From;
        b=ValfuxtcupHL48snp7Z1Y0x4sSlgIbOMBe0D3PDHgV3kZw5Nu7mPTw5Z1q7oUR3On
         Ym/Ho7sDLRY+dhekeewTgcrJLxH92m3eyNbiMi1hegn7sbFTSLd94Mk5AnHb8cf6UH
         9usu2sFoxi1LueG90szM1t6XGsHuRFpMxNRv4vK0AYF9Sl3iAGzCKkqdnCh/IFe0nG
         sJEqfUKGS5Lo4/0q9ha/X7pTiaObFSBqEh3cd4X/mLsSEbhhCqdhUkoQ6lgewAiku2
         HHFF4iGsFNnbc8I/+KnJPzHLSoCXczuSETBSnzMNBzn1PnqjQBHEUcvvO877E82vvH
         omZcvQAwhlgyA==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
Subject: [PATCH v5 0/5] Add support for BSH SMM M2 and S2 boards
Date:   Tue, 14 Dec 2021 21:30:45 -0300
Message-Id: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BSH SystemMaster (SMM) M2 and S2 board family.

Changes in v5:
* Fixed typo in Makefile: s/dts/dtb

Changes in v4:
* Fixed typo in patch 5/5 subject: s/imx8ulz/imx6ulz
* Added "fsl,imx6ulz" to SMM M2 compatible.

Changes in v3:
* Fixed node names to use hyphens.
* Reorder nodes in alphabetical order.
* Removed unneeded newlines.
* Removed vendor wifi properties.
* Renamed labels and nodes consistently.

Changes in v2:
* Added M2 board support.
* Added dt-bindings for vendor prefix and board compatible.
* Fixed pmic dt entry.

Ariel D'Alessandro (4):
  dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
  dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
  arm64: dts: imx8mn-bsh-smm-s2/pro: Add iMX8MN BSH SMM S2 boards
  dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board

Michael Trimarchi (1):
  arm: dts: imx6ulz-bsh-smm-m2: Add BSH SMM-M2 IMX6ULZ SystemMaster

 .../devicetree/bindings/arm/fsl.yaml          |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts      | 146 ++++++
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx8mn-bsh-smm-s2.dts  |  48 ++
 .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    |  80 ++++
 8 files changed, 709 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts

-- 
2.30.2

