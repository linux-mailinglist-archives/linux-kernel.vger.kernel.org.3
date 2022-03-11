Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49664D57A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbiCKBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbiCKBxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:53:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355A3ADD55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:52:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A1061E6B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35C80C340EB;
        Fri, 11 Mar 2022 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646963562;
        bh=jroTbzrPfufPRZM4qVesqnF1POjOxYCExjUlK9CTJE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RVmOOtqwve6UsLkV4cDOWBm1gqvWrB72vRBlHQgRs8iV9cbo7rUHhB6P/zZz/7edv
         wy9+xK3mAVOHm1CqxcqDfOaTQDUWlAbR6+NhYIVjrRFL/NlILMoYpp0pJdMtjUsUGS
         aOdJnygfEDFwXrBZB5Dxidfz/a3A5icHH3v4GweXvV6Rz3ysqsLEgdnmbGFzbfX8s/
         +17RSUS1uhFrDj1Ho4DqkCc705LpfgkS8nH2LDEmyPcLYUX01tKcbwmTC0KbArNSXv
         0cM98xsR1StbXwM8lDgMJ3vCpr7aRcoy3wM3Hko2WlMQSvouOqB3khFUDo2Eq5X2fu
         gb4XMcb9w+9Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 212E8E8DD5B;
        Fri, 11 Mar 2022 01:52:42 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: minor fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220310174545.68e872fc@gandalf.local.home>
References: <20220310174545.68e872fc@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220310174545.68e872fc@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc6
X-PR-Tracked-Commit-Id: 78cbc6513217b00be6a9904415ef7ff3619eb035
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dda64ead7e82caa47fafe0edc36067ee64df2203
Message-Id: <164696356212.31302.11433543070964760128.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 01:52:42 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 17:45:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dda64ead7e82caa47fafe0edc36067ee64df2203

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
