Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A1585FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiGaQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGaQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071EFDFF9;
        Sun, 31 Jul 2022 09:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9660160F1F;
        Sun, 31 Jul 2022 16:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217FC433C1;
        Sun, 31 Jul 2022 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659284254;
        bh=QgAz5bY89pnm43xuM+ZChX7STSLA6T9WvSXtE1C3d/g=;
        h=From:To:Cc:Subject:Date:From;
        b=b/vwqyKDPnJ9m+s64qW8Jenp6E+spUubFrvV4NXkc2tXDD/kYMUuWs+Q9n27HMZEb
         eTkWmkXhRdN27pGAQHwbzMr1EJJ5tEd7q9Sab5Ma3V9gStxX2Y0A6ED76YTm6sRmgv
         bkTxLpabuc5KEpZHm7B5x/HJMnJZ0elB2ARYv0kWfVFMXRLXvQ4ujwhQ7xlJbUm0p6
         CQVoS9yCAUd0Zl9hd/ePsHIvGXXCZzjo07VHQ8z8G4kT6EWfl0EQdZ+VCuKxcDE1li
         8uf8mULMzQ6dQlhwsgaqM5KJD+JxwYk3EdTE4qrVmWm+giYnNx5/Q5Z0dcJyeiVdEr
         3PVIGRzcbeK+w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.19-rc8
Date:   Sun, 31 Jul 2022 09:17:32 -0700
Message-Id: <20220731161733.2786191-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 25c2a075eb6a3031813b6051bd10dfc22c36a2a4:

  clk: lan966x: Fix the lan966x clock gate register address (2022-07-19 00:04:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 8dc592c41f38735306d1f1dc0b183601379c6d94:

  clk: sunxi-ng: Fix H6 RTC clock definition (2022-07-27 16:45:58 -0700)

----------------------------------------------------------------
Fix a NULL pointer deref in the Allwinner clk driver with a one liner.

----------------------------------------------------------------
Jernej Skrabec (1):
      clk: sunxi-ng: Fix H6 RTC clock definition

 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 1 +
 1 file changed, 1 insertion(+)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
