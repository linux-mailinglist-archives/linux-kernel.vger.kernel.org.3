Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03853AF98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiFAVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiFAVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:53:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E2DF34;
        Wed,  1 Jun 2022 14:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4DD2B81CF2;
        Wed,  1 Jun 2022 21:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B5CCC3411F;
        Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654120384;
        bh=fy2k+9SNmeFa7RMilH9Quvxcu/tBFoqghx87e4ljg5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WYuBsXCQLhN8OfYqrK3LtMdNalrjb8LG/OmmH/DC3fGbMJlaCzv05Fws9rD1JQIJs
         WcwDT7THmhQnFANbMcqjh8NgpNUl9OgOlcaEtKVdDy26uMoVtHT1fgHarr8rmW5PgU
         gXXrE97LSKqdbBLkrxhU16WNUJl0fE8Wt12akYsHHKHtO5VlNUw9nPtWRTWPgk0gGk
         b00sFjwSHQfgcca36kiUik+rKln2bRCRqcEbXwklM4ciIiScxCGr92hxWEa3aeqFx8
         sHxTlbKKFtZfUMYB16VRjuywbthXOYB8jU1gF5hysEb2lnrFghYu9mMm5ebXBrh5cm
         PoAYF065FWx4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13122F0394E;
        Wed,  1 Jun 2022 21:53:04 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypfdmml1GWU+gYzP@mail.local>
References: <Ypfdmml1GWU+gYzP@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypfdmml1GWU+gYzP@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.19
X-PR-Tracked-Commit-Id: f78e3d407a339ffdd2620140300f821ea41118f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54eb8462f21fb170a05ad64620f0d8d0cf2b7fb5
Message-Id: <165412038407.5556.8682390648447535620.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 21:53:04 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 23:43:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54eb8462f21fb170a05ad64620f0d8d0cf2b7fb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
