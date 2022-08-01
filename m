Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF17586F84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiHAR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiHAR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756245FD6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0266A6106C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 432BBC433D7;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=F1/U+QsZA1+2xtrzoY/dz09rQohQ+GeIT97BFycNNgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sh/ubO1SZKZ+z674CH2ssZLqfCJo2XdAn2Bd/+WVmgdZFg5PO2f5pF8agCeZkGPg4
         Khdw1Q/7zvHeA9A4liRGJWDenD92c+Si6NPhCTjeQvmAPnQspwvSOhZIq66/Pl0uL9
         QLlUt+mMhUtSgw1Cfz6Kp8yZnm5kdmNHEWR6LR3w83AoyZRdaW+P8mYaMI6+6d+GGT
         HoAziAhxF02nh2zV5kA4Amg2T/rBBAG3laVOcCx9MpyWVF9xiMpA9+MkWoK2IJyDZD
         x/FIE3+hLk5OYKI3sy1xZS67btu+k149fR2mVDXaWJ+8N1oI/6Yq7r4mbF84qJ6fhX
         H6eGauKIPFXtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 311E9C43140;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yue3e/D/045z5X4Q@zn.tnic>
References: <Yue3e/D/045z5X4Q@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yue3e/D/045z5X4Q@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42efa5e3a8888c45c15fc5a567cd77049a2e30f1
Message-Id: <165937482719.24126.15318419593513333173.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:07 +0000
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

The pull request you sent on Mon, 1 Aug 2022 13:22:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42efa5e3a8888c45c15fc5a567cd77049a2e30f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
