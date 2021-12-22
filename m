Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7E47D762
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbhLVTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbhLVTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82169C061574;
        Wed, 22 Dec 2021 11:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE9661C5E;
        Wed, 22 Dec 2021 19:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EA55C36AEB;
        Wed, 22 Dec 2021 19:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640199754;
        bh=BtPFtVGo9ada+1siyWtMUY77qVuuUoRAcQS6/sUFrqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bj4/z0M6Zzd+c9XvENPas+oiTlBpV+EODZTKF8wqE3qsD5lLyu5pwTBkp5qVesB5o
         BzccYI5JYznk4rJhIZyN8L7bsquR17znW4IRz5QEIA/ZU7DFjaNQq7bqLNk037nqS3
         I7lrPftEJDNYeCApZNqG2PwiMveGjCQVKQjc9vhsxg3JE3lIXs/U+Rn+iuS8i86gr+
         BlBOQtAjxS3RJTL7KacZnLRUhRTCrgYN6oeF/++licb+R7Urh3WBGb3f867Pm/Vq2W
         16MsAGYue5b04HIv56+Lho1OSBAlXK7bO/ib2czfjPrAb6GffCpgFdvfiGch9DSDcX
         aZ1IM+/OFsG2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A4BB1030719;
        Wed, 22 Dec 2021 19:02:34 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture late bug fixes for kernel v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YcNNLXIZbUl/jvwX@ls3530>
References: <YcNNLXIZbUl/jvwX@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YcNNLXIZbUl/jvwX@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-7
X-PR-Tracked-Commit-Id: aacb2016063dfa6da9378d76734cd9dc1e977619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f066e882bf1373db023ada606e0dca1af375d9b
Message-Id: <164019975403.26306.14632895455405878691.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Dec 2021 19:02:34 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Dec 2021 17:07:09 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f066e882bf1373db023ada606e0dca1af375d9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
