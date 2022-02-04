Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCF4A91ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbiBDBQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:16:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55948 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiBDBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:16:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 550C8B83569;
        Fri,  4 Feb 2022 01:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27835C340EF;
        Fri,  4 Feb 2022 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643937392;
        bh=1XuypAmeblLioyIiAUzheUUKqXHjvQ4MlJ00JIZ2RZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ayOKPLJMHfbtHrK6XFHFhDuYjk6InXupcq2HHfzpKFdhObvc1vRjOFgThJT7WoB7H
         8VLyQR4huuprrPtR7XMc7Sp6PVWH3Y88/Nk+cSah1WANinENZc4OSUGwQNMiYr/c2J
         WSiTMMh22Tqgzxj4B73hRLBbfWstneMNWJIf3Rd2Qiy/m0umxU6eRrvwsRwBRvj+7C
         3O45npCAq29mhHawU4Sxp1/2mNCwSmk0/42sbJ/phJi5NqHVasTwhsrWLaBRSEidB5
         0U/oW1bbMeWwl5nX6FoDLvKuwEsaXS9AE7JxG3WsM79HmcQXuetYC5AKSyFzdK3eL/
         b8wOrCDj5wL3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1338AE6BB30;
        Fri,  4 Feb 2022 01:16:32 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.17 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQcLpAAXgs1oqB2WvturqvkMguYM40d=AK+LDSTnzAARg@mail.gmail.com>
References: <CAHC9VhQcLpAAXgs1oqB2WvturqvkMguYM40d=AK+LDSTnzAARg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQcLpAAXgs1oqB2WvturqvkMguYM40d=AK+LDSTnzAARg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220203
X-PR-Tracked-Commit-Id: 186edf7e368c40d06cf727a1ad14698ea67b74ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 551007a8f10afdc45959ad637d6bee816716769f
Message-Id: <164393739207.12311.8616946332803165738.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 01:16:32 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Feb 2022 17:30:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220203

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/551007a8f10afdc45959ad637d6bee816716769f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
