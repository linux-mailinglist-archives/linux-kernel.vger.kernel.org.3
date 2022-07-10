Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A356D02E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiGJQq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGJQqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B715140D2;
        Sun, 10 Jul 2022 09:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099AE612FE;
        Sun, 10 Jul 2022 16:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65DE0C341CB;
        Sun, 10 Jul 2022 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657471538;
        bh=nHpjRGWbDTiCJd9Q/y5FYb+xr/bzZ7RpZPOuQGXAq08=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MpIjpmBpiQ6hfI07YcNof9yZhcllm7N7wjuUTetOzdNCqiDT8Bgzmns2mApE091I5
         5j4iDdYzQZLEJ0TzZfJVK6+OZ3NdMT5lce8cDRvbZRtQfGOLB3IUfurYPOwe6RWlV+
         m5U87BZxBtbJMWKB5KrXWxv0TT3ez+RVr7Q1zuHFFTHCh5SE6j2MFciwkgqo9kr8ZB
         bWdGHV3n0JGu5EEq1GWeQxIW7ZQNJ7fxNHYbq4BFhmr5UooYnvRoRoml0unyE3hzf5
         NPsgpeh7nxhCQMf38blKGKqdrbgBUNW8XfsKsbRLUgzePHPKY8rpa2emrsi/lq7nMS
         BKwK95HstFWRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47042E45BDB;
        Sun, 10 Jul 2022 16:45:38 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATwuZpJNN1hwmb==yBXs9msh+Yc7pCVMxujsB1885QakQ@mail.gmail.com>
References: <CAK7LNATwuZpJNN1hwmb==yBXs9msh+Yc7pCVMxujsB1885QakQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATwuZpJNN1hwmb==yBXs9msh+Yc7pCVMxujsB1885QakQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19-3
X-PR-Tracked-Commit-Id: f5a4618587fb5c5eb5fec3dcce165ca8fd7d7f91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fbd36dfae40cc90ba6a4761e0efff62e4d919fe
Message-Id: <165747153828.25707.5034964179370323960.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 16:45:38 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 21:33:42 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fbd36dfae40cc90ba6a4761e0efff62e4d919fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
