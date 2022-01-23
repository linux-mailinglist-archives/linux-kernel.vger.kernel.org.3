Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB714972BD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiAWPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:54:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53616 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiAWPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93A360F58
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38B9BC340E5;
        Sun, 23 Jan 2022 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642953259;
        bh=Th+PLbbNy5T4YFh+V4R6iFv998g+5yQmP8ZBiq7owbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CkF2J3CN8xk4OUwz9+oklmU6n6uBUW8mOkrOxUZaGELZS5B2dbr9pq7RgVWsvAYmE
         yGnhzqGfDr4cFFvady3gVDyTPQF/RG/ul3iHScmeFoAqyVaXhFwRvN0OUq9S+XgTmg
         ogU5GhBWDkeLhkU4PDGsPna0WkMCPxvIv5KlyHfVaeD+QqJhqXqY5G5Zfq8wQaZDlG
         w2HacEv8YPUGOG0is3DH/a16b6IyLCxLKkxorgepwMt1P7gElJfCi7xhIgbHJPF3c0
         mxtPHqz2UfRnXTF07rlrAY5wS4lMcmMEWexQmi3NKb9zw0+e/3/8IlZl5dvLq9Aqa6
         753sUkE4ruwzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 262CDF6079D;
        Sun, 23 Jan 2022 15:54:19 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877daqu2bv.fsf@mpe.ellerman.id.au>
References: <877daqu2bv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877daqu2bv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-2
X-PR-Tracked-Commit-Id: aee101d7b95a03078945681dd7f7ea5e4a1e7686
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
Message-Id: <164295325914.31951.8078413507540454113.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 15:54:19 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, daniel@iogearbox.net,
        johan.almbladh@anyfinetworks.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jan 2022 22:19:16 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
