Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4558561C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiG2U3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiG2U3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375E6FA36
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD5D61FF2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABDD5C433D6;
        Fri, 29 Jul 2022 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659126588;
        bh=HRGWYs0/HzrW2tsrcPwrr6IHY+Ga7oXs1x94vE6HiTk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nvNN1jk2KEZFuOQlo5AFjgJGOBYK+1ZnGyqtyGtINN64xAhdBK2/HbA25cUFQwqnI
         If1Gnj7dPOvuorHju96cdAoPrOUGLTY0rwZqGTfhaYA+GJSR0QmMzLLY2mxQCQ/gfw
         1l8ZyA62lh1Dt+ff5MarL5QCApNLVQBEEnwj/XJBQU+CTMVo0SPNGdhZR/a23voIaG
         Rsdyrd6SrR9vSDQ84PiaLmWDQLRAukMFhWshm8sipjdu0tP/4fVMO4LW3Jym6dcHzi
         0CoGLLpJTf3wXJH4f2XZuE0fBIVWmweviUUCiGJhrNWOZzLI9Q5um1sTkMUXM/9Scb
         5EjeVVeLIBk5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99838C43140;
        Fri, 29 Jul 2022 20:29:48 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19 final (part 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twcrq24uhTF4yYR2v1tJsK76D_S4=fjE=K4s+78Wds91Q@mail.gmail.com>
References: <CAPM=9twcrq24uhTF4yYR2v1tJsK76D_S4=fjE=K4s+78Wds91Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twcrq24uhTF4yYR2v1tJsK76D_S4=fjE=K4s+78Wds91Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-30
X-PR-Tracked-Commit-Id: ce156c8a1811c96a243590abd0e9b5a3b72c1f3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e65c6a46df94c8d76ea1129eb2d4564670c6f214
Message-Id: <165912658862.29108.5417045063800649349.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 20:29:48 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Jul 2022 06:24:26 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e65c6a46df94c8d76ea1129eb2d4564670c6f214

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
