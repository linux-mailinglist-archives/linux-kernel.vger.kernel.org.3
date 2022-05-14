Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16152738F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiENTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiENS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 14:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6513CEA;
        Sat, 14 May 2022 11:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F352BB808D0;
        Sat, 14 May 2022 18:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC6CC340EE;
        Sat, 14 May 2022 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652554793;
        bh=rKRzr+2uWHkXVe0sb53iF5w24m7QTUjRgU5PM+5Bf+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qMT/SOn6UlFta0vvId3SY4rp3Mm6Jf4dAAp5blb8OqZHwLJYLwnHz+e51Azd2q+0v
         cCQavG04ulMQ1789kXBqU4BLM8XXDEPAW/Ovf613tPVn1/eO68aTJ79ILB2FuS7e+8
         VIxYgFLUg5h/R2O1PQ2NJUbBIVfqg88rtGQ6Qg5P/l7Wl5tRefiUh1vc2lrdGq9PjS
         mESpPEWUrOyzYhNnrRBqjZxjmsfFz44qdLlxXFWf2ySBAgs815WSie15Q9n5+RIfvg
         Clfeuqxzl6i8ZHN6otjH1dowrI12jDaV6wyHQahVL1ZVI92L6/oMXJB39fPwnzdtr+
         mEebUVT2/B5QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75EBCF0389D;
        Sat, 14 May 2022 18:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.18: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220514182508.843245-1-acme@kernel.org>
References: <20220514182508.843245-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220514182508.843245-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-14
X-PR-Tracked-Commit-Id: c46721e4604f260918e660550a16d1e28637d66c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fe1020d73ca0467b5383b0a3e459a1d29902762
Message-Id: <165255479347.17902.14183337916495308539.pr-tracker-bot@kernel.org>
Date:   Sat, 14 May 2022 18:59:53 +0000
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
        Ian Rogers <irogers@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 May 2022 15:25:08 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.18-2022-05-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fe1020d73ca0467b5383b0a3e459a1d29902762

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
