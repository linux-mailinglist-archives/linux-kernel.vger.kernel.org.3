Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101414E841D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiCZUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiCZUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227851FA63;
        Sat, 26 Mar 2022 13:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB7660BB8;
        Sat, 26 Mar 2022 20:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B285C340E8;
        Sat, 26 Mar 2022 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325878;
        bh=P46zrdFOnYJmWss0fBs7IgoY4Q1ajrPAtv8iqg4nQYU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dcgzzwA5vTRLFHWJcS6xmxeclY1oZvG2DY1OIJZBJxJlc4pgzNZ7M66exFUQyyu3F
         gNeLs5rE3YIMN3jlw3otxwXWkjELhWp3f+da4UeT5tru+c+27i9Z5iUNmeNzO9udmt
         Ayr7lVsMWYc3vLUGyonEcZk/XqpsdikPoEIOdd4LlFHtSG0a8G5ZTiQuMpcyyD5LSB
         SJL4S39bWGAp1wxO6hg32O4kEzBk0OvRq5WbT5yNKVNtZNw/CkXmfq7aFY0Iyo47En
         niFQhAXY8kpHW0G/f0o2ZIiF3WEo3O4E/Q/cIE3m1BcWwcCn/+yDtu375I1zC8gZB3
         2mUsVmwBsi2uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09822E6D402;
        Sat, 26 Mar 2022 20:17:58 +0000 (UTC)
Subject: Re: [GIT PULL] array-bounds updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203251511.4F76EAB@keescook>
References: <202203251511.4F76EAB@keescook>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203251511.4F76EAB@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/array-bounds-v5.18-rc1
X-PR-Tracked-Commit-Id: 00a4f836eb369723b148e3f250c850a028778832
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b06a17583f6f810f620f95382b171cc5ce9848ee
Message-Id: <164832587803.7233.10809777112389024414.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:17:58 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 15:29:01 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/array-bounds-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b06a17583f6f810f620f95382b171cc5ce9848ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
