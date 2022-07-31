Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB6586003
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiGaQz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiGaQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:55:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD663F2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B196AB80DB1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77F5BC433C1;
        Sun, 31 Jul 2022 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286548;
        bh=yXjv3QOOcG1bVE0d57ZMN72//8gckCE7Sw2fpTi8x14=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DNArrh6P6AjcA+4htBuOnRoe/NI4QxjniIKKjp8SnnJmXIr/EvFSW7j1oFL6/kUBr
         8W29vFvKIjK6kTgOXQNZIGbl2COkE2pwwpxaaXYI19LUUrrebPYuZtes1l6uNkbm1Q
         hyZTk3Fug/h/NCrOKaELM8rJ4Oj28Rkh+a8g4d5+FHxRneca7f/oMbQ4LR1mdLthFR
         6Ov012KmO0ojzeGA+gsGzFdX/QPjGqnGd438QpnsLLmih2TSkLXCsxfzb4kPofJYUH
         h3iScZzc7or2+Z34Jb2iRJbsxLXkcWLgYWKqdcbh12UI1guqKHrVRAK+XaGE3nW2UD
         yr66pQ821qv6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D52DC43142;
        Sun, 31 Jul 2022 16:55:48 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuZRWvbk4msK+M1p@zn.tnic>
References: <YuZRWvbk4msK+M1p@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuZRWvbk4msK+M1p@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.19
X-PR-Tracked-Commit-Id: 6eebd5fb20838f5971ba17df9f55cc4f84a31053
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e4823e6dab8fcc897757c1be68d157a369e4bb5
Message-Id: <165928654837.8632.15350149180176298459.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jul 2022 16:55:48 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Jul 2022 11:54:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e4823e6dab8fcc897757c1be68d157a369e4bb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
