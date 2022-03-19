Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6054DEA66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiCSTaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiCSTaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C819A54E;
        Sat, 19 Mar 2022 12:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6477B80DC3;
        Sat, 19 Mar 2022 19:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35EA5C340EC;
        Sat, 19 Mar 2022 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647718140;
        bh=iyImoKTScHJlBt06lG5E/IjfT5jttlXE1YkmwUr/2ak=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fd6r+soROehQ8MKXpcc38eR2SqZwnANijSDMw+U9+9mdZdZVoXHtRJNIYWMaRHCDe
         K08PlxvGL7hzBmuLxN0MpblP3RWDWjyfPqJvc08zCuTH9+2sdQaIGOfTcm40oLZ0lH
         7YxvTrQFAkRnKUYOKpJPgyRZ20OvLeIQuW4URdok8KKpTdM44mU6kyI6ZKOtzKQT+J
         SpHYsNqmttvtTlgT4inJXgK0IyKksY9lbov38/sdp6dkvc2wbzV5BXN19e4FAzrd19
         bod3ba9N2hr3yGoI35SUG5WUL0GS5mvGFLRehjq5LcpJA7rd943HC8dOzKZJjvxqUC
         YtPsyv13ElHBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21583EAC09C;
        Sat, 19 Mar 2022 19:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.17: 5th batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220319144446.93618-1-acme@kernel.org>
References: <20220319144446.93618-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220319144446.93618-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-03-19
X-PR-Tracked-Commit-Id: 7bd1da15d211d439d96eb7cc8a35ce694b71d120
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97e9c8eb4bb1dc57859acb1338dfddbd967d7484
Message-Id: <164771814012.23927.9326460661515913850.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Mar 2022 19:29:00 +0000
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
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Mar 2022 11:44:46 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-03-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97e9c8eb4bb1dc57859acb1338dfddbd967d7484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
