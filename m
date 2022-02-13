Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8D4B3CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiBMSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:13:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiBMSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:13:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783F323
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639C960FE8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAF8FC004E1;
        Sun, 13 Feb 2022 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775993;
        bh=07VI2idy/oHrqrvFAgxgyyOzAQRvetUdXQ3zZew+uWs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O1zyGDv4Y3p0daLfjIYnZDEbhcN0NHG609M9OXw8SlmBRsbFNcj4N4E65NkCSjvfC
         iaxCLK9h1Q7Fs6fxu3WUQ0HGIw90cbHQo/vQmjDB4YbFnRcgIK2vWVJUJ6TuZRHZh4
         GMgP/WHhbzQhlpLolKgGVAgNX7Qn+Uh3+ZLxEqcxOQOyZY2afFPbrzqAUKzMKs07AX
         JPGwaOVSlM3gSkzJE6sIbBPtJIOvLjOsAA1mV3tX/hOaO12w6w2p2vqAApS3UPW2aR
         2VxXtZgncNuuvUqLygyBcjec3cPKPzlxVEWiqlt1Rzbsas8AC74kaeB9VYQ4AWa3j5
         i8Hecw0yRpuIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9B56E5D07E;
        Sun, 13 Feb 2022 18:13:13 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164475928137.320063.1917060351912448264.tglx@xen13>
References: <164475928137.320063.1917060351912448264.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164475928137.320063.1917060351912448264.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-02-13
X-PR-Tracked-Commit-Id: 1e34064b60552616b2767d22f2e6f440ced09acb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5d714aa6dce262482992cccc0ab01383294f7ac
Message-Id: <164477599375.21346.15704678827926418505.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 18:13:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Feb 2022 14:35:15 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-02-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5d714aa6dce262482992cccc0ab01383294f7ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
