Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91748BBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347604AbiALAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbiALANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0001C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A51DCE1BC3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80183C36AF5;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=UdNyE2oT2DygYWLKuSg3bGUTaGHtOFzlmRuhyWRhzCk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MEpuaEPn+TVBL2t0LqT+4YDNh+U0pH63/SauSkF6jIKL2FjP+/BAi9gF1ko4+QRbs
         cUuIlN2FeVbYNqoadFX+es3rgFoLHFrYgLpyn1DO0wdAiF5+aOFmPJY7zIK/F5O20W
         jzGMddujlkua+KCqciPltn3RzGzw5ZkuHmqXOgkQtOrm/z1bluXcpBbSqcyJaTfIsT
         KT2oFC0hPwoWnItJFauOX1caPM/S8cFqRYX3NO7qHumaN6mWYShzcayQWn6ZOuk0RD
         uKWG0YDFiDaL+NlqRsKqymUKMhhGYKNs0lGP9N9pxgrgkfJdIxn3US4IVJOfqsV6sb
         sX/ywRvIBJe5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EFDDF60794;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v5.17, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd1SQcvvuu1UPlEj@zn.tnic>
References: <Yd1SQcvvuu1UPlEj@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd1SQcvvuu1UPlEj@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1-p2
X-PR-Tracked-Commit-Id: b6aa86cff44cf099299d3a5e66348cb709cd7964
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f18e2d877269672597088c308ca75d7d52620028
Message-Id: <164194642645.21161.2596173523095367858.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 10:47:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f18e2d877269672597088c308ca75d7d52620028

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
