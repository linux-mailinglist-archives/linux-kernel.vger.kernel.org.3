Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4574D3BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiCIVHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiCIVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F510CF3D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:06:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0CFE61AB8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BE46C340E8;
        Wed,  9 Mar 2022 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646859981;
        bh=QHyQ3nVeup6A7S/YyJ8/Xc9gH+3cPfk455tCjG34kZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iSFBKE/qb8rq5xiNY0mPzukDOlkzwRh/uRR697UyFohHhia+xxJjXTmIkj28Eab6w
         i+/C5fK0FrWXKOigss+J7zSWV19gIJ7eznou1H6xDFHa/2AYjUSFg+Ou7DTY1y1CpQ
         cNEJMGa0J6ykHuuWoqjmMHm7F+nv4mzWMUEV3PzFJ/iPMPaGk+WQFudBcK630bT32T
         xZwgw+SERNgk+1YBFg6d5Sfl6I6ih6+FltdscHGr3eQFth8sTkRthMhPrUJyStlUCs
         VpOa3gEIuZzRV5zwIV71aY+japjaTfZtryiVvsk37lB0gxVnHut9WCOnUN/D1EEdRX
         GvPp2WqMtoEBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 148D7E7BB08;
        Wed,  9 Mar 2022 21:06:21 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yij6MY63Lhg0icIg@arm.com>
References: <Yij6MY63Lhg0icIg@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Yij6MY63Lhg0icIg@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: b859ebedd1e730bbda69142fca87af4e712649a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7e19defa57580d679bf0d03f8a34933008a7930
Message-Id: <164685998107.18291.1953249183991023055.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Mar 2022 21:06:21 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Mar 2022 19:04:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7e19defa57580d679bf0d03f8a34933008a7930

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
