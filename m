Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375C4A00C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiA1TUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350879AbiA1TUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:20:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF6C061714;
        Fri, 28 Jan 2022 11:20:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6F3FB826EA;
        Fri, 28 Jan 2022 19:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC77AC340E7;
        Fri, 28 Jan 2022 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643397642;
        bh=7sRkAAw9Yg5eEaEDz/4DdtSYTtwMEyuPQdQ6JclzmM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u+rAy8iX5iDr0KE3bWPi4YqoOeGgr+8C0eGPom7XO4ELCOjEiBkjhWVBlqrAYeVTY
         u7GikVqEABPOzXdRtti9izREMpBt1AEe79YrU19rAq85S5GSTr3317N2iHCrwCd+mq
         513PqlkB4aEXHJxV8LmEdvI0lXDVDcDxr0lBKDtOzQNF9TxBwVjXKEpWvPqgxE3eR0
         A/e29h7Io/wABvUId91CGWyD3/Mcwm2swExIK2wpPZ5NsRZm0kH+RVrQMzJTn8dNnm
         ufUHBMjxbTM6c11JshC1BROv6aAIXOHYB8u6/hR9qsb4oAUikJDZ9hLdHFSGpFPpca
         h4PihEu6Aqo7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C096F6079F;
        Fri, 28 Jan 2022 19:20:42 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ebd76be7c06fd3f8f888094fb2dd8e138fe97b33.camel@HansenPartnership.com>
References: <ebd76be7c06fd3f8f888094fb2dd8e138fe97b33.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <ebd76be7c06fd3f8f888094fb2dd8e138fe97b33.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 4db09593af0b0b4d7d4805ebb3273df51d7cc30d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 169387e2aa291a4e3cb856053730fe99d6cec06f
Message-Id: <164339764263.2973.8302135137345133481.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 19:20:42 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 12:14:52 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/169387e2aa291a4e3cb856053730fe99d6cec06f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
