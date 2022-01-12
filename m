Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930CF48CBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356744AbiALTPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357040AbiALTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:14:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F8C061759;
        Wed, 12 Jan 2022 11:12:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 454DEB820D1;
        Wed, 12 Jan 2022 19:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0EC6C36AE5;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014729;
        bh=RV/9ipPrmOLJGXvAqnWVtBhf1H0uV2Um/EuccX/yqHY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Iplz2Bpbb07qTdbTTwDHa7MnawjUTcwKOqo/bflgt+/OZ8pSNthMLD6Tc9KraPgLj
         +/rheoBgftyegqtWOqe1Xu012RtIjfJ/sIA9DYY6XW+9RtVRUzr+7T1ZpFyX4GAbrq
         PX7U/zE0NPkRDFl2tFjSnuxsautSp6Gjo1ottb+rSPKssK4SnGTVNF+taZOx7asRN6
         M6j1I277u2j80XuuHGOcjKcVyKxXq8C3ndzdoBRFNvoOkl9oWLcjzFuzeI0v8fkZXm
         girDxteDzvyBu5KIRyjRUTSyWnlBx10gO3cm4TtJ+VJQnCQMfIR50K/Pl/JZVIbqb0
         fxg1CxRFa2mtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFDB4F6078C;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
Subject: Re: [GIT PULL] pin control changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
References: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaVGwu=Bo5bxVQYZXD-k+x++SuOTApGoK2a_S-1M4Q+nQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-1
X-PR-Tracked-Commit-Id: 7442936633bd1906a2571116ae334b68c56c8a72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3084ed48fd6b661fe434da0cb36d7d6706cf27f
Message-Id: <164201472890.2601.800762283673218441.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:08 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 12:23:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3084ed48fd6b661fe434da0cb36d7d6706cf27f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
