Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D178D533272
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiEXU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiEXU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7A47ADB;
        Tue, 24 May 2022 13:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A92661736;
        Tue, 24 May 2022 20:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAFCC34117;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653424017;
        bh=UgJwoioBQp+N6UVxgosxyflX/qCHI4Eqdy7VWHm4lgQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q8qedn3Tqo2obhL2kMVbhug0Ei1ZvjUyj/VrvaYBb51OJTfJNxp37qjDpsJV1BAXG
         +ewPTfw2Gm5HO73z0FoKG8SFleUoJXsTiC4jeGXGhXZs7MEpaRmvE7ncfQ77Mjl2KG
         8GmqxLbz6pxjGr6/YCbM056yIoaOFMu+fC+O+wQ1rntJ2uxJaUL+IbPoP744Yl3P4g
         SUDz/8J2C3S5oCF3/FiNHfBLqwwjvLLklluOXKsJWwmm/ss6hcbc8YY0TKkIjm2w6o
         GlBJOxb7qYmZeOI85eaxuWm7Cv4Zb44cnjHIWP4vw+F28i+GNkAqoL5lUGUCzziIZQ
         IuKgQ8BLmORJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53EE0E8DD61;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523161245.2451265-1-mic@digikod.net>
References: <20220523161245.2451265-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523161245.2451265-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.19-rc1
X-PR-Tracked-Commit-Id: 5e469829baa1b1320e843adf3631edef1d6d2cf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb44e4f061e16be65b8a16505e121490c66d30d0
Message-Id: <165342401733.5255.6026414404497432650.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 20:26:57 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 18:12:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb44e4f061e16be65b8a16505e121490c66d30d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
