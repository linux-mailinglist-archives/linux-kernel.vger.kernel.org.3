Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BD5641E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiGBRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiGBRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F0E038;
        Sat,  2 Jul 2022 10:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2715560FD7;
        Sat,  2 Jul 2022 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78F19C34114;
        Sat,  2 Jul 2022 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656783525;
        bh=1tvtsH1L8ob1eAsDQjuotliHWHjLqlUvgvWU1V639nw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QRAAeaIX/IBDmMzHacK1v3TOQUcxzi0FOtUIuG2KjDE5FnKT8zx8pFR59VpSFCh3P
         AbrDeBbkMmizBuggfcp4bi+xYvMXKdQ0aZt1KKYvm1pylTlS0V0GA3YuoGASWI1mEk
         c6jxw1vXVtysctuxKg8U/uP8/zZofq5t6j2q4mlhc8MMOZq4zWSQY27iGwiZNLqAaZ
         7gdSurKgY4rdV43W0CKEceQ+Lf/0lUlo8tma3Mq25IzYIcRkRyavJeeg7YFjLnc86R
         eV8vJyajnFqegPqqROBHTozFqhzsbiweixhNweb3nqxnUDq7RHhjZfzUpSIJv7YkIP
         HMnDIz44HiR2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65303E49BBC;
        Sat,  2 Jul 2022 17:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.19: 3rd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220702144149.1415072-1-acme@kernel.org>
References: <20220702144149.1415072-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220702144149.1415072-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-02
X-PR-Tracked-Commit-Id: ff898552fb32d255517fb0676f9fa500664c484d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb7c51268776941b7533374caabcaaed302b91e0
Message-Id: <165678352540.3400.15357472689894905676.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jul 2022 17:38:45 +0000
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
        Ivan Babrou <ivan@cloudflare.com>,
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

The pull request you sent on Sat,  2 Jul 2022 11:41:49 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb7c51268776941b7533374caabcaaed302b91e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
