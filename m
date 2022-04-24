Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C550D518
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiDXUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiDXUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:38:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8B1156E25
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 13:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DC54B80E46
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED178C385A7;
        Sun, 24 Apr 2022 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650832542;
        bh=dZL4vIZx0i68BlLa+J5wDtERExSIimlSjsBGMJsvBPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B0bcQC6KgXdgqnAaYaEpaP7QX8ye6VKxGc0T7Kr4isHol1cqsZtGYsAvwsSHThE4+
         an/vNLTGTh1H9AqPBFZM5EGZskwm9sxgk96M4dEyHghGnvubVe07YJC3R9tf245vSR
         XOaARTYM7SR+N0ijBJz6tg9AXl9sKkxrKg+TyrcunUiVjD8L0JA/wWWxYUK9glkxJF
         jF6NE1lJL7zVGvqqL8kkoW7e2MyjVhDlaylRne2NOxq+A2WsWx1Qq6Mi4l3X7H6o+U
         IlMMq1nMTAKXhlO9WNExrJ3cINvPKJ+lzyhhjGJgzPeWNsvDJtg4FBuO1ZYPBRYCuD
         bFHPQdEgrmsIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0EE8E8DBD4;
        Sun, 24 Apr 2022 20:35:41 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmUekOVjdFIi3FBw@zn.tnic>
References: <YmUekOVjdFIi3FBw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmUekOVjdFIi3FBw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.18_rc4
X-PR-Tracked-Commit-Id: 40f5aa4c5eaebfeaca4566217cb9c468e28ed682
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42740a2ff5d3f2cc0c73876dfb37ed0b88d926fd
Message-Id: <165083254184.24781.1369039833894375553.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Apr 2022 20:35:41 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Apr 2022 11:55:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.18_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42740a2ff5d3f2cc0c73876dfb37ed0b88d926fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
