Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C064E8A1D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiC0UzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiC0UzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B0119C3D;
        Sun, 27 Mar 2022 13:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DBB60C7E;
        Sun, 27 Mar 2022 20:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECB4EC340EC;
        Sun, 27 Mar 2022 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648414406;
        bh=87VxAPUC4MEYU50JY20QJEjmRmHn1sfWkM4LnungiO4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kdC8uSLdvd38tZmeFZluZxXrCxcmU+asLsaarQBcqkmNNQ3WbAOf+gyq1IZQHA+b6
         afkPIU3rov+aPRzISlxURgSVsZvKXiu5XnFcHsZ6SVJvngwrt4QKe5eaAIlSseRPFu
         oLBsWdlpF0zz4qAUzSbHi6KPyp0AkqMVXPmUUWsuQp5yffU4AomM9+1751UcuiWTAI
         ykNrn3sD/RBTiZOrQMIW+L7WZVXJd9Cwdvhhs2wx1FKkMwJgP0ruilgsWIlw0Dg25p
         6XjIk3b48Crx0gvnNiESfLq5C+BvrXkNQs+yCOubLYBvZ+GFjFr28COvjhAkC2KacR
         9LVql/nYVVjRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7403E6BBCA;
        Sun, 27 Mar 2022 20:53:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v5.18: 1st batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220326155357.231739-1-acme@kernel.org>
References: <20220326155357.231739-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220326155357.231739-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.18-2022-03-26
X-PR-Tracked-Commit-Id: ab0809af0bee88b689ba289ec8c40aa2be3a17ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b58b82b86c8b65a2b57a4c6cb96a460654f9e09
Message-Id: <164841440587.12998.1081588827837875501.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 20:53:25 +0000
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
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mahmoud Mandour <ma.mandourr@gmail.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        xaizek <xaizek@posteo.net>, Yury Norov <yury.norov@gmail.com>,
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

The pull request you sent on Sat, 26 Mar 2022 12:53:57 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.18-2022-03-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b58b82b86c8b65a2b57a4c6cb96a460654f9e09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
