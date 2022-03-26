Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26894E8491
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiCZWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiCZWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:40:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C572CC95
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C753B80BA8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 22:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19856C2BBE4;
        Sat, 26 Mar 2022 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648334325;
        bh=xqAGTOngDX62Eg1crtU/N+xtN0AWI+ReR/4Spk74EcU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jMVGyIyJ70oFqwKDqZRCYfgm4Mp6pesbfkJLostS2XwgOsI1ZYPM6YrPn3O6KzB7L
         xWs0E0lUtUkfEWKpjFon1sCJCgJ+rKwC5qGQp+1W4hfXpjaqSZwSDkcqlfQEnrb6vM
         OjOV7taE6TGXPzus3v1NWCkjyNeJaCWmYMPM/4o40wI0blbRSyNA+4SYfJ2VQv52rm
         FXbXFTEfnQzHWPX/XFY5eNJOxzdQ0lpP7rYl5obYhtGJx6CRkhA96p4D2VuZrpuOPi
         wfC/P2C4t1yrVDWwIlRmhcjBcKru4TSf/3PNHJSQzpiiIfQHQnEG3zBKHIo9Ouzkqf
         ilTke6RK3vI8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04CDDE6D44B;
        Sat, 26 Mar 2022 22:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Have trace event string test handle zero length
 strings
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220324190339.399932f7@gandalf.local.home>
References: <20220324190339.399932f7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220324190339.399932f7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18-1
X-PR-Tracked-Commit-Id: eca344a7362e0f34f179298fd8366bcd556eede1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f022814633e1c600507b3a99691b4d624c2813f0
Message-Id: <164833432501.3514.9048847653131163683.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 22:38:45 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 19:03:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f022814633e1c600507b3a99691b4d624c2813f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
