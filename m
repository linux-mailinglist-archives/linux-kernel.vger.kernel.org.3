Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC9479E01
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhLRWfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:35:09 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39498 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhLRWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:35:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EED01A06E1;
        Sat, 18 Dec 2021 23:35:07 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72E1C1A06FF;
        Sat, 18 Dec 2021 23:35:07 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1114020304;
        Sat, 18 Dec 2021 23:35:06 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] clk: imx: Updates for v5.17
Date:   Sun, 19 Dec 2021 00:34:42 +0200
Message-Id: <1639866882-9578-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.17

for you to fetch changes up to 9dd81021084ff22cf88a180d720f4f4b47392059:

  clk: imx8mp: Fix the parent clk of the audio_root_clk (2021-11-22 17:33:12 +0200)

----------------------------------------------------------------
i.MX clock changes for 5.17

- Set suppress_bind_attrs to true for i.MX8ULP driver
- Switch from do_div to div64_ul for throughout all drivers
- Fix imx8mn_clko1_sels for i.MX8MN
- Remove unused IPG_AUDIO_ROOT from i.MX8MP
- Switch parent for audio_root_clk to audio ahb in i.MX8MP driver

----------------------------------------------------------------
Adam Ford (1):
      clk: imx8mn: Fix imx8mn_clko1_sels

Changcheng Deng (1):
      clk: imx: Use div64_ul instead of do_div

Hui Wang (2):
      clk: imx8mp: Remove IPG_AUDIO_ROOT from imx8mp-clock.h
      clk: imx8mp: Fix the parent clk of the audio_root_clk

Peng Fan (1):
      clk: imx: imx8ulp: set suppress_bind_attrs to true

 drivers/clk/imx/clk-imx8mn.c             | 6 +++---
 drivers/clk/imx/clk-imx8mp.c             | 2 +-
 drivers/clk/imx/clk-imx8ulp.c            | 1 +
 drivers/clk/imx/clk-pllv3.c              | 6 +++---
 include/dt-bindings/clock/imx8mp-clock.h | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)
