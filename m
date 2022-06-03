Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B506653D3D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349696AbiFCXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbiFCXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:25:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4001F620
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 16:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3316CE2548
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13E76C385A9;
        Fri,  3 Jun 2022 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654298705;
        bh=GXQUZOliOQvVsG0Mci5osOJcfbgOTiFd23jfQdwYEXM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MBxIVEgHM6BtZ5Oo/p9Watg/Hu0qMKQSxv5rItxq48dONmrYLS5bdzdb3oq+l3+gH
         7RtSpo1zZn19Ces0lftgnTw9FhbMM7u3SvyLyg3+bsp+B2FVn39yh4rufOETXCgOEy
         s3keUUr5XXn6MneCt0RjCx9n5gKoBoltBqw3xW18kYihI+YABlAmMfzBy5XO7vXzqw
         lcV2usc4DQH/4PLLC4THQALriK4mCdfBYQu8KBB76Eh8olu1+KjtWb9ghO1dsIclfc
         4Y9Ch4rD9fBb2dHfLiT53MksD5KoUIbanZrvETBNYaB6q9tgZyjbEZHLpXa7zVXP+i
         Mhq+tFjJ2gEBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01EE5F5F176;
        Fri,  3 Jun 2022 23:25:05 +0000 (UTC)
Subject: Re: [GIT PULL v2] kthread cleanups for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mtet7i04.fsf@email.froward.int.ebiederm.org>
References: <87v8th7i58.fsf@email.froward.int.ebiederm.org> <87mtet7i04.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87mtet7i04.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git kthread-cleanups-for-v5.19
X-PR-Tracked-Commit-Id: b3f9916d81e8ffb21cbe7abccf63f86a5a1d598a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ec6574a3c0a22c130c08e8c36c825cb87d68f8e
Message-Id: <165429870500.22913.3604226113522176181.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 23:25:05 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 12:51:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git kthread-cleanups-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ec6574a3c0a22c130c08e8c36c825cb87d68f8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
