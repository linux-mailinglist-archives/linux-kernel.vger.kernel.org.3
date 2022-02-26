Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC74C5800
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiBZUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiBZUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:31:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182A241B63
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 12:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 768C2CE0B52
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF756C340F1;
        Sat, 26 Feb 2022 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645907429;
        bh=PuckhqLRM95MBkb+ZtvwSdaaOdmgbSzswA6bFXs31uk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j0gG6vTkyYm704PPaH1Svu63rP8oIzywLhTs4BEaMk7g1wCEDAidKpROJYzpYKS1C
         mXtdooZgJv7FRUY7CRmf+qSaM/RGLGJ5eHsuz72SVFjlfPlN/ag5pgcUu8xI+PKYAT
         dEDUnwfwjnVKxaExUHbgAH57GogL9r7KQDlOyQpFBaCana54cCpHs790aXOKgCcngZ
         503x2+6Z9It3lA9z7KginJPLFprx/qAuU8SQ0BlvJrm0hnBp3KLhGpa5sVGvIQN9lZ
         gC+YkhvlB4weDoRe2NbFqIrJvbWDiF9XSZSNfAj9xYun1VgH33K+TaqhCAJnUrvzt3
         LHNTZmPYrGmHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BF51EAC095;
        Sat, 26 Feb 2022 20:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220226095004.298c6092@rorschach.local.home>
References: <20220226095004.298c6092@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220226095004.298c6092@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc4
X-PR-Tracked-Commit-Id: 90f59ee41abf587ad4675a70434136c8707fdf4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2293be58d6a18cab800e25e42081bacb75c05752
Message-Id: <164590742963.22632.1413968103046039962.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Feb 2022 20:30:29 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tom Zanussi <zanussi@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Feb 2022 09:50:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2293be58d6a18cab800e25e42081bacb75c05752

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
