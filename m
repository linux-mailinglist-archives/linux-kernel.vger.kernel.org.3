Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583758B79A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiHFSUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiHFSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FCAE0A2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B76A761161
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22E02C43144;
        Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809979;
        bh=cWq9xheP+7KOe7HUe2ZItiz2GrkvlBi+Ja9/8eTJd0w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j7pDPHUyROka3EugCp+N8WdcYmwqwLKyJemxQ3K8CKIysM4hGj9CgDPScAUEj/1gD
         yek0Q7HKjTeM2gSdPbowlOSzxt8pWQQKtbwAisQFi6zApGAyNWUh/2w8HOH964wv++
         Jz5suuoGCqB3U1thVwqjWDxd34AzuFJa/P16dvOSDlf8G/TCb3Zp2BSkQDAlO3xLGC
         XZLw84VL5JoX/affGiuqhb+1bxiJZ01b0fnll4BdDcCNPXHdQaL7qHnOHb5UUMd0/X
         /jgymjwXmxOQN1guMrKKUVhqn5RHrhHZFnjLznftP8sHX1z9fHwgmYyQF4Qa74BpuX
         SF3zVwrYKHQiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13BE2C43140;
        Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for the kernel formetly known as 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu4iZzP92/f/lNEx@infradead.org>
References: <Yu4iZzP92/f/lNEx@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu4iZzP92/f/lNEx@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.20-2022-08-06
X-PR-Tracked-Commit-Id: 5c850d31880e00f063fa2a3746ba212c4bcc510f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c993e07be023acdeec8e84e2e0743c52adb5fc94
Message-Id: <165980997907.27284.2765862935033134982.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:39 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 10:12:23 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.20-2022-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c993e07be023acdeec8e84e2e0743c52adb5fc94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
