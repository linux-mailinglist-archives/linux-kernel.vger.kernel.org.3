Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E147F882
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhLZSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLZSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 13:38:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764EC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 10:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46CB7B80E35
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 18:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B05C36AE8;
        Sun, 26 Dec 2021 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640543893;
        bh=FoNfKkob/LtxDUExReZhp3mV8vArum8IFqN3RNHXYJE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ndU6zFV/mxjzVtsEZNAspog7mPbrHmCz6/la1XHUmmkiH3VNTHBzVaxdXtEuJM3wU
         9EFsAJLNCXOvvhOhm7Zv66fCCBMTqzBR5VGy9B4vwQomcPtzIUtsbLvxidJK2/S84W
         eyiI55CfEsJ6Z0chrc4FfEBO3HCsjIcq1qHyE58Zk232s6lonnp0mx4J02S3KLHt5n
         HBvYwQoFEHNhNeqwvsCPzW7UrqT8pGDmI2Ge6+TmcKPnnPQHJA5/iQzp+WqoAitJhl
         SOZ7qgJydtL8a9qQvuET1/3sn2sljRirmvRyAKNt7BfsHQJfv+zSENidWv7lJmQ8PL
         +8Zj70YIogwuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFB7AEAC06D;
        Sun, 26 Dec 2021 18:38:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YchikpZ6h1ViNUDv@zn.tnic>
References: <YchikpZ6h1ViNUDv@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YchikpZ6h1ViNUDv@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc7
X-PR-Tracked-Commit-Id: 57690554abe135fee81d6ac33cc94d75a7e224bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8ffcd3ab0e5d7332cc75c214fe74e52240b117b
Message-Id: <164054389284.393.2460852268834866577.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Dec 2021 18:38:12 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Dec 2021 13:39:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8ffcd3ab0e5d7332cc75c214fe74e52240b117b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
