Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC44BD1B9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiBTU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:58:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbiBTU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0FB14088
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3A60B80DDE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C38DC340EC;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645390690;
        bh=fT/TfEqlAJIKJn1eJpmOyvEloimM8n/ZdQXgp7YFQu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OSxmyotdDvp6CnRvMlsBLf2/KShSsO6FgEkj1vDfNEeKBzzvzNdGyeZfF4Ns8RCbA
         t4Ma9gLwE8OONLZArVm2Wat76Id/csa4xOKgmrwt3PAzmsNDalLkkR2e7ZkvPZSnQR
         VUDAdBoNEygo8tDEp1LfF/cUa0AtgGPWWzqyzQ0rFqJN6UkQxX6fUAzKaJuRRjcj4b
         XyiH0UD2Z8CRwb1ZvTCcja5v/KZ0px6POJJX+MK4vtQT6M44uYa7BkAb0RJhUXlkoK
         1b8FBOBY2bGAmyGh325g+H+qYU98yApW4bY2Yauk8dX7wXxV89Ql0BWMLSmvmD6OuB
         YgiKJnCf3qHdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6998EE6D447;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhIyee8tl5YatX36@zn.tnic>
References: <YhIyee8tl5YatX36@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhIyee8tl5YatX36@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc5
X-PR-Tracked-Commit-Id: 44cad52cc14ae10062f142ec16ede489bccf4469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 222177397aabda681ca9a16ab498bba5c597cda0
Message-Id: <164539069042.9723.16685163808665201124.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 20:58:10 +0000
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

The pull request you sent on Sun, 20 Feb 2022 13:22:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/222177397aabda681ca9a16ab498bba5c597cda0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
