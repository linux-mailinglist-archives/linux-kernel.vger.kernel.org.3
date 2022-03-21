Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2A4E30B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbiCUTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352715AbiCUTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EE4EA1E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DF3560BB9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80310C36AEF;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=+KqON8cm+8Mj/SqhoUnEsgcvWdlUM8r/F5l2EWQd0Pk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n1mkFAzm4IfgbZ/fSaJKypcrFRYj4IzOa4Ju6cNEkeKAkt+C2WVREL0q6+vJScH9D
         0BA8dnK5TJcXEh1pzMA7bv/SrEtL0ntQUNnLp8/ulgodGlP+DHc0MrDbbpWtbVuBdC
         fPqO13Dvne0zojiM67NNGyPNttVyE6UB5aE+cnxwXtfNGVTfi1RoczASU5jG9XAmcX
         Xg029jUo7ILV75ex1HX+GKO6QSYNgAO4t86DNuAkM/4H+S4YLX1C/TWMPt6mdvoWrN
         Gj51/kUAsp7Z6j7xMDggXS2sPOZGKv4GI+nFv4b/CuG7BTHEf6EJ34pe4YCoyKYR7x
         OZ8oR1Z3Ovv5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C373E6D44B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhVkhyJPuz66ZTA@zn.tnic>
References: <YjhVkhyJPuz66ZTA@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhVkhyJPuz66ZTA@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 5f117033243488a0080f837540c27999aa31870e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88f30ac22733f8cd518e42702042cb1e1c2c08a7
Message-Id: <164789031444.24158.4783001922102893529.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
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

The pull request you sent on Mon, 21 Mar 2022 11:38:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88f30ac22733f8cd518e42702042cb1e1c2c08a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
