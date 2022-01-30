Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5208F4A35DC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiA3LJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbiA3LJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:09:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58012C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 03:09:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A8A1B828D8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA6EFC340E4;
        Sun, 30 Jan 2022 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643540991;
        bh=SSp+PnaEEDQopQuLTTnTMUXj9Ht67IYbX6f3EKaSlwE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z/92LPU9+pN+JJF4zahsjXLWSldAJREUWW0CaAlCwG97r5RR1AMT/vOOP0ftubwk7
         xsERqC15471ceiiYdwQUqPNvY3kVk2ONAPGNbplHL+VAhMPodzOCsiXiAY1BzILtXh
         GbSM/GlPKqREiGE9qaPtWD2wVZg52JQitazS57gTUvMGpg1Xz9sqzcIp1b6g1gw6ht
         K0jIVZOfKpCA2yiqCzsX+7nIvrD7LGELaIjKMKHp9ls0FdVEvVUCC/y4jqYC/wBcO0
         IAKdsg0+YVcOwssaELz6v0vBRhsbJGvOdA8/+C1J9z+0gHfh3o/vQyOWOoZmhFw8z/
         wChgPil/kJvGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B908CE5D07D;
        Sun, 30 Jan 2022 11:09:51 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YfZskTVEDx8AAtYh@zn.tnic>
References: <YfZskTVEDx8AAtYh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YfZskTVEDx8AAtYh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc2
X-PR-Tracked-Commit-Id: e464121f2d40eabc7d11823fb26db807ce945df4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a96d3a5b15192f401aa8fa68965ff2a5303367a9
Message-Id: <164354099174.32701.1904571964935811581.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jan 2022 11:09:51 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jan 2022 11:46:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a96d3a5b15192f401aa8fa68965ff2a5303367a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
