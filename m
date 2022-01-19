Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B24937AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbiASJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353289AbiASJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFDC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:48:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C48761543
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A42EBC004E1;
        Wed, 19 Jan 2022 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585692;
        bh=pY4KReaEw0u814aGXbae1WyLfrNWtzB5SMb+lpChISM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WaKCI5QsFLbFjpCYXt0KJ3jRvCft2Q6SfOX7HC9+Pa0wF2dfVBp2LWq3HxzBrkoC/
         gHMUZ9izqxfcYF0dohNDVqHef8/oodIANgF9YsIpYAth2W6KaLYgT17Nkg8yKOyTCg
         KxvRo8AiCb0W1d+SxHzfnXmFl67bE4/ad5JvJQAPoTNeXuv6ympj7M8Prnt3dPXved
         BDVyzteONLMqAet7fnqWgUDOedeOpPvUbElTa8nCTmNuMgsyWzjqog8Askh+r72UPr
         aSylVWTyQoG5EkKJow24fexBzl+ClgigiFrG2+uUU3HQ/Hxgs5dVhsEiM3Xu6M+8DM
         syAcbyzvQIYrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93C0EF60795;
        Wed, 19 Jan 2022 09:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220118164906.402468-1-Jason@zx2c4.com>
References: <20220118164906.402468-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220118164906.402468-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-rc1-for-linus
X-PR-Tracked-Commit-Id: a254a0e4093fce8c832414a83940736067eed515
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ed905975612ea67224af26fd6bfbac965b6d029
Message-Id: <164258569260.19279.8339990399698192601.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:48:12 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 17:49:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git random-5.17-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ed905975612ea67224af26fd6bfbac965b6d029

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
