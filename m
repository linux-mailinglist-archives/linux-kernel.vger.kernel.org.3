Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C381482CFE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiABW03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiABW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:26:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89034C061761;
        Sun,  2 Jan 2022 14:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A8C4B80E4B;
        Sun,  2 Jan 2022 22:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2653C36AEB;
        Sun,  2 Jan 2022 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641162385;
        bh=Mdda71lerbyvasBeOp77nxd56siF8L1ezGqs9f//dNg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JaKs4l7RpvS83pGtOqfYc13zOSJufWzRwgOW5KsGkabkhaunyYdY7VV5hxCUasDT+
         8FnS1399j/grvgxOF7rzV/DX3xcHzZm7O8BOYyk60YV/CcCPQ6mm+AicYOKIQho7NH
         iwg2Oc4SAkZX0O3Zgz8xAZ6k3RtJPobekuq2kpFSAiLBVsZRKbdSopT+VmvQoBO0xJ
         J8E6b9eC86tnJ9xDo33EKHr4PGliKiJKAiB3to4qmjeE37E/nGndL5vV/dFec8JMZG
         3pVss+RStVN3XhAbkCEgxqiNIieWekHtH1N+enwkssxxEXkBx/Ms430SBc94heTcSt
         WUlHrlf05Cu0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0018C32795;
        Sun,  2 Jan 2022 22:26:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.16: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220102205338.109230-1-acme@kernel.org>
References: <20220102205338.109230-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220102205338.109230-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2022-01-02
X-PR-Tracked-Commit-Id: 64f18d2d043015b3f835ce4c9f3beb97cfd19b6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24a0b2206134e17ec99d212c776f08f75a4bec23
Message-Id: <164116238566.4935.12313134860447722851.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jan 2022 22:26:25 +0000
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
        German Gomez <german.gomez@arm.com>,
        Hewenliang <hewenliang4@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  2 Jan 2022 17:53:38 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2022-01-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24a0b2206134e17ec99d212c776f08f75a4bec23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
