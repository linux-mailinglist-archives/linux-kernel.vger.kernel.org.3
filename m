Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A84F0C7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376489AbiDCUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376467AbiDCUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A267133884
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6370DB80D32
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B5CC340F0;
        Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017801;
        bh=yIbcXfLFVW4w2t5Jkf2ABCO0kSDfHOBRDbnAmhL7Wgo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hs7XoFE2Px2ozHTwe6+GE/SXoFj/emc69+m7scPQduwxs/8tPPKwsGVHTJrgaq0Jo
         mxrQdt6OzzyBdryPIc3q+XD9g6HXvienH1eJtqxACmu3HW7MH2hSIvte8/Z3vU+ETN
         GnlyGcIoa3Y7n+BPflFP6ah4Savqrm3hDxMVaoOAtxglPCky3yjM1+dhyT0/lLxGry
         IdSWGQyT30MPLXNWIlzcMG4p9H2qCyf+tXaXibQo4DZRrNqCMSjVN43+DWnbk6I8c2
         O7DfBM0ZKB/0s97AIeH1KWXofgcueWQtJ0JL/edkH1qMDIphoHUOk9YGLU8k68M0OR
         UPMUitR/Kyi4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5502E6BBCA;
        Sun,  3 Apr 2022 20:30:00 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164897467026.360450.9213450977031549110.tglx@xen13>
References: <164897466883.360450.8070511660014503126.tglx@xen13> <164897467026.360450.9213450977031549110.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164897467026.360450.9213450977031549110.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-04-03
X-PR-Tracked-Commit-Id: d6d6d50f1e801a790a242c80eeda261e36c43b7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b5656bc4e3707da642cb4a9126f4849fb518423
Message-Id: <164901780093.22329.2915979479207473909.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:30:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  3 Apr 2022 10:44:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-04-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b5656bc4e3707da642cb4a9126f4849fb518423

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
