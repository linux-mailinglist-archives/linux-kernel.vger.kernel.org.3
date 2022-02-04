Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2544AA143
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiBDUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiBDUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70145C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10BF1614DB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73CE9C36AE2;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006879;
        bh=GaSLwahtdKoDtXHOlXEmD10iIBifIuPkqMOLZblWmJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fqf8qpPn+Kriv2NPX6eGPU/gj2Q+jcyCrMPdO8/vHXGr6IFpsFrWEajabyrWLV8gU
         bNMOM1vAHOHCILhf4IJ9fPVkoSGFL1hKYnbSSrbH0kw2xFG4Yq6IgVh3uBKvVqwweG
         zqNWvGWcihmOOl47uegoAfTSDoSx6SwY0prtjXmpx3Kqs51nMInVrPVSGTIjC8jQni
         ic67xvh55mM+ZdPDDXeYaJeRJ6uCuESL2smMv4RE9xRe8HoWWRwURd87PjayeLwG3X
         j4tS+Z4yi1yAG53qXHNOMJuOTmOiifJ7uw2DQUAbOmJ9CI61g6534lKgItM1qN+EV6
         zSCiPsGkO45Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63CBEC6D4EA;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx9Ag9zPenB48F0qCZ1B8gxF0vtRG5-h3We_2QW_z+pxg@mail.gmail.com>
References: <CAPM=9tx9Ag9zPenB48F0qCZ1B8gxF0vtRG5-h3We_2QW_z+pxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx9Ag9zPenB48F0qCZ1B8gxF0vtRG5-h3We_2QW_z+pxg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-04
X-PR-Tracked-Commit-Id: 9ca3d3cd0857523c95ab8cdbb6cfe47b8f90e309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31462d9e47cf6e2cb10a69c833b5e081fff7086d
Message-Id: <164400687940.31755.15517374825699094199.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:39 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 16:09:15 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31462d9e47cf6e2cb10a69c833b5e081fff7086d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
