Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB24C35AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiBXTTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiBXTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:18:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49AB2D60;
        Thu, 24 Feb 2022 11:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5B3DB82811;
        Thu, 24 Feb 2022 19:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A450C340EF;
        Thu, 24 Feb 2022 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730299;
        bh=rLjAuMorIwNKQVNLUP1CAEZ/ZXBoch9vnNpWrzqm8Io=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NCwHUoV9D+y5N9QSa6wQYL1NkVLZ1f1b0l+4YlLFVl5rP5yJ4zAqpFZKJCUWKi6Jg
         xstPxOcqrJRce5yXyn7WlpAZa51rZfRCAgLg0yDANRm/+rJxTFadF1naC1zCCXBjaH
         1n4nX50j1/PqCBEVO3wZxGvo4Vt/+7sd/tDTOVaRFAznkQs42trCsz1wW5VaD7FSoJ
         xSC1gDKl54E1kzijeleF7nLGdTf/ZI3ybMQPSPCAtAZO95uliHz7Oj4caj8OYaLWwc
         OJyYJ7UWIqgKkOq9PHM2AGLtcq5OTIMwXT5G8Dp5lXmSnjDAhD07rV5iYhKebpITsj
         GSpQbDLhLOWCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5337FEAC081;
        Thu, 24 Feb 2022 19:18:19 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.17 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQHW1UOfu5wDOnNHwTK7FF4SyTx1OCBd9o6izB+69H9EQ@mail.gmail.com>
References: <CAHC9VhQHW1UOfu5wDOnNHwTK7FF4SyTx1OCBd9o6izB+69H9EQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQHW1UOfu5wDOnNHwTK7FF4SyTx1OCBd9o6izB+69H9EQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220223
X-PR-Tracked-Commit-Id: ce2fc710c9d2b25afc710f49bb2065b4439a62bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54134be6580364ab98db09eb8070a09bb02e37ae
Message-Id: <164573029933.2860.8304778085304115082.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 19:18:19 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Feb 2022 16:20:33 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220223

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54134be6580364ab98db09eb8070a09bb02e37ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
