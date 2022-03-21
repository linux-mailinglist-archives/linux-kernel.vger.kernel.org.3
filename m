Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57A4E30AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352594AbiCUTUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352718AbiCUTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2C546AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FD6060B91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF2EC36AE5;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890313;
        bh=ozT64UU+dq3UbC82JrDwGmrJiqVEiSyJ1sgGgEN9Rp8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qKgHWmUUYSsHAHoyBTtatGgV+qdioG8AAVYT7b27Wr3WHIR1con17gp13kDgFMDPZ
         DwJo+PnlHgdTVPF7lMp2Ven7jDFsnYburkTLJ1n5mFT404lVjdCtIPKSYWiP6WpQy+
         ori4PF7CTwR7ar0RHO3Q8BI0S6RxMtS+uNMqZKYPMBaM7H/NKRbFZwVFK3vrUWCt3C
         CaFlQU0wyW+YC5hx3QoatAByd+5VqL8Cb3xKoaVLI5rpnIVE1GkKRjLo1vHoLOXcPS
         MFfQpZsVNNho0Ju2PpTo7N7BJsZJCsNKsq3NdBWekPAZTdPYCxmN9RiWDc23/Xu2As
         5y33LIrAsHctQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69DC9E6D44B;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220314220726.GA5585@willie-the-truck>
References: <20220314220726.GA5585@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220314220726.GA5585@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 641d804157294d9b19bdfe6a2cdbd5d25939a048
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 356a1adca8774df407e8b6d3929e36da90679c0d
Message-Id: <164789031343.24158.14971194278227199499.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:33 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, maz@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Mar 2022 22:07:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/356a1adca8774df407e8b6d3929e36da90679c0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
