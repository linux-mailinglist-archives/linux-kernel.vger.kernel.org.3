Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109E359B6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiHUXN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiHUXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:13:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C3312A94
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E599B80E6B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E2DCC43140;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661123627;
        bh=lz15HRCbEgWCTS9fEvWGQKWa+1jf1T3f0c7V3yfBPQM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aqGejMExmir84KekyHvD72+WIAUIAoGp+XjFIh3LgIcF/A/5MGDMcKibMb4GLp3AT
         /4QmLCMAG3Wx0iY64OTU1VmYaRgZx2D4k9is2Fm03LeGFeG0WWItsKFqMbA/2/GaRj
         fUahDhbAzi9qhcdW1lI5fIq4RF21J0WjZ1vhaccngqPBI0cgXcP0tQRCl8BKZwaSrp
         JZla0jhCHqN1Cf/jCBRJOY3mf/YSE5YzcQjESw2PTwKIULnHRmvCV8yrfqKhzWEsNB
         Y37CMQb1UAa32YtraDOY6XYlmFK5wDiCJnvg6UW1e6y4+iPyHxNe6nLbJq77RVL/le
         4Ru5MlN3fD0iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B843C43142;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing: Fixes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220821161614.017ddc4f@gandalf.local.home>
References: <20220821161614.017ddc4f@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220821161614.017ddc4f@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc1-2
X-PR-Tracked-Commit-Id: b2380577d4fe1c0ef3fa50417f1e441c016e4cbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fb312d2256da63e6e4c6e92d279a90fe44bcabd
Message-Id: <166112362717.15654.8320969818281648369.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Aug 2022 23:13:47 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Aug 2022 16:16:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fb312d2256da63e6e4c6e92d279a90fe44bcabd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
