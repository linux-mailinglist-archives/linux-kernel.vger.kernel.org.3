Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543D468C47
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhLERFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:05:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43194 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhLERFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:05:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19ABEB80EC8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 17:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C50EBC00446;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723724;
        bh=k1cwzZqde4yC76hFXfrEr6jUrkJiWcvC91e4NG1vroU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QeSV8PXFGuNPpHDQXMqKqNl7q4bsEJsTtZdJcvl8ORIpP46jSARJwaeW7iC4kPHtK
         s5JTxrTcihl0XL0sCoTzoNomvVcENfO8txiLEF7dhL+WSR0Tz98XHwSPrUzdueMt/x
         DBxPTNaJ5sm1ytCBrbRN/gMoHfUmWrN1SQXu5t/egtbEIP3YUFku7r7bXeLAU57PQi
         RyuuhcvWWIFJR8bSjH5dKiaKKFn5kwbyGA/VCaic3Q6nJ6h8PqaKHZerjXZA3TY96f
         0Wo6vqOPraAVdxBC+hm0zrt1VIYEgdKXCzLXQlFGi0DXMXrkzUzP6P/7gUhseGmMgl
         0OfouwySNJ6hg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B1772604EB;
        Sun,  5 Dec 2021 17:02:04 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yayd6FkzkKcOZKlc@zn.tnic>
References: <Yayd6FkzkKcOZKlc@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yayd6FkzkKcOZKlc@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc4
X-PR-Tracked-Commit-Id: 5c8f6a2e316efebb3ba93d8c1af258155dcf5632
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5d54a42d35cbfcdb00d706ae928548bf690676c
Message-Id: <163872372471.18723.12349517271811354599.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 17:02:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Dec 2021 12:09:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5d54a42d35cbfcdb00d706ae928548bf690676c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
