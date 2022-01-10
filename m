Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061A948A06D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiAJTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244707AbiAJTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:48:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46329C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:48:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8ABB81072
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 19:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA131C36B02;
        Mon, 10 Jan 2022 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641844110;
        bh=7Ev+uz21lEupNQcQk30dsRhEKHTHfJV7LSuU66rrAAM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DKTJH2R2Dc2RcgQODKHrQHgvNYf83jjcqJYaFM2EFgHMiGHs6yWrJTtLvHh8QCdZv
         5CNrEJnEpp9bUnZ0S8VXif1+FJ/bX1+iNdZpHXxR3uAq/I1/XZ1UFfe4oJH0j+/aEL
         NLPgTJF9mXO95/r/h4CJPpAhkiDBNZHbMY10aq5A2SJf22K11F8NNLCjwB01fmtNCl
         VF0yGcVPpew43Sw2YrVlwnQnrBvysk/ZEAAKsknjtOfclehdTzBoZvAj1J0gIIyli+
         dh2rHt96K2mskiP78Hs59aXvCvuazuOoy4+PWwlGMVjnovRh57+KePMZkTeWPwUXjR
         zCia8PUvGTYBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9C09F6078F;
        Mon, 10 Jan 2022 19:48:30 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwaVT1HCfqZZRFr@zn.tnic>
References: <YdwaVT1HCfqZZRFr@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwaVT1HCfqZZRFr@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 3376136300a00df9a864b88fa969177d6c3be8e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e740ae6350407d68d2069ce79a6344bf1b58fe1
Message-Id: <164184411069.23269.5050042534963072606.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 19:48:30 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:36:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e740ae6350407d68d2069ce79a6344bf1b58fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
