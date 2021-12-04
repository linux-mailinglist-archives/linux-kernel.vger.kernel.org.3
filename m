Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48B46865D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355484AbhLDQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:59:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48144 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbhLDQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:59:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F1BB80D24;
        Sat,  4 Dec 2021 16:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D9EEC341C2;
        Sat,  4 Dec 2021 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638636960;
        bh=0h992gu1aRGBeaPu0MCIoSwLrvfa6xPwGeqeoaMkycQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j6TKuPRf0QMNXPyUiB6673MN46muYdJ9U8HF0X3IPKgZ9h/CycQdqv5pAw7CpXTyE
         0LdaROtfyn4qZudVtou1/Zvl0vVbHcoMMIf5rXsPbrPq0VMMH6qduSyQVGGKFplwrf
         c9jbvs9VH2ibmUKfyTXT2QMW7YR7GPQkZ0SqxXSjie0Fwpozb71pVHn4IMYlVHiUoK
         w+uKmoFcKbMSUavysmxzkBJfGxdc2XoImmMV1ExcvROqoG04aKnklImFKVO/D2l+CF
         3vJ8z/Pef4J27aG7qCR6hqJmB8lVjQ2n+nFftdts/vJGd8Ae91uzTUFp6BtdN7zgmv
         B/qNdv9j3H3gA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 070A260A94;
        Sat,  4 Dec 2021 16:56:00 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a6cae8ac4c95123d9dbda07a7cc553ea0367f4b8.camel@HansenPartnership.com>
References: <a6cae8ac4c95123d9dbda07a7cc553ea0367f4b8.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a6cae8ac4c95123d9dbda07a7cc553ea0367f4b8.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 7dc9fb47bc9a95f1cc6c5655341860c5e50f91d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3b8bb4547d4a6e92f7da45db1e68c170e2d409f
Message-Id: <163863696002.3540.4774055060965819608.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Dec 2021 16:56:00 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Dec 2021 09:19:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3b8bb4547d4a6e92f7da45db1e68c170e2d409f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
