Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5B504886
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiDQRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiDQRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9A1A382
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90FFE61245
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 022D4C385A4;
        Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650214742;
        bh=j+SSGbgvvrwYHOYnSFFjAM5yZ+yFMMySVH8YlwCKB4Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rztttRKBrTlafc75pIW4LiKe3J8GH3bST7+ISab5W6sXQJbK3/4VokZ0VyaJA8+Xy
         MIkzkG5G+muYad6GJP3cgi2JN4uKcdRCaKzlL+3QfK1q1b6ydxNFivVyGDKvVxQWZ5
         SVdvo8YK0NXaoZTYIWCkRm16FQsBBbRbjWsAMu+1Xs3mQ1E0CZjU1haazHud+5bnJK
         IZDCnyFkIF4cs9MRxDXemW4f92h67a5T+8n4mrfwZrdHgd89mhQtHp9F40QquP7Uw/
         zArU3y2MCL+6iba/YX0hQG6j2tdnhXvzv7LKAQMZ66pkUR8B13dOUwk/V0hiRqHkG+
         3ksAr1auUwisg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E13B5E7399D;
        Sun, 17 Apr 2022 16:59:01 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165018953738.44773.8160831624072143061.tglx@xen13>
References: <165018953450.44773.6382828227632028472.tglx@xen13> <165018953738.44773.8160831624072143061.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165018953738.44773.8160831624072143061.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-04-17
X-PR-Tracked-Commit-Id: 9c95bc25ad3b1a2240cd1f896569292a57d3ce85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbb9c58e56f2ee56e77b19fdfac131d57d3341c1
Message-Id: <165021474191.4330.15072042424162595331.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 16:59:01 +0000
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

The pull request you sent on Sun, 17 Apr 2022 11:59:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbb9c58e56f2ee56e77b19fdfac131d57d3341c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
