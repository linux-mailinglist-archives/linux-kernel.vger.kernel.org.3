Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4A488C08
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiAIT0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiAIT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:26:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF6C06173F;
        Sun,  9 Jan 2022 11:25:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF9E2B80E00;
        Sun,  9 Jan 2022 19:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 810ECC36AEF;
        Sun,  9 Jan 2022 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641756357;
        bh=F9yd/aVVTkpn4dmi9+LssN/d4HmEa2NqclhIZVV87Xg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ixvb6sD2ujikNmqRaqsMXVdhYHexJCJSLcuXGCBTT0azyRAA8RDpnk4h/XMAQeZjs
         huhUsVjXD//YKIPcaLMzBKtxM2L9QcU7uu6wKGxdfH3IuW7i50Tcqd20enVhdedppy
         CMBoA5483RVUvbYT4OznWLVdI5VzdN7uc9/e9pfSJJwe73+1MU6DcuO/xeh5x6foI2
         PnN/0X3Hnws+WSwasCc1/Z9ytkcVthWzH8Nir51MjeKGSk2aXJ4YtUBgBqpJW0C/MI
         WTtQUo8iXZY/ZL8MPVbxORgNNo4x5PQ3XwqTJiLtcSWXRG9BPJN1K8Cb6F0aCXQBld
         WLbmT+Rek0BXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D727F7940E;
        Sun,  9 Jan 2022 19:25:57 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 6th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220109153446.160593-1-acme@kernel.org>
References: <20220109153446.160593-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220109153446.160593-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2022-01-09
X-PR-Tracked-Commit-Id: dc9f2dd5de04d2bbcccbabdf5df9715c2ddcf25f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a12a5aa17741fe1d4204dc07abd4d6bd07d9b39
Message-Id: <164175635744.32020.979679807911671253.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jan 2022 19:25:57 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  9 Jan 2022 12:34:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2022-01-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a12a5aa17741fe1d4204dc07abd4d6bd07d9b39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
