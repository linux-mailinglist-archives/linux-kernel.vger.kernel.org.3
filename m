Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F091547B81
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiFLSkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiFLSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC259967;
        Sun, 12 Jun 2022 11:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050DC6101C;
        Sun, 12 Jun 2022 18:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FAC8C3411D;
        Sun, 12 Jun 2022 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059247;
        bh=2KZn07GBeR+9deDA4wywPy95VracK2cBdvXt2GNbF84=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oi7CNsd6xbUkpMPHok5RJQ6joirKIvak1Klc48D86PPnRrM+xWml/dWbMgMgVVo5i
         6Rd2wIkJHZHGBLl1L0BozBw1YGwa0HeJQUxBGnSGlejQwJdlMYKx5umDz5euV6qfVS
         IPJ6jJSEB7lVKNfjKd9Y46+T7REvfokfGP3LbGIWsmzQDaJXWa9GOD1PjzfqfkWcWZ
         HHdYisK3pvu6lu13R87YEL7S4Erp4L7waYz3B3ulMuDQktjCYCD9/3YV139aYrzfpq
         28MKZBEYFqRhnfGolmCy6iYJD83YJzLXIBn3bHsiPYEe0RRvNevY26KpUeKtPJUvgB
         SbAV6QTphWt+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CCACE737E6;
        Sun, 12 Jun 2022 18:40:47 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASHyyT+tw-G8iNWt0sHmMUKr816sCXKfLpo-_GhVa=9WQ@mail.gmail.com>
References: <CAK7LNASHyyT+tw-G8iNWt0sHmMUKr816sCXKfLpo-_GhVa=9WQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASHyyT+tw-G8iNWt0sHmMUKr816sCXKfLpo-_GhVa=9WQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19
X-PR-Tracked-Commit-Id: 1f7a6cf6b07c74a17343c2559cd5f5018a245961
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3b8e2de19e18e4297c0dd747d56ecdc4ff96928
Message-Id: <165505924731.24195.18010323738696600238.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 18:40:47 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jun 2022 04:39:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3b8e2de19e18e4297c0dd747d56ecdc4ff96928

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
