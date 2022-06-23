Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E655889F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiFWTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiFWTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:23:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EB17A6DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7421AB824E5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23B65C3411B;
        Thu, 23 Jun 2022 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656009009;
        bh=cRy4EA+oEQgoshKLb4Q+LyynOGhVYMWzlU4nMnzPynE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hzSyEZM+n+oLPZM6T6vlKjNjbJ4KjRSglKAJbi/tL766a1ru6eX3ioWQfs+Mp+nEh
         +tcmuHGb6iMq9ko1Wf+mWoORk4QIESSaim5yHDxt0QKTaPTMoYpEBA8oOfqSnyLxeS
         jpdz/x3v3ghbDbinQYYjlcN8s3ssm8IJ8RIZBJNysjuzUqODQNyZYClBF028XKWk6T
         +BM5xIY7wbyyM+GKyCU7ir2JTaeRlFqh7eunGv3OepLoYihr9fLV1RCjnuCRc4Js3g
         64BBH2IEtXAK3E9wyaijg3e6KVWxh8SMaCMukTat4UPZms7iPAy5fAmpOyDRGVXa4V
         7tWULIgpDgIrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09744E737F0;
        Thu, 23 Jun 2022 18:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Minor fixes and clean ups for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220623132340.38f48aae@rorschach.local.home>
References: <20220623132340.38f48aae@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220623132340.38f48aae@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.19-rc1
X-PR-Tracked-Commit-Id: 12c3e0c92fd7cb3d3b698d84fdde7dccb6ba8822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa1796a835fc24eb8fb5d794512ec299dcd9f3fd
Message-Id: <165600900898.26033.6863445122162062736.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 18:30:08 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        sunliming <sunliming@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 13:23:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa1796a835fc24eb8fb5d794512ec299dcd9f3fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
