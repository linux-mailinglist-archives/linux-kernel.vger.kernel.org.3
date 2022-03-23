Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8824E591C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiCWT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344208AbiCWT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2E4E392
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D2961526
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA947C340F2;
        Wed, 23 Mar 2022 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648063561;
        bh=pQPjC4xqiCWZuBSSDC1LxjdCsWrfzYH7q0EH5wIvmH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P+5bV4Kb0T5aMeKym5Ve51HByGAhSeXbq2s3UjfrfVsY7ByMTfbVkAteDvYknXc2M
         KD2MRiePdCy5D7NZh4dr2yDuvnshRgg6qKAbdHri/TeB44ZGl9LX3PuXU/+EIlvQsa
         OHHrhT4Rw88RksjGGJEmd5zXI4FVrJCVVb3UPWiQuBx5BXkqk8YjJa7UtOIJ1vtQmf
         GD4fYSYmq5UzuZTsEKv3m2Y1u3KsdovJ1QYyLFtkPhBkE2o5LR214gzBJFtlR7oGO8
         OU/hpeDQYl+tYy4hyJUXlsaAgpF23lfrivsTnZ05D9DKS38eSAlCJJCNtqXTChJE7r
         7m70wut38hgWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 980D0E6D402;
        Wed, 23 Mar 2022 19:26:01 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjiLijmVZGox94IH@alley>
References: <YjiLijmVZGox94IH@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjiLijmVZGox94IH@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.18
X-PR-Tracked-Commit-Id: 5eb17c1f458c3921cbfdc6544044642f48d09644
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ef4ea3d84ca568dcd57816b9521e82e3bd94f08
Message-Id: <164806356161.7379.11090800418472754975.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:26:01 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 15:28:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ef4ea3d84ca568dcd57816b9521e82e3bd94f08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
