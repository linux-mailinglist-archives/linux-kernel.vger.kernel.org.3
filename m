Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6D47966F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhLQVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:43:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39744 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhLQVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:43:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C04623E9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA51BC36AE9;
        Fri, 17 Dec 2021 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639777402;
        bh=yA1pM0+YLlhaC9npjLocvp0F2eOn29xabtttXz+5HBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ccd6zpvCBGVWhOS7fkTksdve45ycSSYvlHgPb1j6HQOmhAGx1EcQOTfW18A8+xBOw
         SRZUCI/EAZUC9FlvTmZAtm2jxmBJSBmslxFP9XHxbqj7C/dgWMw/S5Lrt8EYCB4kD/
         D050bHZayXX3UCeTDBBocQAI4ZEdVzNot1R5LYu9+z9n4qNILnukuTQ5gJxOK20/bj
         7xIRnMNAtP4R5rGHXvOnTnenwuwrLWi2oF/wH5ddmlBYQYi8BIW6NG27Vht6rTKmhM
         3ArW1F5G3e+DzjFKc5eY/lP8Ix5FtSmUdmtPaHE6XtSZy7/7aqcdpKPYHJw2iRkDDE
         5U8iBCHY+E1kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CE9AF60A39;
        Fri, 17 Dec 2021 21:43:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twMFXcWtEGnpOFx5KCZDcNKoteYXeLurMiwaAX9XqESuQ@mail.gmail.com>
References: <CAPM=9twMFXcWtEGnpOFx5KCZDcNKoteYXeLurMiwaAX9XqESuQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twMFXcWtEGnpOFx5KCZDcNKoteYXeLurMiwaAX9XqESuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-17-1
X-PR-Tracked-Commit-Id: a2fbfd517117157e99160ff1b39b171872dcba07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f549bf33e3824b3f4a719afaf0fd2e01a07acd6
Message-Id: <163977740184.30898.9744934055215550283.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 21:43:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 15:45:54 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f549bf33e3824b3f4a719afaf0fd2e01a07acd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
