Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3118348CFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiAMBKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiAMBKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:10:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84611C029829;
        Wed, 12 Jan 2022 17:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EFE61B7F;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36464C36AF2;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642036217;
        bh=2mCzShIAUyN9oZdhX/fnAvRi5ynPsrxLgQJWXIfC6/0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HoNYQVfO73hsYkDtzYkSb9eA086TGMpEzF1jvt5sH94h1WxbjDc6gO9uU+HWDNq71
         3eLn+9XPTH34Yrg1E4WKgiwMIZXtvo4Po3seL8svnWFnKUk/iZaKxG4/l63ts6IkxA
         2Xnrkp78LkBwhrDlKwNZYtnZf939eGj19+JIXkll7cybgD9LdQlGCxllTq0kdSkcLO
         WFKIDfytTkFmSesGM8ACGVxMTvAV+QnLEsW30ekRO7KBlgbPaCIfyW43EAEBRASf1G
         cAWT6KubbQb/MZ/Kcop+v40ALAUTs5UuGQO9X82tdhvspHYGSxnu++txERdwY80zgX
         pnL/WcILOIu5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22F49F60794;
        Thu, 13 Jan 2022 01:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd8zXGvAUrvyw+ki@robh.at.kernel.org>
References: <Yd8zXGvAUrvyw+ki@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd8zXGvAUrvyw+ki@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.17
X-PR-Tracked-Commit-Id: e623611b4d3f722b57ceeaf4368ac787837408e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eb766f64d120f0b80ec24282df789b7db2ff838
Message-Id: <164203621713.494.15058005980189418215.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 01:10:17 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:00:28 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eb766f64d120f0b80ec24282df789b7db2ff838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
