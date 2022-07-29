Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789DF585506
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiG2Sfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiG2Sfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EAB5F980;
        Fri, 29 Jul 2022 11:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE80061EE2;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40F5FC43470;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119740;
        bh=lwv+MbYrK6JLE7Y7SWT6cble7Rc7yIdjYWcHDtCV5t0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EEzu43+tirwfHVsMAYkVPy+Se57Ewv0olUnoBxME6SvE0+gIzR0ti9QkZNB+k4YMT
         VWNwkEvde53Z8or7YKctYI319pvQ2D0p/hm/c3IIQ0ojQnwlxOnU3MoM/tiCn7xF8n
         GxV6h3geld2wRS232iL+VbnUBLSkRDP1x21cgVwz4SvviudhgDdDJXOFCazu/iX5EL
         FEFYIoFF87HMUaDOPiLrcGwHOCPokOX9VEwoqZEV25LevfJDCMRCwFVcm37YRaDj2y
         G02IPAjlLM9dm/ocdHJuE1C42gv1604CQndr/WNOF+6lB0yS0+eMutdA1KoJrv9Kk+
         Gr5ndEhs8b/Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C754C43143;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.19: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220729161521.363308-1-acme@kernel.org>
References: <20220729161521.363308-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220729161521.363308-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-29
X-PR-Tracked-Commit-Id: 9a241805673ec0a826b7ddf84b00f4e03adb0a5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb83c99d3d0aa2f51ba0b2abd7115002620118e6
Message-Id: <165911974017.994.12135608885822974957.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:40 +0000
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
        Akemi Yagi <toracat@elrepo.org>,
        Chang Rui <changruinj@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 13:15:21 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb83c99d3d0aa2f51ba0b2abd7115002620118e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
