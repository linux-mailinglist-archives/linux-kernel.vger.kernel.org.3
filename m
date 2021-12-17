Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F547966D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhLQVnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:43:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39662 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhLQVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:43:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF85E623E9;
        Fri, 17 Dec 2021 21:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E1D3C36AE2;
        Fri, 17 Dec 2021 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639777398;
        bh=I/BND2fPxe3b1WESDucx+tHLIhBolRhvSKQcU58rbFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tXWhaTrMDf+85oNeMQRX7wKsGgDPSj9IKLoCRVxKa0UxxGWwII8lZCUw2zfMhYj31
         RjLW0HyqS+sDdR3zGO7Jt1K4vjKMgQujmI/FTSn2y9R1OrDbIj7JEyqJD5WIgxkRNX
         Gre6yTwKYofEG6ke+ZmQ3NQb40Z+2Q67J9Q/aR+5HvMxh6F/LhNV2SaP2R1hgaY8lZ
         VqFfGKee7rSgw7Yn/CchvnmJaF2n23o5tb338lorDtZaj6hyczqQekJrHNRaQlosfc
         1XuXMuzlAodwBM1Fo0koFbxlxbRwvmUqXc+75eOiEOh8Jp31Rl0MYioBqrGjABFaL/
         ZBDCDUp4n6O+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C05360A27;
        Fri, 17 Dec 2021 21:43:18 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211217
X-PR-Tracked-Commit-Id: cc274ae7763d9700a56659f3228641d7069e7a3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f05ef38382021c9279cca8e9589f16fdfd1f40
Message-Id: <163977739830.30898.10474255826465226501.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 21:43:18 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 15:02:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211217

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f05ef38382021c9279cca8e9589f16fdfd1f40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
