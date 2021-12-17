Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881844796FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhLQWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:21:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhLQWVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:21:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F04B82B20;
        Fri, 17 Dec 2021 22:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B0CC36AE5;
        Fri, 17 Dec 2021 22:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639779682;
        bh=lJqsFfgqmLa6eDo5dYwzluroYrvZB9sXZ3mrQWTejsQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n28bQRZPCi2M/xayGM/MVUQgJg9ptGSQVK3Mb/Xda69Pe+wNA9NWfFn75eWImUKHA
         206a+JzIxQREphb90I5ldEmPOEy0Rp3LiNrRmE38rluJbCXRDVJaFtJVA5EtaSemGr
         SGST6zl3f5oQZ0PovittJrnnE5FYFbZAG4FnzX8hTPhgP18vsedF3P4YmxdIhTNZ2G
         JCdRg6qOyqHTipZeyyhpQE9MHr+UxRSmeFKLIgumxfGAAeuCn/X2dxv0MCiBBjHJQw
         zjotEudEMMhFuqfawOZ6iEuMC+GRISmnpWjEcTeFCPSvj1PHXVkR83Fgy5IEabkAeI
         fz2M09ad6qmoQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 239C460A39;
        Fri, 17 Dec 2021 22:21:22 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d2fdf91ea840cd1cd88e5ef12f35034056fcb801.camel@HansenPartnership.com>
References: <d2fdf91ea840cd1cd88e5ef12f35034056fcb801.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <d2fdf91ea840cd1cd88e5ef12f35034056fcb801.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 2fe24343922e0428fb68674a4fae099171141bc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d65f6f3df56021ec76761ea6986bc8139f537d2
Message-Id: <163977968213.18736.4405420496751811176.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Dec 2021 22:21:22 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Dec 2021 16:46:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d65f6f3df56021ec76761ea6986bc8139f537d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
