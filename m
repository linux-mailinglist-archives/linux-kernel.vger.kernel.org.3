Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4E94AA459
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378177AbiBDX31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:29:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42532 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378160AbiBDX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:29:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A90C61C06;
        Fri,  4 Feb 2022 23:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D51EC004E1;
        Fri,  4 Feb 2022 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017363;
        bh=fDF46+zsy1ULl1J/h7zI82SaZBUjCuhoK6b//9/WUlQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p9ar+ynTAdPlXxO4Ox6B3R4ctXI5rj7XIMUdb9ehspYI9YU4DKa++Trn6Jxx80SkN
         bAjCgJorMfCM6s1LNzDKGzTSK9IOuR1HwllHlMD3acyJkLxeIEh0w5RF3UV8eEIcT9
         o9802uOtWibX+60i9cNux9gFNJ2YOClmI+RXZpDAdc9rjQoR3Qr/oDqWSrq+faIWQu
         k2HAaAgMw/99JWS4TaxRmBTqq7juaFjSyRvvT0lHf9cfWvt3WUBbfotnsJ3Oswl3uz
         dzPTnkGR+VsVBhkLdEi3JFKSe59TdKsNsXKSmvY8ETMNjVjcmTr5Sw1dTiXmxw7XBC
         925ryziRQk1Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CAA7E5D09D;
        Fri,  4 Feb 2022 23:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d63aa0057d1db718134f98eed5f448cdfdc25657.camel@HansenPartnership.com>
References: <d63aa0057d1db718134f98eed5f448cdfdc25657.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <d63aa0057d1db718134f98eed5f448cdfdc25657.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: c763ec4c10f78678d6d4415646237f07109a5a5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc93310c67ff1c0dc38e3df7814973b55eea5559
Message-Id: <164401736356.17432.4454457752283538218.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 23:29:23 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Feb 2022 16:54:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc93310c67ff1c0dc38e3df7814973b55eea5559

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
