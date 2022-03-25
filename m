Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E64E7BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiCYTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiCYTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA02EB56F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE90961BBA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F245C36AEC;
        Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228684;
        bh=hyJGO56HSjVwh/ZwNkn6sQFn7qXrmlFn+2JV0hzhmP4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S2iNMIX4hHMfJUaDIv52TnhlPuth2/IHSV0vTgDqTpZt0FGa7PfFievFGFt0cIvfo
         n3KNTfRZh4P0Ux94SJyb+J1hcKDAJtMwX6DvdRfyVP1jvdy8BOwt49sqaxuuij1UwT
         kLSaSZmW3NljRSfNvu4hBVV4qwqnpRp3YIYSSC1SFn4bZaMDHP8TJCpuk3TKdhJZbj
         ULkaVknxufLkZPSNyEgSeh6JVxsVZPnf6xuNqS4JqgrYTqvKld3GaVn9A36BNj3Qce
         Y5Gq/78A49NPqFQ1qjvi1eyqHyDQTz+LasWEf00MjClUUEUhvJU4mxXACcJkPmMjYI
         CFQjrEoaO+TMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D5DDE7BB0B;
        Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.18 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d6e408db-0c83-4358-9cef-831a694d582e@palmer-ri-x1c9>
References: <mhng-d6e408db-0c83-4358-9cef-831a694d582e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d6e408db-0c83-4358-9cef-831a694d582e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw0
X-PR-Tracked-Commit-Id: bbde015227e89f1da21bd3b84523d62c4a445c06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa5b537b0ecc16992577b013f11112d54c7ce869
Message-Id: <164822868411.13188.17412957672278212582.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 17:18:04 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 09:14:40 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa5b537b0ecc16992577b013f11112d54c7ce869

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
