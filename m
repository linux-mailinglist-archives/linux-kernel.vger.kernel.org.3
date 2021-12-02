Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8871466A82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376858AbhLBThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:37:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48972 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376796AbhLBThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:37:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CCB8B82488
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D28C8C53FCD;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473640;
        bh=30TV6WFLaZr+QA/9PsPa9BR5JwvtJ8sy3anwDsKA9fw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ipHFkx4/YACCTUKpKUYC/yk/e/MJmkIKDsq6eKjNQ0NTeBtOCWCg0pq06aKACpFJJ
         J/48f/bJLMISuOhPbHcpUf8urMgJu4FXg09kh70Gxn0LN0wY/HOexxi3AKWyFDCaLQ
         7BVSW3e2CVuNP9mCQfHfIY4gEsDfks54DYdGwbWiyQbPMGdWXKKgF3Fd8yqudjhPkp
         Sk3/B9FJQE6qVzHn4hwq0opp9EZOzDWfws+vZWTVHDsDAFUI2BXKzusABFtX7BlfYE
         IWMF9MSrZBCrektmyBwBPmBX2/F4Cdm6vTepY9WTj39rbfCLrDoFSvTCaLEEQ9tZcZ
         Ly2gI0gwoD3/w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BC53B609E7;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211201195720.GJ15676@minyard.net>
References: <20211201195720.GJ15676@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211201195720.GJ15676@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-2
X-PR-Tracked-Commit-Id: c03a487a83fddbca1ef6cb5b97a69cd3e390e233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df365887f83dda9386a02ea1aa48b3b566473c64
Message-Id: <163847364076.31731.6301273735423555760.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Dec 2021 19:34:00 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Dec 2021 13:57:20 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df365887f83dda9386a02ea1aa48b3b566473c64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
