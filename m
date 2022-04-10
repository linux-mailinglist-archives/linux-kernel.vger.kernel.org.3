Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054A4FAF7B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243320AbiDJRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiDJRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA6960D97
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68212B80E50
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30911C385AD;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613152;
        bh=A6l2XwEe2hCRpijmUo0i+vk9wHgdjAh/+C6X3O0LldA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HUYB0Pl3fnmJKn6Bt+kFHkEfqxt2E4Dp+0QMT6P7M1SwqE1OVvgrg4QNcAK3G37/g
         2mC5kJ6segRALJq+xzsL340mhbBXhYlIQpXGiM/NQiSb7z0LnQimh/Z4o3ESCic68k
         iHPTnu3XWe4+XJNXoZKVufASlp6MnFHmzPbc1KbdFLDurrNiyee/KiIAJLsskZm7zE
         +GKXPO6zjvtM8jBg9iKZU/+G9W9fT/tcQFIbnx824l1fvMkuD/Znnmz2DhMwzGx4RI
         QRSlbJw7xntOAPdL4RbXwgiaONAkJ/IazL4XCgEQ62tinaKK2Cf/mAymomnmMRHevX
         vU7RnQeJ0wVmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 096BBE8DD64;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlK/syONzEUgRsgV@zn.tnic>
References: <YlK/syONzEUgRsgV@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlK/syONzEUgRsgV@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc2
X-PR-Tracked-Commit-Id: e19cd0b6fa5938c51d7b928010d584f0de93913a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b51f86e9900ab1ff05fb5674c17fd3cb858c4500
Message-Id: <164961315203.10430.13742411105982178338.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:32 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 13:29:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b51f86e9900ab1ff05fb5674c17fd3cb858c4500

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
