Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2F8506376
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347771AbiDSEvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiDSEv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DBA2F3BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:47 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002uP-FJ; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047Pn-Da; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 00/17] protonic fixes 
Date:   Tue, 19 Apr 2022 06:48:07 +0200
Message-Id: <20220419044824.981747-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v2:
- spell fixes
- rename arm -> ARM

This patch series provide two main part of changes:
- Remove prototype specific deprecated code not used in production.
- Unify vicut1 and victgo variants to reduce maintaining overhead.

David Jander (16):
  ARM: dts: imx6qdl-vicut1.dtsi: remove TiWi module
  ARM: dts: imx6qdl-vicut1.dtsi: Put nON_SWITCH in own pinctrl grp
  ARM: dts: imx6qdl-vicut1.dtsi: Remove PCIe
  ARM: dts: imx6qdl-vicut1/victgo: Remove UART2
  ARM: dts: imx6qdl-vicut1.dtsi: Fix LED names
  ARM: dts: imx6qdl-vicut1.dtsi: Fix debug LED gpio pins
  ARM: dts: imx6qdl-vicut1.dtsi: Update GPIO line names
  ARM: dts: imx6qdl-vicut1.dtsi: Remove conflicting pinctrl entry
  ARM: dts: imx6q-vicut1.dts: remove sata node
  ARM: dts: imx6dl-victgo.dts: update gpio names
  ARM: dts: imx6dl-victgo.dts: Factor out common parts to
    imx6qdl-victgo.dtsi
  ARM: dts: imx6qdl-vicut1.dtsi: Move some node out to DTS files
  ARM: dts: Remove imx6qdl-victgo.dtsi
  ARM: dts: imx6qdl-vicut1: Factor out common parts of 12inch board
    variants
  ARM: dts: imx6dl-victgo.dts: Remove touchscreen x axis inversion
  ARM: dts: imx6qdl-vicut1.dtsi: Add missing ISB led node

Oleksij Rempel (1):
  ARM: dts: imx6qdl-vicut1.dtsi: add thermal zone and attach tmp103 to
    it.

 arch/arm/boot/dts/imx6dl-victgo.dts          | 682 +------------------
 arch/arm/boot/dts/imx6dl-vicut1.dts          |   1 +
 arch/arm/boot/dts/imx6q-vicut1.dts           |   5 +-
 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi | 128 ++++
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi        | 222 +-----
 arch/arm/boot/dts/imx6qp-vicutp.dts          |   1 +
 6 files changed, 178 insertions(+), 861 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi

-- 
2.30.2

