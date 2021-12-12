Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2D471769
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 01:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhLLAes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 19:34:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57006 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLAes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 19:34:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09760B80AD3;
        Sun, 12 Dec 2021 00:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B573DC341C8;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639269285;
        bh=h4z71no2B+IzmFoHJihTlkCMluMFbpu0k8Tb2UH9rss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z0pfl4xMOQ+Jbi5eRvO8o+HUaShp7YFoWrTSfDgIYFENc++3InJs/kW1aaJwoUVJB
         1zAVacNiDMTGyObia4+9YqUhkbpuksRtyAM4dGeK2rQOw9/UDkSCfVSfqwk21FhDVl
         ev+jcQ9ohaNlNEz1had5MMHJTiLa4rs51BdWO+xvk0Gt5eNUYkPoGxoHflbpeTkpmj
         R2ZiaNCLGpOd8pp4VsnZ7yqR8lYbiLHVmIVxp/uHyIZShUQeG/IjXT4Y8/fN2QQiBS
         6XqvDHNAhdBagp450LtQNI01xMhloBZXiXeQPcw7y0LVDr4eHpo0h6yy2nSeiVpuIA
         zPvlWFbsjAqxw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9CF2E60BE1;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <96712f5c6b956c44a176ec99aa214617ca3fc15b.camel@HansenPartnership.com>
References: <96712f5c6b956c44a176ec99aa214617ca3fc15b.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <96712f5c6b956c44a176ec99aa214617ca3fc15b.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 69002c8ce914ef0ae22a6ea14b43bb30b9a9a6a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a763d5a5abd65797aec3dd1bf01fe2ccbec32967
Message-Id: <163926928563.10000.17500742741402022468.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 00:34:45 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Dec 2021 17:19:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a763d5a5abd65797aec3dd1bf01fe2ccbec32967

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
