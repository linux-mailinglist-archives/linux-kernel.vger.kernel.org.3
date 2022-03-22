Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B94E3730
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiCVDIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiCVDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EE28E3D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3FD0B81B44
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF9DC36AE7;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918398;
        bh=+VrkQ5qQx0jI/dAgMz/rAx+2rfiHpCNeN9ROIsRsLz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jI5PalNCKR36sU7ebtUFBdyk+77FzFwb5lnipXgh3qNqy8m2Q+kgVewC4OHHoahx/
         WhKTdbMtYQLAk9Nlw9/SsZI0ne5rYtwJCg+KbQkPHPo1x2j2N/IOiLS1tbhrsGVaux
         ViwIUNtVBP+b+L5HpUxzDjuRxTF0RU6xUinJ42+9den48z5Wl/BPZ+RZT4t45eiLLo
         jCD6d2RuOs6ZFf2UKAMYWFVDIvRUOIdlNZtG6MSQ33hpcj+aH2Xsvws8LlhkXNOMOK
         Nmkk+XuHYZOWrqZQyEXeBrFoYP3akszqXe9NXGOUS7KTqjq29fWrXl+IEOtGYUenyE
         DuGzkESTAlYmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A655E7BB0B;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210747.C40221E63F@keescook>
References: <202203210747.C40221E63F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210747.C40221E63F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.18-rc1
X-PR-Tracked-Commit-Id: 8126b1c73108bc691f5643df19071a59a69d0bc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2d7a4a354539dc141f702c6c277bf3380e8778
Message-Id: <164791839836.13286.3803635250418520072.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 07:47:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2d7a4a354539dc141f702c6c277bf3380e8778

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
