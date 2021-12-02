Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF68466A81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbhLBTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:37:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43134 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbhLBThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:37:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83673627EA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E57EBC53FD0;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473640;
        bh=Je0CkkJ6UI2XgeiQFROlQiru3bxnJZPutYKxSAHgfU0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kfZpKh39taF9KMidyan4Ac6iZd3NKiZ1jSiDhHPk0edaeYiPGYQDOBmKXRHf5qQR9
         rjmGmc+JZRlwfhtpCQR2+ZemQduPQwWrBa7cB3AdZ5w+GoMDiiHTcIwVl+10JK/g2S
         iJhPWREOoBZbPJlF/F8Ir/wV4WOKtMu0B2HHH+Z0GaKu2He2VAJ17fNf+Ij2WSaEQY
         HGND0LtJ9+ojynsbbtX1GNLmJvWXaSNh+i54bsA4ru1yFIiHJVOmpXsmbzkgMxmzo8
         QAxM0VAXAftpQ0hjNEhKfmmnmchTFVJ1tBwJlN0kr30TrC6f7miP627wOkjhOX1dA9
         2e6ZoppltrrLw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CF0C860A88;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211201211218.5f9e8ae8@gandalf.local.home>
References: <20211201211218.5f9e8ae8@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211201211218.5f9e8ae8@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc3
X-PR-Tracked-Commit-Id: 6bbfa44116689469267f1a6e3d233b52114139d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b2c0f24bac75bfdf2de9f4ea0912946ce5bf5c8
Message-Id: <163847364084.31731.1673095413854301390.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Dec 2021 19:34:00 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Jun <chenjun102@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Dec 2021 21:12:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b2c0f24bac75bfdf2de9f4ea0912946ce5bf5c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
