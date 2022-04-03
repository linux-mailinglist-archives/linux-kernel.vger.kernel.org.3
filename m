Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B664F0A1E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358985AbiDCOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358991AbiDCOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:11:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4322519;
        Sun,  3 Apr 2022 07:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20689611B5;
        Sun,  3 Apr 2022 14:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B695C340ED;
        Sun,  3 Apr 2022 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648995000;
        bh=joIH5I0zGHIhBrW3DT6hA5M33SXiiCdtvH0QJ6/Q8Nc=;
        h=From:To:Cc:Subject:Date:From;
        b=uwMR5LJ/MsEe/XQwmNGm8cUPtx9ch4fHxiwRv1l3MmYaQ51WpO60+js1dnIl2kuW6
         7LGukAAInEzOWV1IG5oJg0lf6JThRgnpVzxUGV+r5OiO7CVOCmy0Q0gfFEP445OS2F
         F6CEM6446sqfCloc6OLCo95mibAAEEb2hqotTNYYxHP63UecV5UuUfT1OwLumPt+a1
         IGOjWA2QYUnFL/+ZN+OnBv59PeR+3bLeCiSVN2DFFjdFyAT6wgOZ0aUZdb+yWoKk5v
         u9M+pwyc60hlbZHqEHVicGt24yjp1JaE1Om8dhS50gDVGTUtZBND7BcmyyWyHtuM8/
         hNxAE9iKzcewA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] one more clk change for the merge window
Date:   Sun,  3 Apr 2022 07:09:59 -0700
Message-Id: <20220403140959.113778-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
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

The following changes since commit cf683abd3913d5e6e51169de75d65ea193452fbd:

  Merge branches 'clk-sifive' and 'clk-visconti' into clk-next (2022-03-29 10:19:52 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 859c2c7b1d0623a6f523f970043db85ce0e5aa60:

  Revert "clk: Drop the rate range on clk_put()" (2022-04-02 19:28:53 -0700)

----------------------------------------------------------------
A single revert to fix a boot regression seen when clk_put() started
dropping rate range requests. It's best to keep various systems booting
so we'll kick this out and try again next time.

----------------------------------------------------------------
Stephen Boyd (1):
      Revert "clk: Drop the rate range on clk_put()"

 drivers/clk/clk.c      |  42 +++++++------------
 drivers/clk/clk_test.c | 108 -------------------------------------------------
 2 files changed, 14 insertions(+), 136 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
