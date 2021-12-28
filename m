Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABAA480D87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhL1VgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:36:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36984 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhL1VgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:36:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD2CB81753;
        Tue, 28 Dec 2021 21:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10DA7C36AEC;
        Tue, 28 Dec 2021 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640727363;
        bh=xULGxFfNxwW7rtndEsiZ5J+JMbFvfMhO/5s9xCT6ADs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BGdYMEijN8yxwcip3crFpnTG8FL8as47eKUnOvw/e2IsyMj5v7EqQRc1yIhmp0VXz
         gM4ghc6KJe2LpgQ3MddSRWg1FrJif3ytsj0y/DhuPOhOqJ0tkhlmEKeiKz3Jv8Ja4y
         JnFisw5HQYJ+mnLwYovJuwEmwQYnS433qr4Qz4WY7dAnhUci+au3HWDBIu+kIxOJnh
         3pyGr4tpDTU4silA/FAK+fitkGjKGBMBxu06YudqTHydi2n5fzwVKFiYyp1f6Iojmf
         cWmpRVksXJtcKngbsObsDNpi2FM3l7qwOFPFWagTKtsPek7BrfTuZJIVGcO9UbXFeA
         QxBqYcgn3l06A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3F81C395E7;
        Tue, 28 Dec 2021 21:36:02 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#4)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRrwLKn1mbMPjsaVwye8YVhP2Y6qxTz6pMyQoqcSFfXRg@mail.gmail.com>
References: <CAHC9VhRrwLKn1mbMPjsaVwye8YVhP2Y6qxTz6pMyQoqcSFfXRg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRrwLKn1mbMPjsaVwye8YVhP2Y6qxTz6pMyQoqcSFfXRg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211228
X-PR-Tracked-Commit-Id: 732bc2ff080c447f8524f40c970c481f5da6eed3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7c124bd04631973a3cc0df19ab881b56d8a2d50
Message-Id: <164072736298.12117.7062352280279532420.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Dec 2021 21:36:02 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Dec 2021 16:31:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20211228

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7c124bd04631973a3cc0df19ab881b56d8a2d50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
