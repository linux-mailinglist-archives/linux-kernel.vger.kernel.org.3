Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84E546C85A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhLGXq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:46:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbhLGXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:46:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43CA1B81EBA;
        Tue,  7 Dec 2021 23:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2670C341C3;
        Tue,  7 Dec 2021 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638920603;
        bh=jjhEBVwQQV2ybLcvCWAXi4KeNjIOKTe6GoKeT8E1OM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JEPoXmuCognfsRyG+He+Kbn+LnQfcaubUdgszSJiaKK57QZThs7nSbJgydPM53Rmy
         wLuvPxwV5pZEDITbQy2mzyPQIYZFmN4tsDzGoLWwwFLAHG863a81qDICtc4+AOTdYZ
         VBa3fpNAmQgF3ezN82RnphoX0uKg2jMsVoHaN4inEq9zlaH3M0BEAIh/bm6/0y3LmI
         PXQ43OhkSqQ6MC7BFLn/7HG9uc3bRc8DhhnURUTHE0/Xk71L5eT0qCWk3JztNX1qTt
         IAL3vpXSn1zDx6vTvL3mQ+Vs3WvEjqGh6mPt5fH6gqHniSQ4sbi+vkjUBOU9gb+GXL
         Xu+x2b7FJF4ug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C20FC60973;
        Tue,  7 Dec 2021 23:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211207134407.297788-1-acme@kernel.org>
References: <20211207134407.297788-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211207134407.297788-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-07
X-PR-Tracked-Commit-Id: 5a897531e00243cebbcc4dbe4ab06cd559ccf53f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
Message-Id: <163892060273.27655.18267755201714519789.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Dec 2021 23:43:22 +0000
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Dec 2021 10:44:07 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a987e65025e2b79c6d453b78cb5985ac6e5eb26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
