Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D394C3AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiBYBBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBYBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180F1D7900;
        Thu, 24 Feb 2022 17:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB5B60018;
        Fri, 25 Feb 2022 01:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD6C340E9;
        Fri, 25 Feb 2022 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645750860;
        bh=LEUvVyJf5cRB20ty21mmJoKrDKMR5TvDrg3YYk4f+bo=;
        h=From:To:Cc:Subject:Date:From;
        b=rFbXQm57VMhdopxkkl8tz5iBt2wWfdigKw8ZhqVP56yQLRhSUB5bQvLlB36Qjc8hy
         ph9+8HQq+015PcRZUE1u0nK5UmdqqWHp7230BmxrnPhD5Yrz/4cEGQcjpKe6XRlmS5
         Nimk4KOHoSqBanzFzW8ALShEdhEl+LXYyNAds3skH94dg/jqVOaZefE1y8G5moORiW
         BTQt2uVDJFkT8fT/M6VDV7fMWzkScOVxpZpyZ8zS1wx7whzaEgXDsBS0r0Ap6I1EXj
         vWDpJMn7/yGkhMi28bQxcDlN2JkERcfVfzsg1VGK9Veu3kHhtVc4zPwQXFhI+NKagU
         +DrZzQcAjIvtQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.17-rc5
Date:   Thu, 24 Feb 2022 17:00:59 -0800
Message-Id: <20220225010059.1877605-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 2f0754f27a230fee6e6d753f07585cee03bedfe3:

  clk: jz4725b: fix mmc0 clock gating (2022-02-17 17:05:07 -0800)

----------------------------------------------------------------
A couple driver fixes in the clk subsystem

 - Fix a hang due to bad clk parent in the Ingenic jz4725b driver.

 - Fix SD controllers on Qualcomm MSM8994 SoCs by removing clks
   that shouldn't be touched.

----------------------------------------------------------------
Konrad Dybcio (1):
      clk: qcom: gcc-msm8994: Remove NoC clocks

Siarhei Volkau (1):
      clk: jz4725b: fix mmc0 clock gating

 drivers/clk/ingenic/jz4725b-cgu.c |   3 +-
 drivers/clk/qcom/gcc-msm8994.c    | 106 ++++----------------------------------
 2 files changed, 10 insertions(+), 99 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
