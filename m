Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6A572A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiGLX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGLX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E53C74BE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B7A617AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F9BEC3411C;
        Tue, 12 Jul 2022 23:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657670158;
        bh=3hJ8/C85jgbVxR+f5lw/ZOaerum8unCV/7pu+PwD4Rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n3AH7DjS2QVkFD4aJZ9Z7A2eQ634Y9MUg+am8iXnkFbmk9Q8bujLKTBL1E0zg5Axn
         ADOCJkF/0z3nEU9o3J01rUsZs/mW9XFhaPNFUKeQjTR29cADHvs2Q53u892WVj2MH4
         yumBsFMaB1F6btAzgridjwPIZAZhXWJkuS1kvRK5VYB2emruGWheach++Brv4Pj3zP
         CUywWzbRvXUaqWq5nsaB7FVeDf7ec3/aACBfmUMj4m7D35G3q2gSAk/+ESLT/dvcRQ
         sAreW3QafTmTzZyt78sc9vW+6hsmlqtqKl0P6WlWCNVlbAL5JAWEDDqr5sShC4wxIg
         pQpQA5hBAOPxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B1F9E45224;
        Tue, 12 Jul 2022 23:55:58 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes and minor cleanups for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220712190947.055042b4@gandalf.local.home>
References: <20220712190947.055042b4@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220712190947.055042b4@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.19-rc5
X-PR-Tracked-Commit-Id: 1e1fb420fe68d9d938db360fec700dfd230cc22a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b047602d579b4fb028128a525f056bbdc890e7f0
Message-Id: <165767015849.4125.13689875996362786698.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Jul 2022 23:55:58 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Li kunyu <kunyu@nfschina.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        sunliming <sunliming@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Jul 2022 19:09:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b047602d579b4fb028128a525f056bbdc890e7f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
