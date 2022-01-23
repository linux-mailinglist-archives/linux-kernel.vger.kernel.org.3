Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF849705A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 07:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiAWGS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 01:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiAWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 01:18:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE17C061401;
        Sat, 22 Jan 2022 22:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C1916114F;
        Sun, 23 Jan 2022 06:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC3AC340E3;
        Sun, 23 Jan 2022 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642918700;
        bh=SlbFdUUZWg4OkHURvsGEvrBZhKGWE38/GX2JAw316y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QgihRzaANUVQJG8z/qdYQv2OC7vuqrj46lqlZMMKhDrfHRu5YZCwDoNDN3VnNSak7
         36p6SMKpGwZeoFGyrOJLYexw1g/+iUJHnKcPS2sRmdgnXNJkeNzcyIk31pinwp99Vf
         Tv+Y6pqtgU9bY9jc+iMjEuh4ICqmo6jx6mGzB8IS0WGuztm2VuQwzVZeCBfAMyKn9U
         klteSe3Mcctd3M9u9y6WjXz0+PxlvB/i2sdZ/Q4dP+KSnuy8kwQOrTQ2y3OQfjDI80
         CYNA1t7/EgAgMbZivFl2pHFJHxdyS9RXuSREhA+i6a9WCiZyw2qF1a+h1Pr1kdydMw
         TqwzZsil2bueA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BBFF6079A;
        Sun, 23 Jan 2022 06:18:19 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.17: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220123014815.1365290-1-acme@kernel.org>
References: <20220123014815.1365290-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220123014815.1365290-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.17-2022-01-22
X-PR-Tracked-Commit-Id: f0ac5b85810a69104ee6bc939bcbaecfe4db9a3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40c843218f11625722e9a7c3ced81a83b95ecf05
Message-Id: <164291869988.10836.6463548619986304824.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 06:18:19 +0000
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
        CGEL ZTE <cgel.zte@gmail.com>,
        Chase Conklin <chase.conklin@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Wei Li <liwei391@huawei.com>, Yao Jin <jinyao5@huawei.com>,
        Zeal Robot <zealci@zte.com.cn>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jan 2022 22:48:15 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.17-2022-01-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40c843218f11625722e9a7c3ced81a83b95ecf05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
