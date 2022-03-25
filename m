Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEB4E6CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358154AbiCYC4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbiCYC4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2252E6A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB88B6192B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 124BEC340EC;
        Fri, 25 Mar 2022 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648176885;
        bh=aB8ixEDccysOkhO3MI3u1uG75P52wt124Z7/JgpBN2c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KYODxL2KbHbHE5eC/DO1/ixJj0ldVNQAfPNunv1tikIki09b0yieE3r9+PE60xQAi
         yWisRtxQyS3gZQUxPMEaD86xUPiR5APGUl4R8h70DAL5ypXSa4vogOrBWVX+xYdac9
         A6rrOV4Jkp4KP4VtJ/EDOIvnzu79Siz1wi3wd+mrDmzWHNFNs8SLzhzocyyNYYEt0M
         TUe0grLRsccqU/gJz04At7CIKv9CSWNAXRBrxmfdC88VuMWhSpAZhTCzKE9QzJRkEc
         TRA6REY+FZPmbQ88MiUMwrktuYouW5e3j7gC3BvSSpqZFF4S4T+kfvSR2wvc8kk2tE
         l9/K5U2Zu407g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F284EE7BB0B;
        Fri, 25 Mar 2022 02:54:44 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjxCJKNbtfcyV/6A@8bytes.org>
References: <YjxCJKNbtfcyV/6A@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjxCJKNbtfcyV/6A@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.18
X-PR-Tracked-Commit-Id: e17c6debd4b2d2d474074f83946f8c6522587566
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34af78c4e616c359ed428d79fe4758a35d2c5473
Message-Id: <164817688498.22503.13146962183170452786.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 02:54:44 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 11:04:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34af78c4e616c359ed428d79fe4758a35d2c5473

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
