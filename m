Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3594F0C81
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376455AbiDCUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbiDCUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA033884
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F0EFB80D9E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182E0C340F0;
        Sun,  3 Apr 2022 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017795;
        bh=X+YipOC4djr1WC3mQUko9z9VG1qrdrcKvPLWWWHZ5Zg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qqMc+px+pX3kfFCvNAh3nqfCI19v0wXIaIpVgrid+CCewVPXxk0sfOdCADN25b0EP
         Tf/8rCICX+xNcJZP0u6tPveZtyakbQcO15e5rCwVFx9OUET5FJl2wkMM0LXSkFcjhT
         Jxyrkx6x0n3vEo/V6SfJvJ93zTaShU97IVOsYzO8wrM+qxMetnDpx18IDJ9OOEGt9v
         brVj+kNEEkSd7+TmJuF+AHLwNWrr0aJFyas1ohB+2lNEPFBFVMZrsTOJUh9TYLXSlS
         EcMxitYdjWfoHZUW132TuYaWiM6c9CqW5MsB1c9GxpP3iziBjA1655ZBTH19By2eMQ
         OHB0VOaz/b5yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03894E7BB0B;
        Sun,  3 Apr 2022 20:29:55 +0000 (UTC)
Subject: Re: [GIT PULL] second round of dma-mapping updates for Linux 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkmRl8McdwST4cII@infradead.org>
References: <YkmRl8McdwST4cII@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YkmRl8McdwST4cII@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-1
X-PR-Tracked-Commit-Id: 4fe87e818ea492ade079cc01a31d088e445f8539
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63d12cc30574eec9241932cefa17a21df3afd8d0
Message-Id: <164901779500.22329.10916440707320962926.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:29:55 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Apr 2022 14:22:47 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63d12cc30574eec9241932cefa17a21df3afd8d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
