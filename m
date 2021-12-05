Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522A468C74
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhLERng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:43:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55276 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbhLERnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3673ECE126A;
        Sun,  5 Dec 2021 17:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 651BBC00446;
        Sun,  5 Dec 2021 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638726005;
        bh=jESj7+iFKq2eQ5seT68cGFN+t2ljxE0qvSATBTGsVSo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XKV3VrVAcZrckOvNsgDaGpKhg/V7Tyuk4G20wDBBQEMXh3wao9QqUV7165Fnz44cl
         hqX3nlhcw9Gb/Cy38wmyfQLyskJzow696LfDa2JTdJXEQLm/tBrhXjcAYjgRo2Dm/3
         uzHY60jY1U0wbVwSilYPRKiWRrM75wIpOQw/zCLEXa0IfEnk/rU1HPRT61lwJc/jaM
         u2cEzmHsvmSsKyOG2FVa5Zn47mN3c71TovXWa3ZbQmBhdMGRpU6NO4/ofJYHkLiygQ
         m1CxHZuq+RBmvSNoC9beoPTmPXUrtSm9EKjS8KmO7B+RKgA8QyKDBJ3CIfURPcuBvC
         z2i32Ix9CFvIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3CBE0609B9;
        Sun,  5 Dec 2021 17:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yayq3iB/M3SJjvXK@kroah.com>
References: <Yayq3iB/M3SJjvXK@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yayq3iB/M3SJjvXK@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc4
X-PR-Tracked-Commit-Id: 9cabe26e65a893afd5846908aa393bd283ab6609
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5163953950ab63ce296398b013d9d16bf2b40940
Message-Id: <163872600517.1003.1739339072610695059.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 17:40:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 13:04:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5163953950ab63ce296398b013d9d16bf2b40940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
