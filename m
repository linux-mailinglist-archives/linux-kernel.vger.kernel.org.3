Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43A6532132
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiEXCwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiEXCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A6125C4A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3B261275
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37F89C341CC;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360676;
        bh=jkIL7oaznWi0/bCIxNbmnIDyADq2FAJP02LG65c1KOc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G7wBADiUVgs/Qw/EUDy9pGhpxbE8jUs4UKfaNAbDAIUNeqKyuIUVm6w7u+akD4i+l
         Lz6f5IMHAiyP7ALYQryQwXfI7HeWYXjQWRQs5+C6UUS5WUgVlR5l2Yvp/Y6DjsCO3v
         hUIWDOQwMrjtwsqEUAr7QZUSeNY4xzxPThSRDdRhsmAkOP51uJzcjkfNjqFafbHifk
         7seVJhcIN2AnuLJrPMp1qkR5nVQczDwLz6myIuNFBRdvk7V+280cUSfmuSV8tJFOwj
         9cPNmxO1li4gemElj2HmQwkklMeizp/dJpXT12DbIB+UUesxB9QZgXgJp89zCu3FU6
         2tmYVUYE6XZkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26A93F03947;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YovYi8NM7s7xRvpy@zn.tnic>
References: <YovYi8NM7s7xRvpy@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YovYi8NM7s7xRvpy@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.19_rc1
X-PR-Tracked-Commit-Id: 327c348988c6f0bacd7abd29c151f37bdf1e2a02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1abcb10d6edf5c4c53d29e9ab5488c7734183828
Message-Id: <165336067615.14181.13954221619680659140.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:16 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 20:55:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1abcb10d6edf5c4c53d29e9ab5488c7734183828

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
