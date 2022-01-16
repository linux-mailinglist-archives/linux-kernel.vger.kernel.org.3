Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD04D48FB99
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 09:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiAPIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 03:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiAPIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 03:22:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD078C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 00:22:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66597B80CDD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 08:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D20C36AE3;
        Sun, 16 Jan 2022 08:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642321352;
        bh=aYqRu/vNMWG+GcEFz7VaIacocWLpcfBbi17UdjhO85s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qsqe9iTdiQ8InPXT4rYHwF8EWm5GKdB+ijJZJq4udk+xOKHINQz2lNYyrVxoB1Ad5
         eQRPPsdnaAy4w84mnUTDXTjoJOOjaKSeGcoBHPjKbdWEgIT8ikCMHS0HSZtsWFRe+0
         Z/DS7Wm5yy91nBIQj39eF9ioIvox+OZvZ2mEkIPwJHlHEROyZrOIi4Nhi+r2XuVUXn
         eTVEiFpa+R8lsVEuaYGibKbAZ2fa5h8CH/eCYUMdNU7SIfmLXb2my/UxxFqwbGsVGU
         a6cFMxQgLvugywb8S6/pOawCFaNjEaWvbFSKXiVYHHfsvcz23wLjpGlnQuAdTE8cjI
         gZNPg8LPKFCJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13F6EF60798;
        Sun, 16 Jan 2022 08:22:32 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220114122047.061a16e6@gandalf.local.home>
References: <20220114122047.061a16e6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220114122047.061a16e6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17
X-PR-Tracked-Commit-Id: f37c3bbc635994eda203a6da4ba0f9d05165a8d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d66020dcef83314092f2c8c89152a8d122627e2
Message-Id: <164232135207.9530.7670628608067569245.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jan 2022 08:22:32 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 12:20:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d66020dcef83314092f2c8c89152a8d122627e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
