Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D504955B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiATU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:56:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95E8C061574;
        Thu, 20 Jan 2022 12:56:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE4ADB81E56;
        Thu, 20 Jan 2022 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB9C340E0;
        Thu, 20 Jan 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642712198;
        bh=r9MIPwMi//McqRxQuwHWGzNngh0Wy81WMuwUYEm0okM=;
        h=From:To:Cc:Subject:Date:From;
        b=u+RJvKKtBmiWeSU1LnCcaWBIjGUquKDSvaoWpHkOqsNXcJi50X1v8TJJbjTB65Lk8
         7JAktQUU1Lne5fhTJ/ELffpbf2WI1RAyH+y93nywqLbwOcFlYeNlkN2T8VG+LKXq08
         e2blWyiq/56TANkjSXRgX8KPyJZDmdqrnb3fPMsf59IbReAL2CJlpWlwyBXqliq8t8
         o3CHlv2w7bBoiqBxYAJGNNGKEnKXmSr4ARFl2tRHNJGagqSsDlNuncwUkgCixUvKOW
         uto6sCjNYOV4jXUqcfRErdHgJ/VmkZrt8pvCw+7BkIvW7ZvTYrt0HVfpbOxucd2832
         siCY/zYkUer/A==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for the merge window
Date:   Thu, 20 Jan 2022 12:56:37 -0800
Message-Id: <20220120205637.2234852-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4afd2a9355a9deb16ea42b896820dacf49843a8f:

  Merge branches 'clk-ingenic' and 'clk-mediatek' into clk-next (2022-01-11 18:31:00 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to b4966a7dc0725b2baa12b0aeb1489d52568a2aad:

  clk: mediatek: relicense mt7986 clock driver to GPL-2.0 (2022-01-19 12:05:07 -0800)

----------------------------------------------------------------
Some hot fixes for clk driver patches merged last week
and one oops fix.

 - Fix license on recent MediaTek drivers

 - Initialize a variable before use in the new Visconti driver

 - Avoid an oops by unregistering the clk provider in si5341

----------------------------------------------------------------
Dan Carpenter (1):
      clk: visconti: Fix uninitialized variable in printk

Robert Hancock (1):
      clk: si5341: Fix clock HW provider cleanup

Sam Shih (1):
      clk: mediatek: relicense mt7986 clock driver to GPL-2.0

 drivers/clk/clk-si5341.c                   | 2 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c  | 2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 2 +-
 drivers/clk/visconti/pll.c                 | 3 +--
 5 files changed, 5 insertions(+), 6 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
