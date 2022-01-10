Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61C48A0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbiAJUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:22:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33252 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiAJUWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B8CFB817E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDEBEC36AE9;
        Mon, 10 Jan 2022 20:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846158;
        bh=pk3G7Rxlfcaq976ISBJHspmOpsHR5jg1/F0MbVeg8Ds=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bibbpqq0S2ReT/UAMUin0/B5OTA2fC66hFt6jEKwRU0Rb/brVCRXWBAkehMxucrss
         nKH5jHB6zmuz2Dk8x7YP3TFthq4siFKfY+qYAInILQbD7B18IrE7Art4pjJCddwceR
         JqxCGVyPd6wa6HH0MusSqFY8ytyrGVRTcl21x3uaRzm/68Q/2CxREjJE9B0vH6kcSd
         SIRkMdbFTaqSy6ErxIVJPVjQSGiV7uqxpDw0rbPtsUC0Mle9HtK7ck7yHZCcdlmVcg
         gf/dzr81RODbmmQr5CCtooJJMs5dFUGKHW9FqVyYCzJo9iTTaLd9Zsc5aIBmSdGxZ1
         9q6P61KEGxBUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB122F6078F;
        Mon, 10 Jan 2022 20:22:38 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220106235920.995517-1-Jason@zx2c4.com>
References: <20220106235920.995517-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220106235920.995517-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-for-linus
X-PR-Tracked-Commit-Id: 6c8e11e08a5b74bb8a5cdd5cbc1e5143df0fba72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d93aebbd76a07a8101d2f7393dc18be3e235f11b
Message-Id: <164184615882.11936.15408413715785736141.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:38 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Jan 2022 00:59:20 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d93aebbd76a07a8101d2f7393dc18be3e235f11b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
