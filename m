Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38C3466A83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376911AbhLBThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376809AbhLBTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:37:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563DDC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:34:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10D98B82486
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C3CC00446;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473640;
        bh=3S/hVsYtmDI7Nzjm1qPI1v2gbCsmQNn91HQTveeq5BA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wc+Ib5yeCd9WKId9e0Vgt3tuqKmORoVWp8MEJNqSYy9gWZS02p6ngQ9ce10vXW5J/
         aN7L2GsVEB7kDdUbsqAoAAvd3G+Q7uIz0KDVC50M6kCH1vF/NcstjSFPnMs+b9u771
         LVluHYQvCwsELZ4JA1CuBhi+IvrIso+UQ4TMv/NeracDmCNHBkKxk+xfkfdU6ECSxd
         DtybMoE8M/jrFsUXxs4gXnmWhtuoWYz+IrJmEjcQPyylBwMbZT04aGc6PkOpVOpRcc
         yCjtfdRqieZKfwPxAWdIU1an5E1JPlA0JAp1kol8eLIF8ZZ9Q+QCf4g6NDthOcL+FR
         2Cgs1tkd3lzXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9885360A7E;
        Thu,  2 Dec 2021 19:34:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hbl20zrum.wl-tiwai@suse.de>
References: <s5hbl20zrum.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hbl20zrum.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc4
X-PR-Tracked-Commit-Id: 289047db1143c42c81820352f195a393ff639a52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4536579b76168db26d38e4b8516d05570a412819
Message-Id: <163847364061.31731.6792627802164007351.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Dec 2021 19:34:00 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Dec 2021 08:50:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4536579b76168db26d38e4b8516d05570a412819

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
