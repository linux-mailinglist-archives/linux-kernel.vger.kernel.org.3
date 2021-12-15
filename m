Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985FA476168
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbhLOTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:15:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59454 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbhLOTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:15:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3484EB820E7;
        Wed, 15 Dec 2021 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC5C2C36AE2;
        Wed, 15 Dec 2021 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595714;
        bh=TnB5QGesTygDmnU823pUl5hlL7VPzYvpHiA32BRyVy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HsoqROnm3QN7B/GDrshtT1tNbeMj3BGUMjhJmRFTMTGIe0tSmoSWH/rbZ/tzWjftn
         8tsWTN/y4tEeakKU1D6iaPBPG6P36EQaGE4XuNkjbCosYjPxngpVBsD4SjMBcm0Ntw
         HGSvT+LW3Ps2oDlNUetiyOTKALL+AbtHBvOyDYAcsXIxPlQq2Cnh7mR6jtsLJGLZKC
         oLMn80YwtjsAG9BFAs6n6YYe/WAjCwJ3e3FBdG/6QCEq55uKBGkT3F0654Pp0oxwdV
         5yI6aUKPhIhKqJTBQiclasHeUJkOrvrAxr1W1BVCyEvCZqdRIp5tQNJc1NfrlhWX/9
         /xf8p+zIAN8nQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D3E7D60A12;
        Wed, 15 Dec 2021 19:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ybo4kWEmz2yVEhoE@osiris>
References: <Ybo4kWEmz2yVEhoE@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ybo4kWEmz2yVEhoE@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-5
X-PR-Tracked-Commit-Id: 85bf17b28f97ca2749968d8786dc423db320d9c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9c1e6409cf47585a1f9abdd9b37d62ca7910966
Message-Id: <163959571386.3685.5157764727883349464.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Dec 2021 19:15:13 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Dec 2021 19:48:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9c1e6409cf47585a1f9abdd9b37d62ca7910966

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
