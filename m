Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4846DBFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhLHTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbhLHTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:24:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E4C061746;
        Wed,  8 Dec 2021 11:20:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id EBD861F461B4
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638991229; bh=9Q9gZlQDhEeaARL4RpyzUyz/82SDp+XM1jEcSwgmoA0=;
        h=From:To:Cc:Subject:Date:From;
        b=UbNh9PB8xf2CuCu1a3dyq3lEdc5ztJgif1J1t0rw+/2CGzcrc24xvJIgWplYlrv0+
         FGe1U801QZ/1atIYdSs+2hJs+brjZ07vaGBuTC4t3alxnKBzxCr6PULAUrp6b+Q2Ig
         Nwgm0MGsVjXEyAi/l0lUQa3DU1O4Z6oeQipdhJj6wM56wnI/qejABC40DBqkIyS82h
         e0TunVH4PyaK8erBfRQ605FV/nkV3hoYI0qGZIuzKa+3ef0Qspb7pdVOjAMkIGMauD
         0P38I8kkO7mqDVkZEYiVi9URUIvv4ZCBZKX1QvtaMFm/uMSi9VZRF5B+8TFJd3ymMx
         VXPgM3Ag5YwZg==
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
Subject: [PATCH v3 0/5] Add support for BSH SMM M2 and S2 boards
Date:   Wed,  8 Dec 2021 16:20:04 -0300
Message-Id: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BSH SystemMaster (SMM) M2 and S2 board family.

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
  arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2 IMX6ULZ SystemMaster

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

