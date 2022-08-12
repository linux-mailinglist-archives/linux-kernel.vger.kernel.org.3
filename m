Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C4591367
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiHLQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiHLQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B6ADCD9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C8A60918
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6973AC433C1;
        Fri, 12 Aug 2022 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320175;
        bh=c9VEOid5DDE/WL3sElJO8zjpQ5Tmuti7h1tUGtY3StU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FZ5EtTLRvKOiqZ9qVbhKNIt23NFQXLq/R93i83T3bmoP7pmxPhWfrvaESXN2ZNm1R
         lCaDWSiKpBaqtIKsvcvFGW6SwmSVwAhLqHJxXf5UIJbGu/Tr/UZZ/kP2TvPvPwFVBu
         GdEnPbr8QECBNLBt0eZntS6FeXxPSCZn7/DUD/c735mVH3eKaeKWIdiv1GoGsMkwPX
         jvshWnOJHL9utQuMmwdytG1reIK8+eaA5t8H3U8GH4JnwykZZ2htw6eKnQtaoV/njI
         riBJ1pSeeg5CzpkwDoMVgqvCSepRJLmYkKroXeXwzwmDJYUgcqnXXRhX08d71mswsA
         gJ2YWl6pkj6zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55E01C43141;
        Fri, 12 Aug 2022 16:02:55 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twZGrzg6pXcHQkaPfCScrE-DMh5PC1UnRULbtv1eC6vdA@mail.gmail.com>
References: <CAPM=9twZGrzg6pXcHQkaPfCScrE-DMh5PC1UnRULbtv1eC6vdA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twZGrzg6pXcHQkaPfCScrE-DMh5PC1UnRULbtv1eC6vdA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-08-12-1
X-PR-Tracked-Commit-Id: 36fa1cb56ac5189c78dacbbb14d452d0c44b86c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ce2aa6d7fe121e243e1c8a8093911fecdf1c88e
Message-Id: <166032017534.8665.14144126004018597978.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:02:55 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 06:09:44 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-08-12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ce2aa6d7fe121e243e1c8a8093911fecdf1c88e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
