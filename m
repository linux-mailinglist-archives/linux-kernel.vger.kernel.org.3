Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C254BD1BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbiBTU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:58:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245056AbiBTU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600641402F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E26B860F08
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A3ADC340E8;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645390690;
        bh=yHTStGzuy/VD8j3BxZOw2zjTq0DsDGyg8tTLloi4OQ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q8MfKeXbeDzjSH9R4dW9ip4Tj+4U89CYW2sDHXsiJibAiTZjvIX03oBbRqb4TqSvh
         Kkl/sgW91kyGewSOriirH8xhhh9Jze3f+eGzPerl6GHj2AQGerVhCZJTAzOrgCQWgA
         BT5p3E5pGtRtp9JyMwcgvE1WZsAjlQL4ISyB+M5PLcZy0jTriP0G18gaSu/xDzkOas
         sYsrZeuorX7RxXHJ9I7sI6BXC56nA0TCUnDlKsqSLQZHgAXo0311UPAe12VSImLih6
         ibRivRpkFKIL3hRZmAif5rbKq2Ti7qo6ayAe3hrdrt1tB9BXperuGMzdtqwNcoxvtx
         2MMuaKNwNGA3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 486E4E5D07D;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhIviC2M5OwHYcUY@zn.tnic>
References: <YhIviC2M5OwHYcUY@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhIviC2M5OwHYcUY@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc5
X-PR-Tracked-Commit-Id: b1e8206582f9d680cff7d04828708c8b6ab32957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b0894ff78cc47bc72d53ec340e4898782189868
Message-Id: <164539069028.9723.4798995575903734791.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 20:58:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Feb 2022 13:09:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b0894ff78cc47bc72d53ec340e4898782189868

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
