Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE047E786
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhLWSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:13:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48008 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLWSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:13:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 979F261F24
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 18:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D401C36AE5;
        Thu, 23 Dec 2021 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640283193;
        bh=kOjoeuRIpTcgRNSN29HTE8sie4oIpPjLBA1cqrSPJOg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GO85cF1zW4icQW8wV8y9cXOZyBXN+gZ2nbVSVwuEjicfGspoPuJC+kR6J+Onurgha
         GNMPm8oQZLmYckZpSrHSAd7a9J0SZ4Pxua1bEGOCBqN9fUEEhiEoGDpefP2i9hxTLI
         27BESfsN3H4hhHFtTebQ3rtwQRNCaGMrat3TRLnNvgQDrJLx9vrJeYHD7spgmA8QG/
         vCXPuZUxNuvt4PvslhVttvgirH3fDpt5OwPyWubKBmxAUrpuQeOn0EZguXsFNBIS5o
         S43KQ5YgztSctlJ9TG5X63fN93SxrTqzy/Xw1h5W+kDWfYtE/vq6rKpR91TNtkfGNe
         9YYSOP5QmzkAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F18B4EAC060;
        Thu, 23 Dec 2021 18:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ha6grqsiv.wl-tiwai@suse.de>
References: <s5ha6grqsiv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ha6grqsiv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc7
X-PR-Tracked-Commit-Id: edca7cc4b0accfa69dc032442fe0684e59c691b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 996a18eb796a5ee61582dea3b76a4f88203887d9
Message-Id: <164028319298.29771.17828298908088556891.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Dec 2021 18:13:12 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 15:56:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/996a18eb796a5ee61582dea3b76a4f88203887d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
