Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9964F0601
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiDBUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiDBUCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6578FD17;
        Sat,  2 Apr 2022 13:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F6260DE1;
        Sat,  2 Apr 2022 20:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA483C340F3;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648929657;
        bh=IlLnElKc2ovCT8tJS6J3HGXjz5pEfcMQ1EL4Je21m/I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V/JTMwx/Q2w5//gPCEj0NkEtCyhOKD80IxNy4DNDJJaXwE/C8lWTD5T1srfHLhRWF
         L5FlRDDVxnGDbVsWTVMdt1JxBvT/pFun3vGcgdypnM5Ee5ULZgLHBZnBxohUMmoYPE
         s/r8acc1noWf0NFT0HDpv8BrLZu94z2RNFBxUrob5V41D0NQVceC5qHwrdgHzNi8l0
         RDHXvfeUSOagLYVVmiqAaq6Pl4uPzn4SLuHphaJhZnrTB3BVZxMV7HykhxH8Z64eKQ
         dy1qIqF9LGigKs5HIlBaUyTDyzBZ+hEqE0YV1KZ2GrLuwYz1h634av4aJeKc3h125N
         7Q455iSVkb4VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A56E1F03848;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.18: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220402135441.80062-1-acme@kernel.org>
References: <20220402135441.80062-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220402135441.80062-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.18-2022-04-02
X-PR-Tracked-Commit-Id: 7e2022af7921978ce37bb8fc1a35239b81cbc1af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
Message-Id: <164892965767.29522.12676530124306945630.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 20:00:57 +0000
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
        Haowen Bai <baihaowen@meizu.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Tanu M <tanu235m@gmail.com>,
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

The pull request you sent on Sat,  2 Apr 2022 10:54:41 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.18-2022-04-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
