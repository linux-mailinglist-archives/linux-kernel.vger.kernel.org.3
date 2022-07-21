Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C217A57D494
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGUUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGUUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:52 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 13:05:50 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8C74379;
        Thu, 21 Jul 2022 13:05:48 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MdMsu-1nfHaT43lo-00ZNSc;
 Thu, 21 Jul 2022 22:00:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH v1 00/12] ARM: arm64: dts/clk: imx8mm: indentation whitespace cleanup
Date:   Thu, 21 Jul 2022 21:59:23 +0200
Message-Id: <20220721195936.1082422-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5cw2TNpGLkkb0Jw3PfQw0Tkjd8MMdgaenIjXAMyu+FXNft96YWP
 ZUDHH45QL/jHX9Q/xAvWhDGHoH7ZS/7SDLGnZiNbjnJDw5KCwZxZxJT12/KkI+429VRBTvf
 mXJ19nuSXUE58zgHThjab++sFKtwUmCAZAbuD29OAgU1KSFsfSdKlCumecn6Iwe4FdQ6utI
 WitXLQReaxlkxKbHl75Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/cnUxcV+a4=:5PrEH83s6KBtqKUsL0XvUR
 DIqYgkaYxZOntGChikF4zFzODNSUSqXcWHCpCRSadpRBb9S4y6CySmcBL1t8D0wrcjhitxd8E
 2TZTZnYc6Yd10dHl135H9FZNq644Wu8s6SrUBeiivtRejYbJAjqzHqvKesZBQuNmsCvVZzxET
 vrMq2vbR8/zLGrl7DE1djBu2zpcOyHBXSOAZsYqS3Foh65VIIMKb+Hdy35aLtIjfABXLPNIZW
 tZ//xoGocTdtJ3y9pu/ScQB+FJdmqgkB/RasVX+tv7HwN59s7MwMTcLFTSjSNtXByBVP+xQqw
 JzAgXsZbv6xbp85WELN2xMtAZOg1+THoB4KEXVzqUWYS8ulnGeyPruLnThEDaFxyP5e5XSrYB
 eS/NxPvjQBFLYBAG2FrPRCkeCm93sOpH0miQwFM6rCd/PC+c2GD6Xy79TBfqcXg4j4lERokdL
 s74ZAhg15MXuy0KsvIChR5gpb9EB/9jt4N6IoV7JzVBolRKokiKwn5+Esg07L3LHlHWyHmUe8
 j9qR/tbHO1STWc0TwwXsb7FvzMSDGC29KKsA7BEg3CL+gEKg4fk4t+Ycyxtjrdd+ue05ZqhOz
 45Wk/zxbgyP60bg6VEyWcnbHpCqL8jViuuhDVpnonZt5b+JAHAL3Fx4Bpg9UUGv1kodNWSfXT
 /aEhaVjv/tmIvHmLKVZrs5wXk38xmJODXm6JdQbp25NVPlHw+3zVV5dDFWiwCuSyf6e3F77UO
 lLvWGIp++TUlCYEBsUwGdgvhZUXnH6ro3f69aIXaUh6abmI9Nk6VedBfKGE=
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

