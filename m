Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE2586FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiHARvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiHARvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:51:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FA913DC2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B1CB8160F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF64BC433C1;
        Mon,  1 Aug 2022 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376278;
        bh=nfO/rwO4u8+KZLw6cw3dPQOKlYAgpkQ8+880ETNmLxU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ddhdZ2Ed5qf0cT20cu0FEBSvntZNj0DG70y3YtoQAcAJxB3V3kmSqMVdTVoqV4NOJ
         qnEghwK+sBQUT1J1mKl9mgb5UdyMsgePUJWJiz75GXSaee/7Lsfv8hBVWP9xVoHkTT
         hU2WLXXECDSh9y8qVC8uU/CvBFhEyHOq7Qrytyk4SE2kS0FP05fXryhjp72LDP61MJ
         oPKTRPmSwm1DksKk0czgcumBTNeKqG6U53tYliqREzBcLsMJbDHUdfj0b8R4e0Ol16
         mmwJT0rGfGz2dezMDKprHGG2tSpCzHvaL2D5X0+UmtUEMuplp5/TrYlekFeYfZnr13
         SvColWw2dZeZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E2B0C43142;
        Mon,  1 Aug 2022 17:51:18 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220729102205.GA24050@willie-the-truck>
References: <20220729102205.GA24050@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220729102205.GA24050@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 892f7237b3ffb090f1b1f1e55fe7c50664405aed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cec3f24a7cedc726f8790d693aaff2c535dc4ce
Message-Id: <165937627864.8149.14966502346282875308.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:51:18 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, maz@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 11:22:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cec3f24a7cedc726f8790d693aaff2c535dc4ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
