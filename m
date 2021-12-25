Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C511B47F47A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 22:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhLYVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 16:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhLYVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 16:10:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6EC061401;
        Sat, 25 Dec 2021 13:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E50C60DBF;
        Sat, 25 Dec 2021 21:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE0DEC36AE5;
        Sat, 25 Dec 2021 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640466614;
        bh=IiiZOZG9Mn4K/cTE9tDpvCG4mvjUC55LoXYWgWpjuSk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nqwZ9FB/WXNvP/Je3ZUm4+sgTrfqml8SG/pDeaJtmwh9wfOG5PUZSaFi9Ici5sT2Y
         E6ioG0JmozCZ7vvMRWvvnT9tnyLcyScYd5HEywbLez+RM15gTdDFe5EyN/IGDK9Wfc
         tk81uBzx5PCQMyTdisWrXCyGXWu6wr4C59YUmG/RjA6GJHWblD6+1vZA3UDdCzKBoF
         VbSFkwdzPC6O9I8c6i3kbPChe5nbEa8y0Z1n9m8lbK3H0uW6pIWiB2fuldlvRUGN+5
         OC12fE4k8tbEB8Nnolioo3as4kIQiKPRfzhABYgyhAhaQwKPOvqsGHhqoqNAVKBEiD
         BM5/3kteKeWmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3BC4EAC069;
        Sat, 25 Dec 2021 21:10:14 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yca08RwxZRZcYB2i@google.com>
References: <Yca08RwxZRZcYB2i@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yca08RwxZRZcYB2i@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 4ebfee2bbc1a9c343dd50565ba5ae249fac32267
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b5e3d03470205b98363f50b8d6a7f5f40440458
Message-Id: <164046661461.5738.11394327523557081812.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Dec 2021 21:10:14 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Dec 2021 22:06:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b5e3d03470205b98363f50b8d6a7f5f40440458

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
