Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622E4A871F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbiBCO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiBCO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:57:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE3C061714;
        Thu,  3 Feb 2022 06:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9040561A53;
        Thu,  3 Feb 2022 14:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037F9C340E4;
        Thu,  3 Feb 2022 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900241;
        bh=rZqRbsG2l7ER8PFv8mXrGg1IyiTqFVzh6i0XCds10/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CyeAvlunIjmxlw7af6EGCKOXyafIBzE5ZlthWSpob7BKB1n47luYuI4G/AMgd1Asp
         7GWSq+uKeuzatCBhcqT/WoaiQ69CSkzCCiVEifeYv1sA6J+RMqyo2nAZcSxfj1TMpa
         dcXvIORgX3jtXu0MZs18jjzRuwuFJB8LJmMsA7dfjmGh9voOtIEAYfmIK6j/xf2h2m
         W+sUc7As/pNH/GEgCKXp19ck4tpLg1JKBfNmgelGWIJjYx0ku15ylrVd6WpxzndZpB
         Df1u6B+4cPRPKjfT5BS+gPbqfo+dS8F6f07iqaa7sz0DMJ46i61xtiEW8lC5iEiiyb
         ugiTbhlFKgwSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E83A0E5D08C;
        Thu,  3 Feb 2022 14:57:20 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220203085602.GA5364@alpha.franken.de>
References: <20220203085602.GA5364@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220203085602.GA5364@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_2
X-PR-Tracked-Commit-Id: 2161ba070999a709f975910b6b9ad6b51cd6f120
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d394bb77dd0bd20b125459da25fdac00a853be28
Message-Id: <164390024094.8873.8664251448338199732.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Feb 2022 14:57:20 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Feb 2022 09:56:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d394bb77dd0bd20b125459da25fdac00a853be28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
