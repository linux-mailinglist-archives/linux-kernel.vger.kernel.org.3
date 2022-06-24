Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D055A155
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiFXSsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFXSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010EB13F73
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9097E620C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D25C34114;
        Fri, 24 Jun 2022 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656096497;
        bh=3J1w5tK6mjwxtr7LiECijv8nqY+fXNQVZHq8x2fidVg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tI5vTNH/NjOSZF9IeJJBWnjxI5HuJW14jbTVbG/fNrPINlkkWaYTMZ2i1AXRU735O
         wRYLVZSYSOt1pZ3tiRhV54/lQfkv4XgKrZ9/eCAwRfCi9vvKILkV1yLQuotJEMGdEh
         udjAcHdPR5qyOcVwTHNcOM56AGogLHl1mkPfYZglf4vIpczZGvsDf9r4JpnzfnXK+i
         X/gMaxXZlFAM+V4pgJM6m+iG+lRjGqzjVOOSJ8CkBw+EJeMbNqxcfjiUmuNZ3GEsqe
         OsVeHTO6l2+7nWordRAPGO0bG0J7SSxYqn3xPOf62X1Y/e7tkUfsS1mUoGuG2KiZQi
         hv4m72zJk8o/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E834BE574DA;
        Fri, 24 Jun 2022 18:48:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyLoZOkc56K2auFtdjhuUxP=Xwj41evB053YZrHyQNSxg@mail.gmail.com>
References: <CAPM=9tyLoZOkc56K2auFtdjhuUxP=Xwj41evB053YZrHyQNSxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyLoZOkc56K2auFtdjhuUxP=Xwj41evB053YZrHyQNSxg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-24
X-PR-Tracked-Commit-Id: 1e9124df8be0a43e4e9a10c5d1140d6ca8e50132
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38bc4ac431684498126f9baa3a530e5a132f0173
Message-Id: <165609649694.29080.3941150132522080119.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 18:48:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 15:55:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38bc4ac431684498126f9baa3a530e5a132f0173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
