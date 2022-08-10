Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAF58E892
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiHJISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiHJISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:18:47 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758AB83F3D;
        Wed, 10 Aug 2022 01:18:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD0E9C010E;
        Wed, 10 Aug 2022 10:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660119523; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=FnhAaCJj1LfrfmWPWI224zJGw++9nfoQ3otxs6xa9sk=;
        b=expopMW6lTTRTWKJgkWkHMOZdxUEPMG5+b2CHBxTapdhP0reEruuL+EChoNl/NM0fu/gOh
        Q+mVilMmiddGMlx/KlKMRUWTw6pZ361Tvgehg75QqR1HQHBKMVDgqGtxoL5bRSw7QHNDdm
        NO5jf6ZqmwdmW2GO74jPMVhwnzNVElNoJ625cUy6dm4KG80snqhnmHEOmRz1zmPyR0GCWw
        DblkRvsuYJ78qZUK6nVgsLSXEIasm49exRMii1QuS4SzVs1McYikqFA2Ltr3hdfn3cKn4s
        u4wf0DSNs4V9TlyPDIyJdq4cOJDEAdcn2a0xM4SWuPj9c91An8sOO89YQBkUVQ==
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
Subject: [PATCH v2 0/3] ARM: dts: imx6ul-kontron: Improve devicetrees
Date:   Wed, 10 Aug 2022 10:18:20 +0200
Message-Id: <20220810081825.19051-1-frieder@fris.de>
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

This series doesn't contain any functional changes.
---
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
 ...tron-n6310-s.dts => imx6ul-kontron-bl.dts} |  9 ++--
 .../boot/dts/imx6ul-kontron-n6310-som.dtsi    | 41 -------------------
 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts  | 16 --------
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 ------------------
 ...mon.dtsi => imx6ul-kontron-sl-common.dtsi} | 15 +++++++
 arch/arm/boot/dts/imx6ul-kontron-sl.dtsi      | 14 +++++++
 arch/arm/boot/dts/imx6ull-kontron-bl.dts      | 15 +++++++
 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts | 16 --------
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 ------------------
 arch/arm/boot/dts/imx6ull-kontron-sl.dtsi     | 13 ++++++
 14 files changed, 80 insertions(+), 183 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s-43.dts => imx6ul-kontron-bl-43.dts} (93%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-s.dtsi => imx6ul-kontron-bl-common.dtsi} (100%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s.dts => imx6ul-kontron-bl.dts} (52%)
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-som-common.dtsi => imx6ul-kontron-sl-common.dtsi} (90%)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-sl.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-bl.dts
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-kontron-sl.dtsi

-- 
2.37.1
