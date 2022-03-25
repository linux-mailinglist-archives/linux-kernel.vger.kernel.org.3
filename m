Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB154E7E00
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiCYVI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiCYVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548B1EC9BB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF6EB829EC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B03C9C340ED;
        Fri, 25 Mar 2022 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242425;
        bh=WzUnipS+6z0wH2qupBi+/57goXorYw462qucOsOR4/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QGXvTFw3VHhjPmBlEzRG0ozS23pzhv/l7QqjZUafWnvsodqiD/L6Qe3efnSOznDgc
         4K32bFuowEfHm4rzHJew5yn/3WIry0MpYaYecwCpCAlTBB2dyaRCem0YcfQuJZZu4c
         ZDoMe4vkl/9qlw6Gn/TPEFku1p6+k+bUywxXqZzTY2vfxmhbuDqMn++YLPtoaddcF2
         fDqenyNZbv80gB9YGPQOcCOHkI8OEDyzIPI3Q+rGvositWNs+wRe7IYuEew6lRUcH7
         vSFHbJSNkQRtn34pig6mq/C+tQtrUimq8npKb3uRHKNMuIKQ0Xwsin9r45EDnvMQRr
         vE9Nq6jQFyUCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CDECE7BB0B;
        Fri, 25 Mar 2022 21:07:05 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjtZAvQnshp1pZIh@zn.tnic>
References: <YjtZAvQnshp1pZIh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjtZAvQnshp1pZIh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 7f1b8e0d6360178e3527d4f14e6921c254a86035
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 636f64db07f33a18630248b4c57e182cd315b0da
Message-Id: <164824242563.8431.8410024766575049316.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:07:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 18:29:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/636f64db07f33a18630248b4c57e182cd315b0da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
