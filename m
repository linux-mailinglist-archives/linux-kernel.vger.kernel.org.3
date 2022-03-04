Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF84CDE61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiCDUXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiCDUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70028151696
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:22:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA5E61976
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D2BC340F4;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=drtAVc9iu/9kuWtQa9BBtKt9Vne7cc+zjPAYGhDvYRc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uGKvNQs0VgiBauASMTlKebGz0/T77FYskLsJd9PIc3AQTjAn0+IRmu7FI0WzlNJSj
         AF85MecRPTf9uaIQnmbLbutx/18VNOz9pJNhiqLUvohNexwNQMq4Rd7n7SRDYdrUGI
         OTgYfcnGJUuHxQBIn7+Gp3K3zdX2Ir3UHDIBzBlJ+jnqqGpme2hBwmO59SF4ZhQsO0
         QIQLJLhMA85e8FdecyjGMgHQj3rO5h2/kUeE/BI1Lf9INNk58c/ZgELG5+gaypmfzf
         Wtdl0ytHaLtfWoWz7nwMqR5RmCLs/VefdVYHM/XQWI/UqzxXx8zaouCEpUCu2RxZvq
         TkuYLFgE3iVFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B9FE6D4BB;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YiIxynRjN0sRPIju@8bytes.org>
References: <YiIxynRjN0sRPIju@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YiIxynRjN0sRPIju@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc6
X-PR-Tracked-Commit-Id: 9826e393e4a8c3df474e7f9eacd3087266f74005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f509f5971bca38eeb543186131fb1b404262023
Message-Id: <164642532139.24805.4276557423762311140.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:01 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Mar 2022 16:35:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f509f5971bca38eeb543186131fb1b404262023

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
