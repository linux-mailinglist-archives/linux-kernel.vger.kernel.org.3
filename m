Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA358B887
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiHFWIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 18:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiHFWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 18:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2373D10FFE
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 15:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B482160C66
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25139C433D7;
        Sat,  6 Aug 2022 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659823715;
        bh=jZ0uCQ6by0VwAs59D5COi1dX0BnewwZqZNVNuMw2mdw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qnIb+hvUmHFHi056ppH659k9KBA5VY22QTa3oW/X6P5Ak/H62+gjoX4O6QpMMz6nV
         f18fNxbtbsrUUyaswIkiipGnEFBnqugSZftyQ4BhUbj6hvWJGBpWDVuzY3oAj1/CjO
         I934C8HMiLm9Tq2wv3AwsJtXkBG6Aeu+VVBviDva87JQd9FilPUmXVcPXzqW1EifNL
         XWmWZ6wNEIatFRKSKOgIf6cXlCF0yZMCMRvPexW36imKV6LtQEDhewlrkIhmY0Gmej
         2AIb5qP279tVbeiPx8yY8arBCgGKsKIsMg40fyYHplml5h26ShTl76HCizCvbKXdJ9
         wzxwDs4P79nqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1615FC43142;
        Sat,  6 Aug 2022 22:08:35 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.20 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
References: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-1cbba637-6dd2-456a-859b-9d3f8be6bab7@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw0
X-PR-Tracked-Commit-Id: ba6cfef057e1c594c456627aad81c2343fdb5d13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d1044fcb996e8de9b9ab392f4a767890e45202d
Message-Id: <165982371508.16627.10357025252070843404.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 22:08:35 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 Aug 2022 16:36:38 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d1044fcb996e8de9b9ab392f4a767890e45202d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
