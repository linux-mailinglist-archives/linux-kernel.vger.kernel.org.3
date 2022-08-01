Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80A9586F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiHAR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiHAR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32067B4AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58704CE17E7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E0DC433B5;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374826;
        bh=eT91/Jwt2w3KnpylvyIXFGAKC+TQqKnxr+j3hasgjHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OYSktsgBLY/lgANMEZasskfYu6R1Y1IL8RCt3vHukMN/E3ShA8cHImErtaI7bG20/
         d9roZdAe3pDTdoH2ojXIm9444Pixxe2GvzcliDhriSsX+9PeHhN7OXBYuMhfYyBEjk
         b5QeWPCFidOEqcRNlfsDRBCE1DrWFJQg0/1m0BlENYTF3RMu/AkK1YBL3kJngC8fNm
         MqI3KZdQ5bcPb+TQJga5Xm2RgiBl/Dqttk+jtF5Gc+PX2AaNvdwVq+jFp/aWxHtWFr
         1usMrv1j+1Zi00NIqG8fCV7NNkCgf9lrBKLHbV9DM9eTbbK93BXL+y17f1NqkwzT+N
         WceO+pZHZu+sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90172C43143;
        Mon,  1 Aug 2022 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vmware for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YueOO27xFRoFifNl@zn.tnic>
References: <YueOO27xFRoFifNl@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YueOO27xFRoFifNl@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vmware_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 4745ca43104b422354f06dc814d3f13661f217af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbc1f5a9f42a9bb31b84bba4d40ced21952d505a
Message-Id: <165937482658.24126.11370929770098795427.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:06 +0000
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

The pull request you sent on Mon, 1 Aug 2022 10:26:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vmware_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbc1f5a9f42a9bb31b84bba4d40ced21952d505a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
