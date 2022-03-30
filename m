Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECE24ECBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350020AbiC3SZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350161AbiC3SWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0B43389;
        Wed, 30 Mar 2022 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AFB660F7A;
        Wed, 30 Mar 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D2C0C3410F;
        Wed, 30 Mar 2022 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664415;
        bh=gkRDVE6LkxSPuULuqgJvUbXpedgPjLwSs+GPeyx3h80=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H2+L4wtZYie8ldHiS1gGZeTDITbd0KV1rKI9XjG/YRY4e+egz1cfLTKwVy1iNYKeI
         523WbhliRgYoLKk6kSolDgUIZDfJfNFVZIgxVNLZOD4HgxMZZxdeg2/PFGjit9O7MR
         5ofkIZztkyAAEJYZFf/67U0Djof8NhLz7uW27DLGTN9EQBoKOvO01XYbqvTHo4BcYM
         79/hKnZZzb5madrLBN9NW7tRptA1bfG9ZS3FyXsGKvCEum/XCaKW5w3CmNuh9Y6g27
         t2WvkfhRplJCwAi5brVqTFDARkF7a+MVzh7DkOudRxFVLKoSsC6Mhhmy7HTQPRSBFp
         C6zsBJd/NCa2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08308F03849;
        Wed, 30 Mar 2022 18:20:15 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220330121924.2715661-1-thierry.reding@gmail.com>
References: <20220330121924.2715661-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220330121924.2715661-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.18-rc1
X-PR-Tracked-Commit-Id: ed14d36498c8d15be098df4af9ca324f96e9de74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74164d284b2909de0ba13518cc063e9ea9334749
Message-Id: <164866441502.5472.8717728544583216308.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:15 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Mar 2022 14:19:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74164d284b2909de0ba13518cc063e9ea9334749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
