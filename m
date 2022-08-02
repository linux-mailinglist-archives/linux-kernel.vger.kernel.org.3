Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494A15881EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiHBSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiHBSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7D47B82;
        Tue,  2 Aug 2022 11:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C68612E9;
        Tue,  2 Aug 2022 18:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22A71C433D6;
        Tue,  2 Aug 2022 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659465253;
        bh=zp0/7Icm5Wluua9It+oBcjKfZco3F9WX5ula52UQX0I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+/+Fokwnw6wDk2ndub9gMJ9EnvPofv6B0lSER8HYSAk/jmVbu4ACR7b/+9sliMjW
         JycnRxgKtEb/CvWNI9j9d4pfZREFGZtmPyZCsCZqR7dSS0p3n3C0Xm8fgDVtvsCu4j
         v/9jrdc32aLkVAB/bKYag8/aUZwajVQQKMCxB4i9Yq5GhWKT9zO7DVH0n8L/lC7/rY
         26CFDlxudmaYARt35s95pc6vUUptkJSEunvjwK75fmVK08juWMTpESY9LtcvWYXp9w
         RPRg2XZ8k0Q8d/Dx+pa7GGm97Vued5595j2egRBBnmwFdrqVNpLvtx0PprZMxApRvg
         bnL/z1SNYHGbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 118B0C43140;
        Tue,  2 Aug 2022 18:34:13 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220729162050.2866901-1-thierry.reding@gmail.com>
References: <20220729162050.2866901-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220729162050.2866901-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.20-rc1
X-PR-Tracked-Commit-Id: 8933d30c5f468d6cc1e4bf9bb535149da35f202e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 530c28df03e701618949bedf445b1c3c90854ea9
Message-Id: <165946525306.2519.17327601212010392743.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:34:13 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 18:20:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/530c28df03e701618949bedf445b1c3c90854ea9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
