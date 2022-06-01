Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D468453AF22
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiFAVxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiFAVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:53:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D882E18B11;
        Wed,  1 Jun 2022 14:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89E95B81CF0;
        Wed,  1 Jun 2022 21:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31B45C34119;
        Wed,  1 Jun 2022 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654120380;
        bh=zMCuPfsZ3FXBOJ+/RPBXt20WYRcWOUCEsnMPpWGksVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LMJP0qvQJp5FiRCTaOQDEblFfhMhuFUiH4xfkdj+3sEkFLaMyxTCkEVGquAx67vjQ
         MSPaDyiT7Aw9bj4d6Wfe8Dja/9rrVKgbIaqb0j8FyljZ/8ptsbjEgCYHRITCUE5bQ6
         U15bACp0fSpnWq9ZXeH3X+hfheSiUEfg0SpgFy1PWrQVqig/TC2yy6PQDQ6+6GWR9D
         FgB6UhMRBr4g1FcTQDfhyiuHkFc6EAIVHspBe+n/sr2+1ind+LXECFrqWTGClpb2AF
         bcm3UMCYaFjhluf3czKqrgO5v0Ohu+ytgQdmwYiKc0P9DHfkZAALakld+KQKmWxCXl
         +MPdGiSum5bVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20DE9F0394E;
        Wed,  1 Jun 2022 21:53:00 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601201404.nc66eejtt4tuvre6@mercury.elektranox.org>
References: <20220601201404.nc66eejtt4tuvre6@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601201404.nc66eejtt4tuvre6@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19
X-PR-Tracked-Commit-Id: da50aad6d86716aa48a2b8463c85caea77c0355f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7993147519ca970ad4af17e0eac9d683e7721b9
Message-Id: <165412038013.5556.17117490936906222974.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 21:53:00 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 22:14:04 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7993147519ca970ad4af17e0eac9d683e7721b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
