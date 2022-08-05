Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BF58A492
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiHEBuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiHEBuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9461B21;
        Thu,  4 Aug 2022 18:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1650B616F3;
        Fri,  5 Aug 2022 01:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D07D5C433D7;
        Fri,  5 Aug 2022 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659664204;
        bh=nvNkEWMl7rwE5EA62eNrASgeYW6u0++MumO0+TdMxfc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JrWY6L7FvKKGvFUxGGoj1yyrcw9YBmiT6gf/QhekY4PG8xU4AJKW281lo0GiUPkdq
         5+5DhKV4wNgyWLdO49fjQhkjMnfre1DALG2ZwlbxEmk0x7jHyWpedzarrKHPsRHohh
         VW5IKeZj/AY6Znz7gw0vaEwVFwQz+NFRYZSxzHZxZcn+WxEzXseNxNdbscwCsIkTJb
         IEUE7o7GqCp+ppjDQPM7OIZSB9tJckANwvvhD6oH+6kafymy3K1wREuwztsv8NyPJc
         NFa0+GXsvf54IHyNCM0yfnoj4BVwamGs3hdqRBs866m+usxAd4jotbbKHtUdUnn2I/
         QQN3XRCFl4vkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C187AC43140;
        Fri,  5 Aug 2022 01:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220805001029.4036778-1-sboyd@kernel.org>
References: <20220805001029.4036778-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220805001029.4036778-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 08fc500fe3d4b1f0603fb97ad353f246a3d52d2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36001a2fa6cc63d58664a2a99b90a864f9eb587a
Message-Id: <165966420478.23541.5062164942085569608.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:50:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 Aug 2022 17:10:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36001a2fa6cc63d58664a2a99b90a864f9eb587a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
