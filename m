Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344547C850
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhLUUgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:36:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48390 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhLUUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:36:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3849B617B5;
        Tue, 21 Dec 2021 20:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99175C36AE8;
        Tue, 21 Dec 2021 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640119005;
        bh=uPHNF9xbRfddjQy938emDcAmzKVamF/aY+oL6reyMTM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lOYJ2ql0Z+zs+7I6luP0Gp7j8qhbdak+rDFUWhes756K9PPN+o2Xa+lPDSBQZ7J+g
         Ii57C9KdD0mEbrGcBzo3ykIBv9oLsGRq+aZir6IgIHPTQnlxPjVwWl+tVu7tfHibWT
         Zz0ByfEbC1cRY7UKnSEBtyvspegeTIAAaniNDwuXKJGZnHjNhlrryooQtzJ9HA440+
         JWUAnbqXOyK9+VT3DhtxljUcbzPwhvUlGIKLQRuhA2j+Ovkw/R5mDdCD/2r/9lcLYv
         vVkwwSOe6nDbDxRLF1Z3xY7fK1T8DrhaQAYjN9ehbiGra3W27bIcnNN2hajA8/00fb
         9FvwYsKrP2s3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8093F609CC;
        Tue, 21 Dec 2021 20:36:45 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hCi7TM+WsaW+DFjwxtgvpJSFe10yCwg1yug8Sn_+4TPg@mail.gmail.com>
References: <CAJZ5v0hCi7TM+WsaW+DFjwxtgvpJSFe10yCwg1yug8Sn_+4TPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hCi7TM+WsaW+DFjwxtgvpJSFe10yCwg1yug8Sn_+4TPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc7
X-PR-Tracked-Commit-Id: 544e737dea5ad1a457f25dbddf68761ff25e028b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
Message-Id: <164011900551.14510.16148976866619290369.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Dec 2021 20:36:45 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Dec 2021 20:42:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f47a9a4dfa3674fad19a49b40c5103a9a8e1589

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
