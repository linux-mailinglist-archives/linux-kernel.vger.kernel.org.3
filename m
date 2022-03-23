Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6A4E591B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbiCWT1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbiCWT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:27:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641D4EA0A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38500B82027
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5FD3C340F5;
        Wed, 23 Mar 2022 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648063561;
        bh=Mi1nZdk9YMi+fc5l93jyhtromypy/xnOHHLBmhLkF7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PPyJr4yY1GzRuLfjRwc8WOPUEapkFU36qMnhdiGTP96mJvvzw0iTnWTdBmcedAqYD
         e9uoFWIJ1QKL1aamF6/XB6NZLX3By3EutrxnES3ZC9ZpXVfos2dSlCNM7QQ+G88NCA
         PXJZUFuYpmXMZJ6CnAQUf31X7bpoIu5B2QJx0FTwviUDoGhlA89n20pLPhLO4pVPcH
         vjKJ1DqJiBc9OODN9YQwhVrtM06BdB+5wnDRJBTjct8A7P3LV38uvSxdIMdDTWNN4b
         hRm05id/dF/+zDWJd9QmGZp68DydHK3wORLZ4bi3Oz3SuNuY+GcpfMQafSB54gGyK4
         C/EBuUlRFh+rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4521E7BB0B;
        Wed, 23 Mar 2022 19:26:01 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/rtla: Updates to the RTLA tool
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321103035.564a1df5@gandalf.local.home>
References: <20220321103035.564a1df5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321103035.564a1df5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v5.18
X-PR-Tracked-Commit-Id: 75016ca3acd0de79868ef5b0694195fe05288ade
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20f463fb38686dd3fe7e6903cab56bdbbf756238
Message-Id: <164806356180.7379.17444599197607094264.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:26:01 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:30:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20f463fb38686dd3fe7e6903cab56bdbbf756238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
