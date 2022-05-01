Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD0516685
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbiEARNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352315AbiEARNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340964DF44
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C233060F73
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3337FC385B2;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424979;
        bh=3yxMAVV3FR/Ty/G/HKynl2mrJ+tQnqECjBhupz5Ea3I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ez979hP8ZBo2722EzYbkH9L91bYIKurCCKzVIZvaoCFnkz5IxSwu8AIipYL+0+NNq
         Va94Nsi7YvzMLfvHkJsGMm9lHiXJMki75FP2jt6OSljI6Xu9NgapPrOEL6YGHUax+y
         J1BN8x0GRghhFMB5atpGkKXLymrR7f1jrt1NCOpZeiCwbBvAMqa6PYB2pJWFHhOCF/
         2aTQYwx5bovFkcMIYA40dEOI6Yf4s1VsxDRb9AxzfQ727i+h3f85La/iWYKt5a1J4s
         LbwBM6zQPwpYS3eWMqcnFk46TB8reiSDHyIlK0yBnk6bHQu2n/dRkS+BO5A6bwPE5w
         YhQpypHEmexxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17A01F03847;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym52PqI9BCAfDZuX@zn.tnic>
References: <Ym52PqI9BCAfDZuX@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym52PqI9BCAfDZuX@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc5
X-PR-Tracked-Commit-Id: 7e0815b3e09986d2fe651199363e135b9358132a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2da7df52e16110c8d8dda0602db81c15711e7ff
Message-Id: <165142497909.30448.2811816380151132620.pr-tracker-bot@kernel.org>
Date:   Sun, 01 May 2022 17:09:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 May 2022 13:59:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.18_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2da7df52e16110c8d8dda0602db81c15711e7ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
