Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17637471C81
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhLLTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhLLTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6DC061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65D02CE0D98
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 19:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91360C341CE;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639336609;
        bh=Lkd8iJ195vckVdlzK8FJZ8s+qXfR+PZu0o3QSfFHTHI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aqZVKNnvRAqzRsRkFYj+KqhIZDPrZAh3drj1Nx6d1MjP+Xa5HWXf3C91UdnguHGnR
         kDTe95AoPSAw3BBhqi+zk+iTby6JtuZ6Qac+V/EPubAsUvVinHGnPtlhgS4Fq/YYbc
         3NxIgJZwR6ymRmXcXn9t++b4+vyuYVB+FN/6RNS0cOlC2lgWjK5OPXoz31cr1twNNm
         Aw3DlwlvaYA1pH6oqMVPq8jGz3bEirOgvMwHOXX4h5ShuYWqjOEsmWr0sp7w5fOxut
         Mt38urkCjy68hOhiMoJaRu57n8jzDaYiouXbZ8NVbOWSIklnokUzQbfjJZSkM8WOLL
         l1TWgHVD9QzAQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7C3A460C31;
        Sun, 12 Dec 2021 19:16:49 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163930519961.2118055.13711839421332400381.tglx@xen13>
References: <163930519667.2118055.7751610896538340816.tglx@xen13> <163930519961.2118055.13711839421332400381.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163930519961.2118055.13711839421332400381.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-12-12
X-PR-Tracked-Commit-Id: aa073d8b2a6308832de3cac18e7901ac60748e26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7fc51268bc09c5f012f5e35e872f4e319f95f80
Message-Id: <163933660950.938.9957884775819945305.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 19:16:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Dec 2021 11:34:23 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7fc51268bc09c5f012f5e35e872f4e319f95f80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
