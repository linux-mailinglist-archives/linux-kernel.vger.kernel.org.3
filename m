Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0388E479DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhLRWRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLRWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:17:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92646C061574;
        Sat, 18 Dec 2021 14:17:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD8860C80;
        Sat, 18 Dec 2021 22:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE9B4C36AE2;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639865841;
        bh=pCtFpvZOLNe7z8uKhOnuEAAyg+3ClrZbHIEkMhFJeKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kJbafwZR+68iUGA+I01obYwx+pMvaLEXZHLfZNY6hix1BVHqY7Bi1PE5BFp0XNr1d
         QLOu+UkgX6yMzFMTL4U+iXNaECFPRiikx1NCCALAo/YQ58hxlZ6dcY7oC1TS7uLtaL
         gx/GRv6OZtgZzgt0zNCgNIe0nLETTwo2NJwIeNLb9SLewJde+QfMOQgkFeOksSqDk0
         wf7R/WyZIboATZnUxn3dz6GSXLbXnSUw0rcvuWTQ3NuNlVj4MBMg53KYOTd7ihFQ4P
         DZuT5ZjG7/6iCGQPH1PHpZYcQAY38hppSr5wcmwUtx8zTHZbMD2/uRVX24vY5j3SkU
         EsrahX0UmUScg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1A1460A25;
        Sat, 18 Dec 2021 22:17:21 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 4th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211218142647.55737-1-acme@kernel.org>
References: <20211218142647.55737-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211218142647.55737-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-18
X-PR-Tracked-Commit-Id: c271a55b0c6029fed0cac909fa57999a11467132
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f03adcca7a14d154ea1b64b7e2a091ee6951289
Message-Id: <163986584159.8711.17666808059942072760.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Dec 2021 22:17:21 +0000
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 11:26:47 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f03adcca7a14d154ea1b64b7e2a091ee6951289

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
