Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1B4FAC20
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 06:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiDJEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiDJEzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 00:55:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5E60AB0;
        Sat,  9 Apr 2022 21:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F12BB80B86;
        Sun, 10 Apr 2022 04:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24F4BC385A1;
        Sun, 10 Apr 2022 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649566402;
        bh=oHiurI3ol2ZcbmekwOnCRTJw7ozS4F/2v+pJzN+EZ64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GNJMQb+R1SMvzn8sBtImKJNuyQDM4iyOdoUr73R/9M8SK+QiBAHCC9ogztiH7fKDH
         HsW5ygFLNUUYw/8ZOGB1E/A8qX5Fja96bkfsH9YuUPtFiC1dWZEtGeofPPvCLSbb5r
         PVNNwEnX8WvoJce0YhPomZrZrAovSV1caqhySi2ULOffQFJJNwQ9Ioejqt+dfNw/hn
         hiyrH1pthhvWF1+w3aZdhrdxDr3LdrVxxwyYx7zfWSmKJ43ymuwxY+Ya++u+zS/Iyw
         317qkmjAmvKCsE6484VoTkrQ4KXoRtzQ9dxv8o6sF6exLoiUZQW8y+XpxAk4C1CArO
         jj1nST33tG9sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 092A0E8DD63;
        Sun, 10 Apr 2022 04:53:22 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220409224953.169084-1-acme@kernel.org>
References: <20220409224953.169084-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220409224953.169084-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-09
X-PR-Tracked-Commit-Id: 940a445a904088eac715dd985c01847311a42459
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1862a69c917417142190bc18c8ce16680598664b
Message-Id: <164956640203.12943.8580742871257429709.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 04:53:22 +0000
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
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  9 Apr 2022 19:49:53 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1862a69c917417142190bc18c8ce16680598664b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
