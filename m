Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5352D496AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiAVIGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:06:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55512 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiAVIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:06:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB78EB81FC0;
        Sat, 22 Jan 2022 08:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7213CC004E1;
        Sat, 22 Jan 2022 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642838800;
        bh=Kq91RSlFRlGLUNdLlkTk/r5LqvKgF4HRkpQCrRIDVgE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sqaMLf+lHplSGdnEol464wf6BDqjpQ5pPrA2cleWhT3ASEODXJsLM+rCVdZfyDa8D
         x7eskdU0iNTetD4EXvIDVBx0bKw3FtFEZal6cYG0agtzWgOIUEpB6ysIuNUiBvWM+t
         U3Nn1FLHEHZmToyc69ks8R1gYowouYNG4sGsZi4DSv9n1HHz6vu7uPfUsP63uI55ea
         Iu9v5OAX4VM51iqoLO0Xz/6Ap6mMGO644nDDegrF8nryCmvK3SsjAE7binH3uP1aGY
         Xk1CTZ+N6coRi6kJ7XssborA1QU/bZs65Sz0+l8xBp1hqO94qAOC6soxlmnD/5DcQ2
         hPG0uoX7F5bWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E1F6F60796;
        Sat, 22 Jan 2022 08:06:40 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bl05400b.fsf@meer.lwn.net>
References: <87bl05400b.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bl05400b.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.17-2
X-PR-Tracked-Commit-Id: b0ac702f3329cdc8a06dcaac73183d4b5a2b942d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0854dc81e108c90cccda6d1fc54bc270f16a3cc9
Message-Id: <164283880038.17909.10942191405538846257.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 08:06:40 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 07:49:24 -0700:

> git://git.lwn.net/linux.git tags/docs-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0854dc81e108c90cccda6d1fc54bc270f16a3cc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
