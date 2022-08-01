Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE38586F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiHAR1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiHAR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F8112605
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974AE60FF1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7115FC43147;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=zAZx4qW0a8qm3nNphOMM+er1rHuf1k7aoVJbABToR/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lh82mG/ajqgCa6U8aK7jzOm02Vhs5nmGdYq8aDe81IU2F8LvOb7zsopEx/FP9j3+C
         jdML5nsw2omeaMw/zRlev9qNFwd+bHuB1L9G8pIjBWK9RXYa/M84WiGD8YC6N6LOgm
         ojRRo3KZmQWs0UPbi66KREKhq1WyT0FiBwqk9EcEYVqCZaHrZ06epEYef66Qjz3R+n
         l/XAx2X8E3I7wXOU0Cg+JBCjCLDkXJJPx9xjU6YMdCUs5BI6bPxRf7rRKMuE4UBIEF
         r4in6BgwmGKf6wLp/qOuccqio5lXjYcGxDjQpXQwz9Ms8izB7eVUnFrIwL5hMlhRS3
         iTS7grrBHlofQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 602BAC43143;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yue9DqpfTtzdkCBr@zn.tnic>
References: <Yue9DqpfTtzdkCBr@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yue9DqpfTtzdkCBr@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.0_rc1
X-PR-Tracked-Commit-Id: a1a5482a2c6e38a3ebed32e571625c56a8cc41a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecf9b7bfea60ca816b2b44716e3f1dde148ea196
Message-Id: <165937482739.24126.4760986851769721346.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 13:46:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecf9b7bfea60ca816b2b44716e3f1dde148ea196

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
