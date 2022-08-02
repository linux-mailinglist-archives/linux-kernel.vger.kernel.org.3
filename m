Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C975883C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiHBVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiHBVs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3526553
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E32FE61568
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46DAEC43140;
        Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476906;
        bh=+20rjysza4bBuq8hBDYM5etkG5Z6GICk9U81djo5/00=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=utkzQtIC93qLMQ/1g14SO0HOL9K7BiZVGpcKsldM4lK/5Cp61iGKws+/swW5nuy0R
         k5966Z5JAYo47Z0VUjQLRtB3ENBoL89bSd5IgRe6QF06NFfz8RqKXKUcyVWNbLkzXH
         tq0769Z42Vc+toGLlEKkxlGLLVUKQ/HJRyVbMyn/+AhQoOpQYQUy2dHkZV1k44lYAO
         /CmJA2JAR4Wlr7LevkUF60NSiSg9IRIACWo+TlvRyljFApn95jhsNJdGnu3unwLG6Q
         VPOabTorWiN491oiEL1YewNK4ETZPskNIlfcB7YZ1zRNBGzdJlb1k8YIrWSjm+toyl
         jDZCRYe7C2fww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34352C43140;
        Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208011044.A374B6CF83@keescook>
References: <202208011044.A374B6CF83@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208011044.A374B6CF83@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.20-rc1
X-PR-Tracked-Commit-Id: 27603a606fda0806d7c08914bc976931aa42020e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6991a564f59742a0926be7421dff370135c44a97
Message-Id: <165947690620.15647.14132522414100411184.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:48:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, GONG Ruiqi <gongruiqi1@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 10:53:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6991a564f59742a0926be7421dff370135c44a97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
