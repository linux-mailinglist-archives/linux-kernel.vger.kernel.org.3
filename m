Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D781753AF91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiFAVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiFAVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:44:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4233A3C;
        Wed,  1 Jun 2022 14:43:56 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 34BC6100006;
        Wed,  1 Jun 2022 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654119835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QNra6cYe7rAZmodYJlA+KCX2uI9roIVccpwi/1khbXY=;
        b=M3lBkn8EIlwxc0Jkj0TmAnQ7Gep9ftMoNCAkF7PJGS76XF9RgSN8UMRAPH1l5VxcnoNV97
        B61zMQCx1J4+MzlibcyrY0E3VYq/iaII/6EOqiIrJAXQLz6icy0Rgs35xQ9SEZuorHpNRa
        PUgEZJaczzC4CFSMvbbrwEhYBN/OEh2PItjPhnVKmKyoDuUZ/mh+o7KAg9lPb/d/nbaexy
        INaBsgp2gsJa+nMHO8z4owBOn275jxNH1beCwll/Wxq2cfg3vEWNxWkwQ/9/ftiaAemNR6
        SsyGsAGwNZRR4zPQRUJASQr1roEmTYMtt0BxdoTm51KVRlpbpsrdNWRJohP3CA==
Date:   Wed, 1 Jun 2022 23:43:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 5.19
Message-ID: <Ypfdmml1GWU+gYzP@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the pull request for the RTC subsystem. A new driver represents
the bulk of the changes and then we get the usual small fixes.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.19

for you to fetch changes up to f78e3d407a339ffdd2620140300f821ea41118f4:

  rtc: mxc: Silence a clang warning (2022-06-01 23:19:17 +0200)

----------------------------------------------------------------
RTC for 5.19

New driver:
 - Renesas RZN1 rtc

Drivers:
 - sun6i: Add nvmem support

----------------------------------------------------------------
Dan Carpenter (1):
      rtc: rzn1: Fix error code in probe

Fabio Estevam (3):
      dt-binding: pcf85063: Add an entry for pca85073a
      rtc: pcf85063: Add a compatible entry for pca85073a
      rtc: mxc: Silence a clang warning

Miaoqian Lin (1):
      rtc: ftrtc010: Fix error handling in ftrtc010_rtc_probe

Michel Pollet (1):
      rtc: rzn1: Add new RTC driver

Minghao Chi (1):
      rtc: simplify the return expression of rx8025_set_offset()

Miquel Raynal (6):
      dt-bindings: rtc: rzn1: Describe the RZN1 RTC
      rtc: rzn1: Add alarm support
      rtc: rzn1: Add oscillator offset support
      MAINTAINERS: Add myself as maintainer of the RZN1 RTC driver
      rtc: rzn1: Avoid mixing variables
      rtc: rzn1: Fix a variable type

Nobuhiro Iwamatsu (1):
      rtc: meson: Fix email address in MODULE_AUTHOR

Samuel Holland (1):
      rtc: sun6i: Add NVMEM provider

Yang Li (1):
      rtc: rzn1: fix platform_no_drv_owner.cocci warning

Yang Yingliang (1):
      rtc: mt6397: check return value after calling platform_get_resource()

Yuan Can (1):
      rtc: gamecube: Add missing iounmap in gamecube_rtc_read_offset_from_sram

 .../devicetree/bindings/rtc/nxp,pcf85063.txt       |   1 +
 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml  |  70 ++++
 MAINTAINERS                                        |   8 +
 drivers/rtc/Kconfig                                |   7 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-ftrtc010.c                         |  34 +-
 drivers/rtc/rtc-gamecube.c                         |   1 +
 drivers/rtc/rtc-meson.c                            |   2 +-
 drivers/rtc/rtc-mt6397.c                           |   2 +
 drivers/rtc/rtc-mxc.c                              |   2 +-
 drivers/rtc/rtc-pcf85063.c                         |   2 +
 drivers/rtc/rtc-rx8025.c                           |   7 +-
 drivers/rtc/rtc-rzn1.c                             | 418 +++++++++++++++++++++
 drivers/rtc/rtc-sun6i.c                            |  42 +++
 14 files changed, 579 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
 create mode 100644 drivers/rtc/rtc-rzn1.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
