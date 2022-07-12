Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1482572032
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiGLQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGLQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:02:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B16C6364
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB81B819ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F327C385A2;
        Tue, 12 Jul 2022 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657641737;
        bh=QtU3FGnjdAW2K33sbhjmclVF+56NM4AMTXmCBTeRLEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N+EzdGDP/cgfUh0zG8BjK6qeQnbLEHSCL6V46GIBbrP/7SAlMW6JhRizmEwnircvy
         qxCcvPkYS3i9lruD2W9HJLcav7+lU99fZuFaD5rfEb3zVqb3E27mNUZgWwzGNOuR7m
         DnBaid9tzXAzAg0nXd4hQpY/gwn2aOuhCIcG0mj/Rcs2NgLEH4kMwUQ5zt4S32mgFO
         iNK0/egAK3TURplfHFRSWDlGerp03trmxOIkejwiu7BsFi2Tq8fYUMWcxDKgUJj+Gv
         gTt8BIuaT4s20ku1ebbUkXifVcQEDDShPUqCn0SitXFupLLDlntpfPaTrG83uVtOJH
         1NyOcP8LNQ2ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AE15E45221;
        Tue, 12 Jul 2022 16:02:17 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc7 (late rc6)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyJzO0bwtopJsfkZ6FRjkk9EghPzhBOQ-_9qQAALvOq+A@mail.gmail.com>
References: <CAPM=9tyJzO0bwtopJsfkZ6FRjkk9EghPzhBOQ-_9qQAALvOq+A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyJzO0bwtopJsfkZ6FRjkk9EghPzhBOQ-_9qQAALvOq+A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-12
X-PR-Tracked-Commit-Id: 3590b44b9434af1b9c81c3f40189087ed4fe3635
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29851567d1aa8f0045170545d2e1a5d7a4057667
Message-Id: <165764173749.23543.17016967213251175465.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Jul 2022 16:02:17 +0000
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

The pull request you sent on Tue, 12 Jul 2022 11:32:31 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29851567d1aa8f0045170545d2e1a5d7a4057667

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
