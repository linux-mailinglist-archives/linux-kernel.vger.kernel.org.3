Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF35369A9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355490AbiE1BVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355415AbiE1BV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0012AB35
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B566CB82649
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6162BC34114;
        Sat, 28 May 2022 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653700885;
        bh=k4ODIVgoB8kGR/r76nUQk5FXEduAJKYLuB0lHNN46L0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lb/+tWuVcWn8dlM9uokw8VHZC4n+PCfq2KrX7MaN93MjJQyZqqJ/cTysmtLyIAE9l
         XhrcOrfmqFoPceYkwTFSi1uR9MWph/ACDr9er6H8b2RRs6VsR/5dvFOX+dcs/8Y6tg
         2if6kiV8DEeJecWJF1U3nVBdQr5rAfh9rYLtX4u1JRP/pxTMQJPbSjebvxLColBF4B
         5/R3Oj9SlNJ6YoYiB5A7P+SAlGYEw24As/pq2wtfUfs8uLV3LSkmRt1xXnX43yjTcW
         yks596aEYi96QONoev7PPmHbzEfMRxsrWf4+B2f6VLJfZKm31T/H+EiKLjEbJmk8v6
         zdoIpLN4wgA6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 501C8E8DBDA;
        Sat, 28 May 2022 01:21:25 +0000 (UTC)
Subject: Re: [GIT PULL] clang-format for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220527172209.GA15519@kernel.org>
References: <20220527172209.GA15519@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220527172209.GA15519@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.19-rc1
X-PR-Tracked-Commit-Id: 781121a7f6d11d7cae44982f174ea82adeec7db0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9f94826e4bb6402e67f3eb849dee0811f1de6da
Message-Id: <165370088532.10997.2484909680601470351.pr-tracker-bot@kernel.org>
Date:   Sat, 28 May 2022 01:21:25 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Brian Norris <briannorris@chromium.org>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 19:22:24 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9f94826e4bb6402e67f3eb849dee0811f1de6da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
