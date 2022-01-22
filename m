Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE9496AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiAVIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:06:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55438 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiAVIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:06:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1289CB81FCE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C25EFC340E2;
        Sat, 22 Jan 2022 08:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642838798;
        bh=TtNXuNfPHchc/hhR0GmbWe2j2FAd5oZd05CNWe5IKB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HQr7UsA1mL+Uu3Xxj87YrEwCo4NT/q7aOanBWCgGHU0UOMqhR7doGgbC7kvdp7uI+
         dgct6bafIHbdmjn3FQZUaP+9tXuznQnphdCiFaZkWtEVc1qRA0vWtZ9dy/YOWQd9p5
         +undi8uRvsnlBUh4KRbsQeJ/6E6esDJTuO5J5cr2Yx6mvwk0N9mkwW6enKXPeHgRLP
         i90I3seanxMd6kFssQZpnzpMkXTKYq8blESU1wOm3wNU1jTiNHJ6i4SIwMmq/IFCOd
         rh2cqOrdIB3Fc8DMcIIZe9BuTEkZBg8kx4jnNgY9z1B2ZBnvwxtiPCU6e2cTjaic8E
         zrC21kAQZAYmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF8D9F60798;
        Sat, 22 Jan 2022 08:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YermhR/kQO+dg7P/@arm.com>
References: <YermhR/kQO+dg7P/@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YermhR/kQO+dg7P/@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: bb425a7598479fa0f171ec806033c440f218b0ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b21bae9af1da9b319b5f52ca8fcda76a26cd175a
Message-Id: <164283879871.17909.4707779936735793442.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 08:06:38 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 16:59:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b21bae9af1da9b319b5f52ca8fcda76a26cd175a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
