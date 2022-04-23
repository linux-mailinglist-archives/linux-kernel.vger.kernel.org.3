Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1071250CC88
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiDWROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiDWROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F741AF3E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A4960F14
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 17:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D09DC385A5;
        Sat, 23 Apr 2022 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650733898;
        bh=BEIhSaLoyuMAsQK+4th4GzEl8ioJYx86+V4nH2YKdTE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gK70RYrTOVUkTUqiy3TuqLuj8/xvQNE7xWvyBOqtDMQrqRpCdnHET/D+ZHB7an7kn
         bxeORvLLvSUq5QCYUzmiqsuuxuGBT83LPPGoWBTAs8c9TO0vNc+NLhC0OZEhwTRjwg
         YR4US4rUZVlyANRo/zccl0df1v74+xDVE7nRPUlGapO7ZhhIT4YuU5VdyX2h7ClNuA
         eu5Zv1jPE64aMinYVZ84G3AniKnIqGYlvYiL7irQcNIXJ6VcDQhA5ReaxTKcZSGYve
         EQHn4Lqhk24woQGtylXyM2w7hP/lrkbScz0SChywNqER0/oGFHiVzF0elTtOdKj59N
         5emlfCoEt7DmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39D55E7399D;
        Sat, 23 Apr 2022 17:11:38 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc4 (part 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx4wRuT7J7ZxVeqQNWYdti8=_x3aPURRFPX1qrjWAw09A@mail.gmail.com>
References: <CAPM=9tx4wRuT7J7ZxVeqQNWYdti8=_x3aPURRFPX1qrjWAw09A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx4wRuT7J7ZxVeqQNWYdti8=_x3aPURRFPX1qrjWAw09A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-23
X-PR-Tracked-Commit-Id: c18a2a280c073f70569a91ef0d7434d12e66e200
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
Message-Id: <165073389823.30714.6861894637109276355.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 17:11:38 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 15:18:43 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-04-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13bc32bad7059d6c5671e9d037e6e3ed001cc0f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
