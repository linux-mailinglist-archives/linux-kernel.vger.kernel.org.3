Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0D532143
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiEXCwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiEXCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046A52181E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4AA61252
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6FCCC34116;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=QaB5SYqXeMwzolgk8uV048aGOa/qpOS0EIDYxIuVewo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oZP8Zoa7PjKlS91lZCXc4iaj97DQjfvauebkdz4PVFSrKBe4LXj2cTHYivQhUpMzy
         RVJ8B/5w4XIntl6Rprl6g07XOgylDVHT5tQ2us4uZotkU3CCfZQs+zAQ2AGRsSJ2XJ
         ugJ40oKh24jdnipJqS/uBGLpLUWZ2zPb43xNv3/DXUb3pvr6KkELw5tZlCepi5jI59
         tesv7LtDQi/IbDEiPHzdzeTXyoq9I4kGZ9GyOcY82JHztAIpV0lLUuNhGhX9/pOf1W
         awqabOeUnBgn+gcOpfPIF6ZFi7NS+yt58uRAWWJ2EwB7sDz+ZNixrVymMFySvvsSQg
         1wXGFZlfzuD0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6444EAC081;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YouxsHVKnPPiMckV@zn.tnic>
References: <YouxsHVKnPPiMckV@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YouxsHVKnPPiMckV@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.19_rc1
X-PR-Tracked-Commit-Id: b91c0922bf1ed15b67a6faa404bc64e3ed532ec2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e36ae2290fd1ff3768c3688627e442cd11d4ca1e
Message-Id: <165336067587.14181.14820571450265255212.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 18:09:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e36ae2290fd1ff3768c3688627e442cd11d4ca1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
