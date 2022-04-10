Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390034FAF7D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiDJRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbiDJRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48960D98
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 685C8B80E59
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D315C385AA;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613152;
        bh=87jGOv+KMgkMq83N9CARKzhyubhvcC/dWaqAfSWPos4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bsMrf+IoTZP3uxiZ138SbyhMm88467V1jEyklYLjzDr+rzlwgNgkqsoxWQ+52GTpL
         dApFwPxcd5isd4Nu8J4Utz2Cj4EjagkKGvQtaqJqkiFa7g20d5TZjznU3YtmsvzNUP
         3+k2R5npBkJPomj7IQbT33WYYAx4yZRACfQU6+dQVYG88iJW2/Ecs8EyHiclY3kQcX
         OLzUrZmn9lN7DXeS/W/dqrSpLHWiP7bGRmcUdAnlK/skJppJ6cgFt1/ZRW4I3E0GTc
         e7+7hU1SajpKPnUkHTBJQEKNJ5lw7JD/vQVYnruWiz9zmEKxTG3K4yc/DmdSi+zwxN
         KVzr2+V9juOQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D0DE8DD5E;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlLBiR9CNt5SchiE@zn.tnic>
References: <YlLBiR9CNt5SchiE@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlLBiR9CNt5SchiE@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc2
X-PR-Tracked-Commit-Id: 59b18a1e65b7a2134814106d0860010e10babe18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c6913b7499cca943776cb0b02ea282113625580
Message-Id: <164961315209.10430.584943168334211458.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:32 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 13:37:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c6913b7499cca943776cb0b02ea282113625580

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
