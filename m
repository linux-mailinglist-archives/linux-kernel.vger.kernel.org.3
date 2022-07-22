Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131A157E953
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiGVVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiGVVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:29 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D56325;
        Fri, 22 Jul 2022 14:55:28 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LfCzm-1ni9kn3EyG-00opOG;
 Fri, 22 Jul 2022 23:54:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <dev@lynxeye.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] ARM: arm64: dts/clk: imx8mm: indentation whitespace cleanup
Date:   Fri, 22 Jul 2022 23:54:33 +0200
Message-Id: <20220722215445.3548530-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pa80ww+a5pcL8EDvRAjSLBvyasPlxCO3ZVMijNfrAbcgdn2N3JB
 kyCbv1Pbe4+2OAZsVr5vPiNbpGRgS43UTgs5RLlryJ/Hk6oeJQ0PqjViBFHA2pTkaDBo7TK
 A36HlZcMg6mJPvFFvacX5Et0tamRcvxN24Gkqr6sExg+TXuUFl57bXXbMdTCG5Ic3+yX8Ch
 DLPLc29C+3X7KNv92Z5PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7EOL6CV7BbY=:PcUb/OfF2nACHOicKQCah8
 t2aZ9m7YthG14oKwuHt4q137TcAEQ6+s1eY5J2yoZnr6jtrh7LKDMc1guWNb/HmVQftDCDaMP
 fm8Tn1e7ODrqvj3cOAKMpTFX98KQXaurwTXT4ZK8+l6Rlsx3ZsleutNHoncvoEYJiHilrknJZ
 Adym3S4+DvLvXGw4AMOaWNgTswvjqJ7o/f/CLwz9IFrEcFkntAmeDC4XxUJ2eZ4g+FeU36Omd
 Ju1Xnxrb5bfWSmOfCMK1UQpYifial2yq7c8XDQYzBuR0/vKKa0p+Nh+jXn1AVv+cnqP+QgDUs
 mkNiGqjPCvxwVWUyH4OiH/IL6XiApsv20uWaOF/tGkHOHufM76Ag/JiXTRfi5QKw3z8n/+pI3
 dFsK3CIic7Hb/enkQ32pLZvmXH1mty0EvR15E+LKuQ3JVOQr5LODawkulSzgUXss89o+3C/Ig
 8qjZF+kQnuEF2iy4q/Ssli+nPorB1VIc3SrxSPtbeN/6RdVtHnyzg2w8MgMTvBXgeREyMGmrL
 1+DvQgb8P9/xPUpBboOB2BtjBdrbRVJCqLpJlYvdNZzrhQPNdMLM/p3uzUUazGZOpPdV/4kWK
 asv5BtsW0BW0HCAUXgiE1F3dDIf4Ev43gf5EG38xgi8N+WWnhqpaMhNfTMxmHyUx5fyBZDAgN
 ugWX/LHuNCIn7PzUVMVtCFblRW0RRBqYniRIKwGAhBL7lNBikw2z8UgyNOREv55/a6Ud1m5hG
 9zzjqaDjdgLBd5WEfJVysjGTugXxcMfcE7t1zQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


While synchronising them imx device trees with U-Boot I stumbled over
various checkpatch warnings. This series addresses those trivial
indentation and/or whitespace cleanups.

Changes in v2:
- The GPL part of the boilerplate license was actually GPL-2.0 only.
- Add Alexander's acked-by. Thanks!
- Add Lucas' acked-by. Thanks!

Marcel Ziswiler (12):
  ARM: dts: imx6-sabrelite: change to use SPDX identifiers
  ARM: dts: imx6qdl-mba6: don't use multiple blank lines
  ARM: dts: imx6qdl: phytec: no spaces at start of line, indent use tabs
  ARM: dts: imx6qdl-sabre: change to use SPDX identifiers
  ARM: dts: imx7d-pico: indent use tabs, no spaces at start of line
  ARM: dts: vf610: no spaces in indent but tabs
  ARM: dts: vf610-twr: indent use tabs, no spaces at start of line
  ARM: dts: vf610: don't use multiple blank lines
  arm64: dts: imx8mm-venice-gw72xx-0x: blank line at end of file
  arm64: dts: imx8mp-verdin: don't use multiple blank lines
  arm64: dts: mnt-reform2: don't use multiple blank lines
  clk: imx8mm: don't use multiple blank lines

 arch/arm/boot/dts/imx6q-sabrelite.dts         | 37 +------------------
 arch/arm/boot/dts/imx6qdl-mba6.dtsi           |  1 -
 .../dts/imx6qdl-phytec-mira-peb-av-02.dtsi    |  2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi      | 37 +------------------
 arch/arm/boot/dts/imx7d-pico.dtsi             | 10 ++---
 arch/arm/boot/dts/vf610-pinfunc.h             |  2 +-
 arch/arm/boot/dts/vf610-twr.dts               |  2 +-
 arch/arm/boot/dts/vf610.dtsi                  |  1 -
 .../dts/freescale/imx8mm-venice-gw72xx-0x.dts |  1 -
 .../boot/dts/freescale/imx8mp-verdin.dtsi     |  1 -
 .../boot/dts/freescale/imx8mq-mnt-reform2.dts |  1 -
 include/dt-bindings/clock/imx8mm-clock.h      |  1 -
 12 files changed, 10 insertions(+), 86 deletions(-)

-- 
2.35.1

