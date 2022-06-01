Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166753AEDA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiFAVxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiFAVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175E248D0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E88614A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C3DC34119;
        Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654120384;
        bh=A3Y/hhUIu9rwXN92/CQd7PyYC9u6dgXtTgA+FUAIEeE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hq34C+22to9uUSz1dgZgysCia0AvkocB1xdFtqsvWXOpwUf0xI8ofCGRuLRDsnxfD
         bS54mc/1FeZY11RS+FhJxU70066LoFKTVDdgHvNqIZppBiEofImh3UU25qTwCi0KuE
         hr4oD+3ZEtnVh4zwf/F9a2VKUSwUjiPn1DoNQvKq5Wl/dfcpp7f8Ziq14tb3U0W6/y
         qCAgUxoiTWFv5f8tMz1+evOG3tDzdlEIQj0MAnqXrYjrRLazgeF2s/6A/qcmc9JxFi
         OiTHRBqqwfu8BapgAQmdgh0WA3OxmFoPMPrstjyvj99mfiIUg73y74MoQxjpGZ5nd8
         Ad7w+SG1PAV/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0CE7F03950;
        Wed,  1 Jun 2022 21:53:03 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpfXf/unhrWZkE3j@mail.local>
References: <YpfXf/unhrWZkE3j@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpfXf/unhrWZkE3j@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.19
X-PR-Tracked-Commit-Id: 66ed42caf286a7aaeb6f1db4b2995dd9416226c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55fe92179058406fe00bff2167c94443a7b2e07a
Message-Id: <165412038391.5556.7245944693656757925.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 21:53:03 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 23:17:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55fe92179058406fe00bff2167c94443a7b2e07a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
