Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73B4687CC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379377AbhLDVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 16:54:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37386 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379788AbhLDVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 16:54:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB6060F5D;
        Sat,  4 Dec 2021 21:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96486C341CE;
        Sat,  4 Dec 2021 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638654659;
        bh=UM+IrdNo/wgjsrh8Bk0hVESLB8NeRb/FBHKEfIzEO2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=plWISxMqqhZLFRRhcY/YQE5QutDAlYPygUB86hXeYJSAYy6+zE0uVmoBNZVQfqFoZ
         gu/iN3Jy20mq3Q/HCTd5dvM+Y/ScxHxM6vQaNCBhY2KUTsYHX7iE1NwP73mUgYXxo2
         SOn3BWkdf4ScI2LUR3xT2xEdiFeG76fg1uCq5TYU0cDzWw7AoUlF8KuyHw0CBocodd
         DuWuG6WmHBouUjlNgFDDoov3rgKtLvlymN/T07W3pofoEACPdByj53XKxpt6D+D0ps
         jxMIh/K3hvnYJ25o1k9vvNzashsJmfb2WlAG1pLVU1g59Xqa0BWkMAZnxtWu+1oR4G
         mh7DmSU8h8ftw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 60D556008E;
        Sat,  4 Dec 2021 21:50:59 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt5WfWBs_d+og=eOG08P4z8iQumes05PxEbpi0k4HTNPA@mail.gmail.com>
References: <CAH2r5mt5WfWBs_d+og=eOG08P4z8iQumes05PxEbpi0k4HTNPA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt5WfWBs_d+og=eOG08P4z8iQumes05PxEbpi0k4HTNPA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: bbb9db5e2a7a1ca0926d26a279000384be21b789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23b55d673d7527b093cd97b7c217c82e70cd1af0
Message-Id: <163865465933.20485.8569939900111755390.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Dec 2021 21:50:59 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Dec 2021 14:41:36 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23b55d673d7527b093cd97b7c217c82e70cd1af0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
