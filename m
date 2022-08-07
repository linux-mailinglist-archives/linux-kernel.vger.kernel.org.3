Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C785A58B8CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiHGAuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiHGAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56804FE3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB17FB80AB2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC83C43146;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833411;
        bh=2QEiXM5WFPy1ykP7BiJI1c6DY/Mza/N9D80RFUXRsms=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T4QViP3k7pl/vJYKg5P8Gbj/7SPihg6wHzJfUO/vVzpMLtLf9F+tV1zm6U4ru0dfq
         2zPrB+CEmW6MAv7JPAwyd6Zszxc+nigkdH3edYaQzliLDPKsvIROxtDljfOA1eybUU
         oTTeEP/6Oo7S+hx4j7Vtp55fIfX5Cbbg1uWHYvSNF3G8ZypeVlV9NUFNWwQNvZv5wU
         UjfAJIZV/C2VZP2wkeLAQ/kgThv/MAxFxx3N1sMXUXi6IXsP+L9ZsljEb4ESmKhlbo
         wMdoXhg+De1H0jNQIuj/1kDf4UflErvJHek2jRQY4G7o3G+04j5Wjj6W0ATkZjNNXe
         d7GETVMjn/Ycg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77329C43142;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu7BI4wlC6J4tGP6@gmail.com>
References: <Yu7BI4wlC6J4tGP6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu7BI4wlC6J4tGP6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-06
X-PR-Tracked-Commit-Id: de979c83574abf6e78f3fa65b716515c91b2613d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1612c382ffbdf1f673caec76502b1c00e6d35363
Message-Id: <165983341148.27609.7571618432622136697.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 21:29:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1612c382ffbdf1f673caec76502b1c00e6d35363

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
