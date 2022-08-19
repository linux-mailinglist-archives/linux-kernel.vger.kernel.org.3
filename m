Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81359A31A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354744AbiHSRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354566AbiHSRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B22ED5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B283617A1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D75E5C433D6;
        Fri, 19 Aug 2022 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660927803;
        bh=cSdsWeqdGn8SEt2YjuZktKCzw5+88mf/N/Xl3/Z0VZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HY4v0g5G8hlRyNS9TuCtCjZTHapTOAvqzHtIhUOz/ZNoj/b41On2tWelEgJZtodqJ
         yl/uc6JDYLmzIT/MyrF8NMjxPAcnj9Glu61hLEonjOM1dVXc2aFnKkTXzUAa3sF8m2
         lgWfztGPZ+rN+Prbo3cGXbjhVACqY3PORmaZFch4bee0rT7l2y9w8nTN1q4CQWztmy
         Pa+AGTwQm3ZV8HaXrruZH6SVM/0KpoQ8OjcKtgB+nt7lHycGmB1iJLoH4i6ZqRhb9D
         GvBBEqwz0HpiHcmF6Iolg1HlWZrJJ1ByCPra2a7BjgLzCc2SbeUXZ4PA4fBz90LI59
         Fv5nhUutsdI4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3BC3C43142;
        Fri, 19 Aug 2022 16:50:03 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
References: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-19
X-PR-Tracked-Commit-Id: b1fb6b87ed55ced458b322ea10cf0d0ab151e01b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adb67b373a68b6ca4ea9225e248d726f0f5f0f8d
Message-Id: <166092780378.6250.14756136209870183584.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 16:50:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 14:05:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adb67b373a68b6ca4ea9225e248d726f0f5f0f8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
