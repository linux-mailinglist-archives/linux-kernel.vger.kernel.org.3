Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478156C0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiGHSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiGHSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:35:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD111A384;
        Fri,  8 Jul 2022 11:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C463B8292E;
        Fri,  8 Jul 2022 18:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9E61C341C0;
        Fri,  8 Jul 2022 18:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657305336;
        bh=z+GHsCdf2pwA+gg5fxsvlmPtx5RoBQCMcMAvIXWgz78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uZ9rkgX1lKlqKFYbCn34OMB5qY5T4M95pCX192u2uBaSSC9jzMmQPE+xqorSCwEHG
         q95jP5f6WmsPg63olTm3Cb4lkgYvSm+Ag5XIpMWyd1n2RqfaqzxpOGiCNg8Bz+M5xY
         0zgwbMI0qRazo/RYTscyD5mjgPt5muxk3oTGGXedNZgzjBHv5rEFZK/qwzGKWGygAn
         XNqIItujeL3o83Ga48ogL/4GaSAqSoHxqnYVBrKmY8S0YuOhH4BiwwyhKaT4G7IBMB
         mUCwbgm1SMgVVHnEOYryiARzKpUGkUzR62PXKRqiPemeLA9eKOU/iRT0ODAXU3Zbyn
         OUcESptK+GzPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6966E45BDA;
        Fri,  8 Jul 2022 18:35:36 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ysfe2JUDCg/S1ArT@ls3530>
References: <Ysfe2JUDCg/S1ArT@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ysfe2JUDCg/S1ArT@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.19/fbdev-3
X-PR-Tracked-Commit-Id: 53a6e66b1b4fea4b52f8bc62e5f9530af9061027
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 086ff84617185393a0bbf25830c4f36412a7d3f4
Message-Id: <165730533667.9073.8217130699510457786.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 18:35:36 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Guiling Deng <greens9@163.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jul 2022 09:38:00 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.19/fbdev-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/086ff84617185393a0bbf25830c4f36412a7d3f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
