Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B4655B3B5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiFZTPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiFZTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:15:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C5B7C2;
        Sun, 26 Jun 2022 12:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21F22B80DF9;
        Sun, 26 Jun 2022 19:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D6CC34114;
        Sun, 26 Jun 2022 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656270907;
        bh=43PGScvluWTooU/TYpWh1BYeq7eIjhr2zaDN3uAsJLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JfFBWEs5MAebQDhALvHVnoNL2v8cC/gHfCZE9dxKh1Y6V3zDoIJjguekpvDE/kVJP
         M0K3Ch93DRjbCAOEzKb0UPvV6zQ5z3nbt0SN+J+rF7sSz5FEXOBps9pH/4Gs84TY8i
         FiGu/3m29U0JNsjSeMjXyAhQ4HEh/UntqGhkz+JxmBnYqoa9Kvi/kGabD6hqTaGiF3
         ZtzNCmQcXCGoB6tgO4S22UxGbgIR14o3RZc1yWgqGAv700wNo6GMZtdsyRGeQKl4Kf
         SYqOPNZ5mw5wBC557SRglRsypQaf1r7awJGPLYuue/dg+SPhPRQZEomo2RINvLUFYY
         sZf5mYMuskcZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E002FD99FF;
        Sun, 26 Jun 2022 19:15:07 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.19: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220626175707.1168954-1-acme@kernel.org>
References: <20220626175707.1168954-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220626175707.1168954-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-06-26
X-PR-Tracked-Commit-Id: f8d866194082e703c86751cceb07f6243cde96d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893d1eaa56e8ed8ebf0726556454c9e53c0bf047
Message-Id: <165627090761.30585.13601361175916372679.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 19:15:07 +0000
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
        Ali Saidi <alisaidi@amazon.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Gang Li <ligang.bdlg@bytedance.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Raul Silvera <rsilvera@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 14:57:07 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893d1eaa56e8ed8ebf0726556454c9e53c0bf047

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
