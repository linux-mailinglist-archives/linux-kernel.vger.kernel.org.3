Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEF4FD66E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391022AbiDLJZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354736AbiDLIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1365FB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:40:19 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1neB8A-0007g8-Ln; Tue, 12 Apr 2022 09:40:06 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1neB89-00AQYb-5t; Tue, 12 Apr 2022 09:40:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v1 00/17] protonic fixes 
Date:   Tue, 12 Apr 2022 09:39:47 +0200
Message-Id: <20220412074004.2485264-1-o.rempel@pengutronix.de>
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

This patch series provide two main part of changes:
- Remove prototype specific deprecated code not used in production.
- Unify vicut1 and victgo variants to reduce maintaining overhead.

David Jander (16):
  arm: dts: imx6qdl-vicut1.dtsi: remove TiWi module
  arm: dts: imx6qdl-vicut1.dtsi: Put nON_SWITCH in own pinctrl grp
  arm: dts: imx6qdl-vicut1.dtsi: Remove PCIe
  arm: dts: imx6qdl-vicut1/victgo: Remove UART2
  arm: dts: imx6qdl-vicut1.dtsi: Fix LED names
  arm: dts: imx6qdl-vicut1.dtsi: Fix debug LED gpio pins
  arm: dts: imx6qdl-vicut1.dtsi: Update GPIO line names
  arm: dts: imx6qdl-vicut1.dtsi: Remove conflicting pinctrl entry
  arm: dts: imx6q-vicut1.dts: remove sata node
  arm: dts: imx6dl-victgo.dts: update gpio names
  arm: dts: imx6dl-victgo.dts: Factor out common parts to
    imx6qdl-victgo.dtsi
  arm: dts: imx6qdl-vicut1.dtsi: Move some node out to DTS files
  arm: dts: Remove imx6qdl-victgo.dtsi
  arm: dts: imx6qdl-vicut1: Factor out common parts of 12inch board
    variants
  arm: dts: imx6dl-victgo.dts: Remove touchscreen x axis inversion
  arm: dts: imx6qdl-vicut1.dtsi: Add missing ISB led node

Oleksij Rempel (1):
  arm: dts: imx6qdl-vicut1.dtsi: add thermal zone and attach tmp103 to
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

