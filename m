Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00BD48A06C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiAJTse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:48:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48210 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiAJTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:48:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 451FBB81642
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165D7C36AF8;
        Mon, 10 Jan 2022 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641844111;
        bh=2RbJfb7LWa/K2z+bgLm171zPDegAFsBByDvnQ0BKv8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rh3vZX6xtOirI8XIkj/6R5yoPPIVA27nSjPQ+3+252rQnZqAajY9OEu7r8lJdohoc
         i9qYg9Uj56DfEwX+RFAOEPboEdsWHyjgcAynsHJQHT11D6euvXZOFQY7PrEr7qFgZZ
         x77Ma0igJfhVqlnb2pDd6hu9x7XyfeiaQeEb4Y85+f34+AqY9pgRLBGALrmS8sY/9E
         +b4bc3XCW3LgIwORI5/90TJ96SHozwVdwgQw/z4Te9GvC5Nv7GjanczS68WcEq82hs
         Jzl9NaaZGpvd2PP3rmit6yvTUZ0dtpWGM8S+Fu1Xx+ILJF+MC+KiaR3wtIYY3x4YBH
         F25+bu7Wsdedw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02957F6078D;
        Mon, 10 Jan 2022 19:48:31 +0000 (UTC)
Subject: Re: [GIT PULL] core/entry for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdyBj2BpUyFa5ux8@zn.tnic>
References: <YdyBj2BpUyFa5ux8@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdyBj2BpUyFa5ux8@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_entry_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 985faa78687de6e583cfd8b8094d87dcb80c33a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48a60bdb2be807767eba6878fdf2fe5bea5d8d27
Message-Id: <164184411100.23269.4410621972603155028.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 19:48:31 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 19:57:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_entry_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48a60bdb2be807767eba6878fdf2fe5bea5d8d27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
