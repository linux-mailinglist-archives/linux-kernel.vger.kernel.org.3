Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6048A6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbiAKEzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348104AbiAKEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:54:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E18C06173F;
        Mon, 10 Jan 2022 20:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA4F7611C6;
        Tue, 11 Jan 2022 04:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A8CCC36AED;
        Tue, 11 Jan 2022 04:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641876894;
        bh=Jazq8kwTfHY32vDzgEyvmcSeSN1UUY6Zh08ZEsPgz70=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZXFLb/j45VjQD2cADD4UEO/X1YXFU4cdbR/8P6djQ4HtVK3RBHJSeTWAKVMD+UaA9
         XEEsgeG02UPo6w9XRqxCG5tVqjW6nawuggq/hzf61weKbrRFit8dRVd10TbwSxkCOc
         56do4NBDRxi0cscYNW+xB0GBj9RVm8nFdlEEddGuKI723YYcdAfkr0IVv1g99Ad/RN
         5W81zlkI8OhnbbF88+qbgA0zVpehCtaXqqBemHTBEt7EzL4ZwkkA0MmXJVNNsrIDAT
         sY1NIYYnK91CRkCN0h37WOxQ+9g4R6pLF/5NHKz70WhgEmo26WNLBQ0NkeVy5hySMI
         VxfqbD4lNjYHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11436F6078A;
        Tue, 11 Jan 2022 04:54:54 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ipPn6up69zcR9RAS-=pPFwjpmEri680jgh8EtOP_A1+g@mail.gmail.com>
References: <CAJZ5v0ipPn6up69zcR9RAS-=pPFwjpmEri680jgh8EtOP_A1+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ipPn6up69zcR9RAS-=pPFwjpmEri680jgh8EtOP_A1+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc1
X-PR-Tracked-Commit-Id: fff489ff0722bec127a05667bec00ea45cf9f77e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe2437ccbd278af683d32196fdea59a3b95f144e
Message-Id: <164187689406.26750.9635055881759623663.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 04:54:54 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 20:19:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe2437ccbd278af683d32196fdea59a3b95f144e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
