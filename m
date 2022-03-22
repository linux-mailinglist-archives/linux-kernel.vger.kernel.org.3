Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0994E49A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiCVX26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiCVX2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEA532EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4289F6124D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B36FC340EC;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647991646;
        bh=5pIl5/CGoVojnbn6cmAl5SrptRGxnIBKR91Knc6qBj4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zwp9hnthcCRVGeXjKy1R6L0GGObG7Mi+8I87P2TRLJLFxAhnT+zPmH4c+3poOK8Px
         Wz2utQQLgYPMW2Ep7uw/rGvVybxWCU8BtDUseIpO8WnJf4yATV6ZUW8MOpFXRnQV7A
         EhuCLlcZGRu/GlmrJYlSfqimKAFhRE8JzEuj2zvCKI801Q1UmQpZz6UBIEWA+EO2Fa
         yzNwcdnnLY5lbwLXM0pWLpxxl4mswDzvEMi+W0fcyZ5YR/mJo5hhmqYvLBz14ueo8S
         jQ2ajZwbISs5pX0Vu518cdTP1AoUqpwnt4IlyEZ/dwjaGspfyGgNv3SW7X+5mDExuA
         V0OrIDN6hwD2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 887C9E6D406;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhZUezhnamHAl0H@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhZUezhnamHAl0H@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-21
X-PR-Tracked-Commit-Id: 3387ce4d8a5f2956fab827edf499fe6780e83faa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab31c7fd2d37bc3580d9d712d5f2dfb69901fca9
Message-Id: <164799164655.11565.11880378456471959606.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 23:27:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:54:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab31c7fd2d37bc3580d9d712d5f2dfb69901fca9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
