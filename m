Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B4648A1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbiAJV1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiAJV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:27:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4229C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8464E61458
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2A41C36AE3;
        Mon, 10 Jan 2022 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641850045;
        bh=JE1D1dlWD6FDb23YJQsIfmsM/LiPExdkyQmVv41sp14=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZluWQ4Myp50nljxjcDbwRgCqKJuJY82cZuIqzWor/VH0cX4MVTT6Z0wgSt4nZ4gay
         A1UrH3C7r0k2oMzck+6dyJIH9wLy4vEu2Oblk8SOf6AgrZaHhWzuxfYN8fl9Nm+QoU
         BNazarDcIVt6uTNT7iwi+4JclddazJ9FDgZHEZLsmjHmKsOJgmF4fpPYCJiNyQRG4f
         peAla5q5IOmBJVYyl92gtZECzhrAaiLPQbcnK90OFyJUniCLgGPh7UdIAwOKmCYEH/
         XDFXjcZY4oGLTjNncKDhyw9xtizxPbvscbF0soMod1VM9M2jI8BGUGE3WQnAiUKzFO
         rwsar7e2QbNXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2525F6078D;
        Mon, 10 Jan 2022 21:27:25 +0000 (UTC)
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07
X-PR-Tracked-Commit-Id: cb6846fbb83b574c85c2a80211b402a6347b60b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d0749b4f83bf4768ceae45ee6a79e6e7eddfc2a
Message-Id: <164185004585.26853.17363523617586167724.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 21:27:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 16:12:06 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-01-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d0749b4f83bf4768ceae45ee6a79e6e7eddfc2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
