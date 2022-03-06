Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4774CEDBA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiCFUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiCFUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:35:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A85D5E7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38B96CE0DAD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 20:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3313C340EC;
        Sun,  6 Mar 2022 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646598845;
        bh=wrwVwQapicFPYWL6+dMkhbUm04/gLR/hbWafriYLBbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HlqgctBU0dFeFx8RFbRgPRPzphi0sifOezqPeSSL0Niv7jOTqVP3qtlMVAgdRkd/A
         b5BKQ85VxT7/2IY5AiDrrwpu9nPBD2BZT9WD9Q4ABrKNmXckDcEqcrw3io5w18Bx4N
         IaAt46OkgHMQO+Hoc5xMBcjxPx52gEiZMsfBcvDHxDrzZHQoPZ8pXar2FhrfjD1NVO
         fiYxXnZfV8CNcTCytjJ8TKS/BtubNE3xNObJLsUf1QXMEZZeVvMloUe1G5TjO3U1rG
         ADbdxNqovQ0InvxqSO/vkEKMLY3t5vz+8nB7aHOO7Qg1ZFgC7c69OPn0SLt2ImPJfX
         qkVXuo2CP4DOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9016EE7BB18;
        Sun,  6 Mar 2022 20:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes for tracing
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220305203747.560f8439@yoga.local.home>
References: <20220305203747.560f8439@yoga.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220305203747.560f8439@yoga.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc5
X-PR-Tracked-Commit-Id: 1d02b444b8d1345ea4708db3bab4db89a7784b55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f40a33f5ea54c01d640b150eb63e94defeb9b614
Message-Id: <164659884558.14106.7969812802443354574.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Mar 2022 20:34:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Mar 2022 20:37:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f40a33f5ea54c01d640b150eb63e94defeb9b614

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
