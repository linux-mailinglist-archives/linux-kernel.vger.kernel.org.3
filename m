Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8814E30B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352604AbiCUTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352720AbiCUTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84F5676B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22FA560C7B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E97E4C36AEB;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=9+pV8SdzTikyNQKoJLOJYnJnZOIMsasdS8vVn+25Ol8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=npZUUcK6khWGghJ1S5SJZ/jwr9v7vBG8mI1lpI4EDADArjzU/lAvmyT/eto3qA7N5
         lyEv10GPUphZlOsKTY81zkyH8gb5lUp/n8eoBhTjD3fpwvq19xZMV2LJeBzZ+BSmk+
         WErfz43+BXZI621qC9VKdzXKmNAQgLCK+JaMjDQReUJrIHrlN8ZSDdHbNiyhL9Mf/t
         y43JU3SpIk05jKgR5IPyMDkwdy8mG6JQc4NY1jVcv9WiseBkXndTt2f+aq3DPwK2QX
         u5iKYeikjPn+2EEkwsm7Gbn4k7DiAHizVfF+oPtSnrRi1JhFHqJXLjO6SyhgIHSP6S
         Buo0q+gsqhJoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0F3CE6D44B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cc for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjiTq6esjAKwvvZt@zn.tnic>
References: <YjiTq6esjAKwvvZt@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjiTq6esjAKwvvZt@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 1e8c5971c249893ac33ca983c32bafcf5d50c727
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b9bfb1365f40f14b1ad908c44dff61672c6404a
Message-Id: <164789031485.24158.5279869676630089925.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
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

The pull request you sent on Mon, 21 Mar 2022 16:03:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b9bfb1365f40f14b1ad908c44dff61672c6404a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
