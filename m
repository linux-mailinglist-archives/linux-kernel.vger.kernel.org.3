Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4358AF08
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiHERm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbiHERml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:42:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0F74362
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 893F3B82990
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32F5BC433D7;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721355;
        bh=+m9Yh0jrDA9R0KRd+ROrDYrWz3z07+PUKE+R0D6tY38=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sd+lVa325TCaRwuGkwH8JVjFq/QJVyy2etK9M1yK6e27HrmI6h5AH8gA951k3lAMx
         ejWuGzGkG1tPD8ZBh+ioLOYu3U7q5W83AAkvdZVbuQEJrF5YeAIgbuF0f4ctYQ21y8
         dxqFkt9nOZv8c24ssaTnSviuaQOPByUitSdoXZRv9Vv2VwczZWaBBZ7zYr2omfPOqS
         o4fbHIjXHB0nPuWEVAQ09DvmETrWffvKnPCesiN8Z6IVPYbgkcuCWSEm+prq1FhAaP
         o+yCMvfVJ3xufDDgSWYrDAv5iJvnTztynaPrKbfAyuPzJwqeW5QbOQVWDvcefWcCuH
         4HrXPiI98e8fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D25C43142;
        Fri,  5 Aug 2022 17:42:35 +0000 (UTC)
Subject: Re: [GIT PULL] rtla: Updates for 5.20/6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803104936.7df810fd@gandalf.local.home>
References: <20220803104936.7df810fd@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803104936.7df810fd@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v5.20
X-PR-Tracked-Commit-Id: dd0b15bda48f59eb7dee17fab91eda8389f0e98d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29b1d469f3f6842ee4115f0b21f018fc44176468
Message-Id: <165972135514.14838.995557390764902796.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:35 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 10:49:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29b1d469f3f6842ee4115f0b21f018fc44176468

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
