Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375B4B5E15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiBNXOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:14:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBNXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:14:43 -0500
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400C177E7B;
        Mon, 14 Feb 2022 15:14:34 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nJkY8-00AkNe-81; Mon, 14 Feb 2022 23:14:28 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 0/4] imx8mm-venice: add dt overlays
Date:   Mon, 14 Feb 2022 15:14:20 -0800
Message-Id: <20220214231424.30927-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combined several overlay patches into a single series.

Tim Harvey (4):
  arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for serial modes
  arm64: dts: imx8mm-venice-gw72xx-0x: add dt overlays for serial modes
  arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlay for imx219 rpi v2
    camera
  arm64: dts: imx8mm-venice-gw72xx-0x: add dt overlay for imx219 rpi v2
    camera

 arch/arm64/boot/dts/freescale/Makefile        | 18 ++++
 .../imx8mm-venice-gw72xx-0x-imx219.dts        | 93 +++++++++++++++++++
 .../imx8mm-venice-gw72xx-0x-rs232-rts.dts     | 53 +++++++++++
 .../imx8mm-venice-gw72xx-0x-rs422.dts         | 61 ++++++++++++
 .../imx8mm-venice-gw72xx-0x-rs485.dts         | 61 ++++++++++++
 .../imx8mm-venice-gw73xx-0x-imx219.dts        | 93 +++++++++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs232-rts.dts     | 53 +++++++++++
 .../imx8mm-venice-gw73xx-0x-rs422.dts         | 61 ++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs485.dts         | 61 ++++++++++++
 9 files changed, 554 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts

-- 
2.17.1

