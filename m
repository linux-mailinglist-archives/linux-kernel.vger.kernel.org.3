Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0447D851
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhLVU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:29:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45284 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLVU3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF889B81E5C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 20:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 751DDC36AE5;
        Wed, 22 Dec 2021 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640204947;
        bh=mdsgTgCNsoVWkpZibGPdNeNBdI2GgMcy7hfNkUO8a2I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PemRV1h72uNhY8UlIFJndAr+bicmSs6fQiASAB8qzx3ZWVLWQ7N4mhuWVAZ3gE2Ju
         +PNSJncMuStsyuR0imMbGldqo315XTe1Iii8QhTTVjHB7obqhjNbC+esLtsmMZ2HL7
         wV1BLsrN4DO8mgtudAijTV4D9Jfhqs+kd56iE4Qx7J8TeWJL++2xuIsmQGemGZ/Vnp
         vTvx/QyFBC5x3bTCblhBtNgVSOdLAocY3kZvbyBofUEdi36lEUzithrnGXKFM8rB1D
         5seX7uBHRdps5/nYDZyFwDmAkxadw84REoa1AljDamwck4b+7oPNjffONQEZnEWVBo
         gdQ2N7We7rcLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47112FE5620;
        Wed, 22 Dec 2021 20:29:07 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: fix memblock_phys_alloc() section mismatch error
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YcNltr7TxsAe+fzP@kernel.org>
References: <YcNltr7TxsAe+fzP@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YcNltr7TxsAe+fzP@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock fixes-2021-12-22
X-PR-Tracked-Commit-Id: d7f55471db2719629f773c2d6b5742a69595bfd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc491fb12513e79702c6f936c838f792b5389129
Message-Id: <164020494723.30170.16693591033297777984.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Dec 2021 20:29:07 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liu.yun@linux.dev>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Dec 2021 19:51:50 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock fixes-2021-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc491fb12513e79702c6f936c838f792b5389129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
