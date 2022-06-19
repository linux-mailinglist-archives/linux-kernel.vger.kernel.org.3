Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B53550B53
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiFSPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiFSPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A93BC36
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EC18CE0DB0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F670C341CD;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=jLbLR9rtK9zmposG1TyYrbZTjhjwq8cD/7tKL2QZvFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JCE+r3RcBAg5Wr6qtbE5v9NcES+J33B5hZyj8OVpbZS9Lr3w23giOxMZnbviRBjdG
         3+sDh+Vv6WqEtWI+5cm61cB/arfQJ6g+lizAvF9/gz5HjT/Y9Lz3Qo3uw6Pdk46ngh
         moPQ7WF5/Kz3Xn8Ul4gHaYATpnp4zoDtMr0V0G6kU2q3boURXe2UB3Kx/Oio8Nr+tX
         X1qOQlypynKcSWwXbq5NKaimLrYRjUITggOiujpCh3dMR6R/FWqmESC46Uk8e5A6Ps
         GWv58VMIwvTIsBFd1un4DBeN3py2SolqO9GjWydh6X18vUbNQFdwg3vLntnShc5UwO
         9Uvlry/98dP8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BEA0E737F0;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165564430323.1413209.8199754494182196241.tglx@xen13>
References: <165564429738.1413209.17302088152547038708.tglx@xen13> <165564430323.1413209.8199754494182196241.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165564430323.1413209.8199754494182196241.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-06-19
X-PR-Tracked-Commit-Id: 1e7769653b06b56b7ea7d56911d2d5b2957750cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c6ca8512f2722f57743d653bb68cf2a273a55a
Message-Id: <165565088730.16911.12865840317049145481.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jun 2022 15:12:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c6ca8512f2722f57743d653bb68cf2a273a55a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
