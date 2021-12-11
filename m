Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FC470FED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbhLKBmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhLKBmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:42:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28650C061714;
        Fri, 10 Dec 2021 17:38:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67484CE2E92;
        Sat, 11 Dec 2021 01:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E6EC00446;
        Sat, 11 Dec 2021 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639186725;
        bh=BAJWdxif+J7b0VwKKXreQG8+LJz7zQ1NvCiRI13HYKI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WElmSFsaQHQsKk0aU8f2CdKmdCXHIggwWLz5+ca+MUHv3t9cmg3xvFFhggE9Qp41t
         xDV6kxBvQWzR3gteKCF98ECndqcY2Y8bG/lepaALVXqk8VDj+urgD5kcLnDKPqvmHp
         pAYobwWBMMCqqB0fksFgj3r+5zAM2ffIrpowZTkinDDluaSylkW9bT5zdJxSyNlkLu
         NkSHa8qbyOackM8PpfFBFw5J1/VHVXZ5mLofyoPpIDgS4bEnXwbXfxzWUHtC+/Rayj
         2IR8hg++u7vNdJYg1a74i+BeXo/76KFwj5zY2EWNVhgrdk/UqqthLGhf0Rcvtyp/u+
         o0p0CyflTs5LA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7E62C60A36;
        Sat, 11 Dec 2021 01:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms8umkdMfYKr6p7C+_SZBzr54X9xdf-oZh4rxjQKEXccg@mail.gmail.com>
References: <CAH2r5ms8umkdMfYKr6p7C+_SZBzr54X9xdf-oZh4rxjQKEXccg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms8umkdMfYKr6p7C+_SZBzr54X9xdf-oZh4rxjQKEXccg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc4-smb3-fixes
X-PR-Tracked-Commit-Id: 9de0737d5ba0425c3154d5d83da12a8fa8595c0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1b96811e21287be40136292863f6010b8813c9e
Message-Id: <163918672545.12736.17487082340324334449.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Dec 2021 01:38:45 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 14:41:49 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc4-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1b96811e21287be40136292863f6010b8813c9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
