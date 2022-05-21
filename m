Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6652F8D7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354591AbiEUFJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354582AbiEUFJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A5179C27;
        Fri, 20 May 2022 22:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D35B82F37;
        Sat, 21 May 2022 05:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFA5DC385A9;
        Sat, 21 May 2022 05:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653109763;
        bh=2SScdXP8vu/I8x4nA+EC2ihryA5p7GDEZmBGr1vZigI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KxsjUkls3+98H0VdSSrVtKh4rMS2AWxlmL245oh0iZ53Szfs5gKarSxu7NG3cUvDt
         fPMfeAMEIKa4eYJ4ZrQkSTyv3k1M1LFj9RTUbXrDxp1QgX40E6Csrj73u2iXATf5JG
         M3cHN5hG89T2ZYaMlBwcKVMJ0HMC96U5vX1Sm5Fmv/NERmUYptj0yFVPAyQNmBFrQf
         W01vveLVP6H528ukCI86zTM5PEOpwv4i/SfyenTQ31JYtxI/SgQK+S9f9lPeB/S365
         zsFJKRgndsm7wy43uv15nnS2nUa6+uix3LqOhu/cLRphn3UHfEDzB65DDabKfRhQDX
         PknAM5kkB5AQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE17DF0383D;
        Sat, 21 May 2022 05:09:23 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220521050026.2534728-1-sboyd@kernel.org>
References: <20220521050026.2534728-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220521050026.2534728-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: d0031e6fbed955ff8d5f5bbc8fe7382482559cec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3454ce0b2c8a56e760e6baa88ed10278585072b
Message-Id: <165310976384.23518.2815679631591571587.pr-tracker-bot@kernel.org>
Date:   Sat, 21 May 2022 05:09:23 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 22:00:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3454ce0b2c8a56e760e6baa88ed10278585072b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
