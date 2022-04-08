Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734AD4F9B08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiDHQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiDHQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9D35275
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61E13B829B2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08C9AC385A1;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649436554;
        bh=9fDbVWN2d02f10S01kpofCopfEgC6rNw91l0eHgtu40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UXWsQPBqMlRVoEiDMGK33BZKXEYA0WitXv3ks+A1sUvBX0cknedEg5wV6QMUXQSUR
         fSQupqcV42/krB3HXULXCAa9X5+7rBdiYnxAAPaa1QdHzsYH32cnr5rJ+7Tc3INpnb
         YqB+Jf/DNjNCKrNckrMKswzF9hDzloGhu7MtVXuxJD4K7zeA2x+VuXhiTRHDZqFztL
         s1DvViq8iiq+CZRnQAWZiqewI/eMu097kGmX3N/dL8p9hV4tL8szHXCDhYx/KIdmJV
         jEuNu9QY2jl9F/9Z2Stc4AVcD5IiKCc3oRS9cB+NyrTmkXILh3fmaRggMVShGSCYZC
         WfOSw8ESUhWKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA18DE6D402;
        Fri,  8 Apr 2022 16:49:13 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlAh5jHAEl/wvb0g@8bytes.org>
References: <YlAh5jHAEl/wvb0g@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlAh5jHAEl/wvb0g@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.18-rc1
X-PR-Tracked-Commit-Id: 71ff461c3f41f6465434b9e980c01782763e7ad8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02994fd2da76b99d3f6777f5b3bdb5d2823a0fed
Message-Id: <164943655395.24432.17355773310620270569.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 16:49:13 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 13:52:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02994fd2da76b99d3f6777f5b3bdb5d2823a0fed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
