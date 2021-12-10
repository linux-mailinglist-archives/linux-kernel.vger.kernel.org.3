Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6F470179
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhLJN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbhLJN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:27:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68865C061746;
        Fri, 10 Dec 2021 05:23:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 9E92F1F4769D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639142615; bh=1nJvEo36zDpdG3J3E3m50DO3JfPFJlayX04qrqPzRLI=;
        h=From:To:Cc:Subject:Date:From;
        b=Nq/0WLIoQBRgBt2H6XU/sz5q1UjHnzA7PcMMYksTUrktQR2J3IdPAHbiPCiQtH7Nv
         ogrGDmhXfF4toqniIyu7TSTsldMoyR78LAQtDgEkMyBPOUagBx9bzHu+shCnJVs7Bd
         KBmDae6vz+kAcbeqLBvcCQ8wV3EW3sT1FNLjFhG1NiHVEjL5Ft99JVKAYqApEcyp2I
         qRsIABUSi+zEJN1A7biEbHot+/cC2CXIYKHCTfOAluzR03beClVMm+ngt0Yn0uxpZa
         lJ7cWxZkAIIt7ZXB2NkcVo9TEt25kUPT/1y2VJZrfoqCTo5c4gfyUxblgJ2B/mlRc8
         GM+nlOtU4t9Tw==
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
Subject: [PATCH v4 0/5] Add support for BSH SMM M2 and S2 boards
Date:   Fri, 10 Dec 2021 10:23:14 -0300
Message-Id: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BSH SystemMaster (SMM) M2 and S2 board family.

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

