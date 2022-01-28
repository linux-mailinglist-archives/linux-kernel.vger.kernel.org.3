Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033C649FFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbiA1RgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:36:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34172 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344118AbiA1RgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:36:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0CCBB82697
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BBBC340E7;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391360;
        bh=MpzAkYPWMqMbcKS9Dt6FS9n72VnMrPG6kgNGgMVPZho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OSggc8vfvmntqmWcTbY+F20BXCFXX86tTIr/ys+X0+rJijAZHmozuQML/2OpNqVLF
         Ygd+KDQt1OAWWYSTZBmfDMxAUEbKW60Iwnd9qHcPtchEVm+JOV1gJntKXfUI2wEHpO
         UY/GQhxW8JY+x0xRgP3hZLFD4+VqtIXdKcdAzDAxiD3D79/3bdYxOPiZx22iJpi1Hr
         iN8Aj2p3qOCWANZYFCAAnMP9KHWtPngusujBojZ4LTI0MGPCPLnamzrDqtxKed8E3R
         EcQaZP53R6mt8ihz5CQHvllUUYUzTXmxK59FYEr/NhsNtAMfhbYmCqpOXvqR/CVV4u
         NYYVfU7eIOuWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA42E5D087;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
Subject: Re: [GIT PULL] ucount rlimit fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
References: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17-rc2
X-PR-Tracked-Commit-Id: f9d87929d451d3e649699d0f1d74f71f77ad38f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76fcbc9c7c57a5d44e7ca493d8f2f6eba3964f29
Message-Id: <164339136037.16649.16600309859649262810.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:36:00 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Mathias Krause <minipli@grsecurity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 11:07:45 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76fcbc9c7c57a5d44e7ca493d8f2f6eba3964f29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
