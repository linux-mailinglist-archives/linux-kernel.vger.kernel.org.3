Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08F546C46
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbiFJS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349985AbiFJS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131772AE4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4AE1621EA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165C1C36AFF;
        Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885571;
        bh=3WsdQ9MZeGRpq7g8IeXKwV4u6dfHtsVvJ+Q5bT4AQtU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QipYXy1U1TpF9veEYhWES1aLME0ADEVux+xeYLKKt4xL1T/F7uqQc/reqqVuKYL9o
         pvITzpV8B8kRQndJ0tNrO4y655doYXCDSnKl3yFYwqj7hjlNy6EBMoEz+OcGfWuJ7X
         4pQbKUGZiq9SQ++MWlV9E0qC9dK/5xs28XjQI1Ypvr+CbqAe6MgQZKNz6PRQzWZnzu
         dBthE7CMDqavO4SvRM06rN1D+5Jfr5yrIaay/+fgSnu8yeVZGPMIhzSes7L1lkZPko
         d4B0g2ImlY+w/ne+lzeEF0uEauO9cyPYQdOWsHwwyXIdJNOpMij33qL20Ff/pLpt8e
         vLlid7MywTybQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 046FEE737EA;
        Fri, 10 Jun 2022 18:26:11 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txaEX1q3FxV3nZQemunXKsbtNhmW9BKGh4UNs3uaCmz_Q@mail.gmail.com>
References: <CAPM=9txaEX1q3FxV3nZQemunXKsbtNhmW9BKGh4UNs3uaCmz_Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txaEX1q3FxV3nZQemunXKsbtNhmW9BKGh4UNs3uaCmz_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-10
X-PR-Tracked-Commit-Id: 1f192b9e8d8a5c619b33a868fb1af063af65ce5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dd77d44795d708f5f4f783b81c5197c5b994d74
Message-Id: <165488557101.32117.7853124034928994612.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:26:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 16:00:24 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-06-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dd77d44795d708f5f4f783b81c5197c5b994d74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
