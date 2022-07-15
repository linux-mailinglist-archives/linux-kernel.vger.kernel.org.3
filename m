Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88657664A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiGORpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGORp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8302F648
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 680F0622D0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9246C3411E;
        Fri, 15 Jul 2022 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907124;
        bh=4bmwIl2o7x4YCO14Yf2yJMsubjRYvJUEn6M6BhjyEEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DgbcPaBJHu0OEOPoXOHrdWcLG4VNqBef7AFzFVEesezf0yOfW+h6IgghroXdxSi7s
         SmM/iOxOtyPwqjzHWczWTnzfUwvTTk+R+Ipwm3sibhi99ZKzQ/P9K4+88LOWW8dcUB
         2YPDcWoIe5oj0rBwrp/R+A+GvkcyS5ch6hv81z0RhG4k5O7Aa87L/mSY+/wolpbYDe
         RhKcXrfGtD6cwn0bVvJ6uxf34W3udvMOY1iZ8YYVscu79MrYxi2cCmTLC0dIIuSr0w
         9y4XZ90aUddX8yr9O4gHO/K9u6C1Hz0CrhBgDVE/qQXKE9vrschyAxAx+Q+5GAcxpn
         4Sk1RYsjb4ceg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8419E4521F;
        Fri, 15 Jul 2022 17:45:24 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-077c44de-b969-4894-9547-066c73040835@palmer-ri-x1c9>
References: <mhng-077c44de-b969-4894-9547-066c73040835@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-077c44de-b969-4894-9547-066c73040835@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc7
X-PR-Tracked-Commit-Id: 7fccd723912702acfc2d75e8f0596982534f7f24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b59ec8d50a1f28747ceff9a4f39af5deba9540e
Message-Id: <165790712475.27298.12426922399606935955.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:24 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 10:31:09 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b59ec8d50a1f28747ceff9a4f39af5deba9540e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
