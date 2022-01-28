Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3C49FFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350569AbiA1RgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:36:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43860 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbiA1Rfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:35:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30F16174A;
        Fri, 28 Jan 2022 17:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F750C340E0;
        Fri, 28 Jan 2022 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391353;
        bh=/Tzn423wGCZKenoTa6p6kiJ0VgXX2np/EV2OSXFEMiQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JdUqmgg9wRsSvQwNILyOnmXAKZtiTusB078OLlxaeVsw4/wp9eYB6oG7TXLiyRApx
         KTL+v3z1yJbN/LQhzgYL4u1AQHQ0DridZyjI8900Swt9NwV/uEQmhh79njZFanPyIW
         hEEovGNlnRat4yhF4p5ggJuKqTG+Psc8t0EwOUcDHas9S/n9fl4d9kepl2PUA9Xcin
         nTT3FKj9t0ZlaWmXPHcz7DC8jnWFM1UctIJLOX253h3fTVQ2VR7Z9VEWZSttzQUbxl
         O0A1AzHLFs28hkGluOTvFOPR0re3/UqDTcYLHl+uVc0akJqUKl3lUUxvO42tGaug5H
         c0C/OOuRSgdxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C0AFF6079F;
        Fri, 28 Jan 2022 17:35:53 +0000 (UTC)
Subject: Re: [GIT PULL] RCU Tasks fix for systems with non-power-of-two numbers
 of CPUs
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1>
References: <20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128143251.GA2398275@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.01.26a
X-PR-Tracked-Commit-Id: da123016ca8cb5697366c0b2dd55059b976e67e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a773abf72eb0cac008743891068ca6edecc44683
Message-Id: <164339135317.16649.17815520284057549170.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:35:53 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, andrii.nakryiko@gmail.com, kafai@fb.com,
        neeraj.iitr10@gmail.com, Mark.Rutland@arm.com, hca@linux.ibm.com,
        kernel-team@fb.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 06:32:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.01.26a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a773abf72eb0cac008743891068ca6edecc44683

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
