Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FA592D06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiHOI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiHOI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:28:25 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED731F2D6;
        Mon, 15 Aug 2022 01:28:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E393FBFADB;
        Mon, 15 Aug 2022 10:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660552100; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=zj3e45wE4VaaixX25Yhb3oPW7wVrr1tETt65ii38iRQ=;
        b=QFC3+N8y5nSoOQ5LTNqHHDMYGCf1cm9blxBA6e6Sp87YVd+UiWIWKNMmmA0G8w04TiAaNI
        UscwJd/C4GEA/XS8FlMbIkz44mMAGUKbmROdd72J3Jh5WAWN71NnKg12TMA2pE+PJnvr+u
        GWzaJBFRM+ZpoRiYDDoF409SpGvTaUsjBDgTIdPXlJPVVbhVdsQTLRLZLNFPOd2S/w7JrW
        qLYoOvQTEG26ITVpoK4hAwz5Et/z8h00Witn7pvGfCLlXF0q6PKBfe4x1EVzehllabgObS
        rs7Ev89LWXjU1dg/4XiiWneiDOCXxSUQSAwYIc0PkByaXLx1lERVCDzGaqyCRA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, soc@kernel.org
Subject: [PATCH v3 0/3] ARM: dts: imx6ul-kontron: Improve devicetrees
Date:   Mon, 15 Aug 2022 10:28:09 +0200
Message-Id: <20220815082814.27651-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This series contains some simplifications to the devicetree file structure
and updates the model names, compatibles and devicetree file names to match
what is used officially by the Kontron marketing.

This is a somewhat breaking change (for out-of-tree devicetrees that include
the SoM files) but it reduces the complexity quite a bit, makes things easier
to read and lets people discover the devicetree matching their hardware more
easily.

The first patch also updates the bindings to match up with the changes applied
in the following patches.
---
Changes in v3:
* Add A-b tag from Krzysztof (thanks!)
* Improve diff for patch 2
* Improve commit messages and cover letter

Changes in v2:
* Also rename compatibles to get rid of N6xxx notation
* Also rename devicetree files for consistency
* Squash model renaming patch into patch 2
* Move part of Makefile changes to patch 2

Frieder Schrempf (3):
  dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
  ARM: dts: imx6ul-kontron: Simplify devicetree structure
  ARM: dts: imx6ul-kontron: Add imx6ull-kontron-bl to Makefile

 .../devicetree/bindings/arm/fsl.yaml          | 31 ++++++--------
 arch/arm/boot/dts/Makefile                    |  5 ++-
 ...6310-s-43.dts => imx6ul-kontron-bl-43.dts} |  8 ++--
 ...x-s.dtsi => imx6ul-kontron-bl-common.dtsi} |  0
 ...tron-n6310-s.dts => imx6ul-kontron-bl.dts} |  9 ++---
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 -------------------
 ...mon.dtsi => imx6ul-kontron-sl-common.dtsi} | 15 +++++++
 ...-n6310-som.dtsi => imx6ul-kontron-sl.dtsi} | 33 ++-------------
 ...ron-n6411-s.dts => imx6ull-kontron-bl.dts} |  9 ++---
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 -------------------
 ...on-n6311-s.dts => imx6ull-kontron-sl.dtsi} | 11 ++---
 11 files changed, 49 insertions(+), 152 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s-43.dts => imx6ul-kontron-bl-43.dts} (93%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-s.dtsi => imx6ul-kontron-bl-common.dtsi} (100%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s.dts => imx6ul-kontron-bl.dts} (52%)
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-som-common.dtsi => imx6ul-kontron-sl-common.dtsi} (90%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-som.dtsi => imx6ul-kontron-sl.dtsi} (28%)
 rename arch/arm/boot/dts/{imx6ull-kontron-n6411-s.dts => imx6ull-kontron-bl.dts} (43%)
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6311-s.dts => imx6ull-kontron-sl.dtsi} (41%)

-- 
2.37.1

