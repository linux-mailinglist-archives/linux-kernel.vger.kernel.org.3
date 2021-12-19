Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02F347A213
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhLSUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:34:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44592 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhLSUe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3021860EFC;
        Sun, 19 Dec 2021 20:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98E03C36AE7;
        Sun, 19 Dec 2021 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639946067;
        bh=C+kAmQZcndM0LEx+8+PLRNkETCQS026wqOpxi1A4oGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IRqmf5M2LWz1oGRbwXBEMYdvGTyCxt8ap+GPIrh9SIP0iiRzktcOXaJggkVpiRbgr
         VnM3ah8LUP+Eel9sk6QH/STEeKZXdSNQcflIuieNtF7x6VEEmKVjzbQx6HRKF6pbdI
         mjbjFU86tm6Hxem+jZC4q3DuNAblh3K5rT1Dn7AbM062jS1W20h8KX1/wGudhDa9Ma
         PpOE3H5PyftIzMYdz1OLT9KwePXc1PWlfvYofHs4rAPopCy4iO36N+TPP66Hk6+No8
         rex/PEL6bnT8qY6YCeNx0R5P0dXM1g3FLGUxZlL03wVL0tkRZ3ku+PWnUN0Pq/PBXs
         tp0QPtso/iHLQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7D47060A27;
        Sun, 19 Dec 2021 20:34:27 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtRV8WbGZZcgNRJ4MEnaLWP08JRWJQRftFkkvjieW6Q+A@mail.gmail.com>
References: <CAH2r5mtRV8WbGZZcgNRJ4MEnaLWP08JRWJQRftFkkvjieW6Q+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtRV8WbGZZcgNRJ4MEnaLWP08JRWJQRftFkkvjieW6Q+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc5-smb3-client-fixes
X-PR-Tracked-Commit-Id: a31080899d5fdafcccf7f39dd214a814a2c82626
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9273d6cb9935f536c309186744e5163c9e488a57
Message-Id: <163994606750.11038.1860183149607180877.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Dec 2021 20:34:27 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 19:36:43 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.16-rc5-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9273d6cb9935f536c309186744e5163c9e488a57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
