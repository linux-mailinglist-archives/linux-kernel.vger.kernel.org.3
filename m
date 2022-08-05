Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4058AF07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiHERmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiHERmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894667392D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA2F618C9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53F3BC43470;
        Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721356;
        bh=d3g5RiIj6Q9LGU7sNt8+tr6YonUvw/bPLdNSyC1XB5U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VvVg2o6JmRc/CCnCtsvypALY5MPHy8lLQeP0LHTX+FHXsF9XrS1UNgidekcUBqn55
         743VkGVkhid6RdnAO3cjP1spu9bkUWVCpHJlhRiwwO8BmKVYi1A+N2IQM7RaoQAbWW
         b8XPxr2+R6CtpGIkfF7gw8I42G1TxGBixtu+CHvR+PHg30AIQPq3EZF6g1kEC0c5yv
         HSfd80x7mib4xNym1Og2/cnathAnAKf/1XELqRSuLpGxqaCavvUZJvywdbgkoiGrhr
         M5zLG7MiqeAJq5NX1AgYTQOm9FufEjmLZa9phSn9H2UtVNCz4XDyMLwY4giY88KXt7
         979Bh/jmDIeUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44275C43140;
        Fri,  5 Aug 2022 17:42:36 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing: Updates for 5.20 / 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220805111247.1cc5e985@gandalf.local.home>
References: <20220803112014.7ffed04e@gandalf.local.home> <20220805111247.1cc5e985@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220805111247.1cc5e985@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0
X-PR-Tracked-Commit-Id: f1a15b977ff864513133ecb611eb28603d32c1b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 965a9d75e3d250088a269e0c903e86fe775b48c6
Message-Id: <165972135627.14838.13653905893255248001.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:36 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Li kunyu <kunyu@nfschina.com>, Li zeming <zeming@nfschina.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Slark Xiao <slark_xiao@163.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        sunliming <sunliming@kylinos.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 11:12:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/965a9d75e3d250088a269e0c903e86fe775b48c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
