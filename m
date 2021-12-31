Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC558482578
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhLaRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:51:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41796 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhLaRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:51:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B7261807;
        Fri, 31 Dec 2021 17:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9488CC36AE9;
        Fri, 31 Dec 2021 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640973073;
        bh=6PkSYquBgI3pcJl8OCxkf0gBtPFILILoRjQLS2v0FKE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CSAEqja1ZdKi7gkxlQGiOKjW8BId/eeSoo1HPaL2vy1HIH61xoy3U8JHRHfc+PlxS
         Z83PvwyK5NMeBPBJTWfbS7yQtO8XREJ+9bRQDjKFr2lEORFII44nbaz2za6d1rG7Gc
         vxxTKTl3E873ZTk8iGnlKLf+VWZdsmekPUI0f5tcX716tYVdW+XG10Magwwpn7SqdJ
         LfLybfx/deT+Hh1IEDsHnhgSEFMurofl9H5cURb25+aW/onC6X2HjoSCIeMjJ/LZzB
         G+paFz4uTp7kaA6L+/UFb5BHt2RFVk/5xFUFprDheAXFtftHTP2gArJuYRcZ6pxrIU
         MtaIE303M8qhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84804C32795;
        Fri, 31 Dec 2021 17:51:13 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a2406164955ce9a1eea3f3accd33a9b9400ccca.camel@HansenPartnership.com>
References: <9a2406164955ce9a1eea3f3accd33a9b9400ccca.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a2406164955ce9a1eea3f3accd33a9b9400ccca.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 142c779d05d1fef75134c3cb63f52ccbc96d9e1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e46227bf3899eb21d738aa8ef2ec0f598dc70f7a
Message-Id: <164097307353.20293.14242954237513746148.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Dec 2021 17:51:13 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Dec 2021 09:56:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e46227bf3899eb21d738aa8ef2ec0f598dc70f7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
