Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E34EB121
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiC2P7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiC2P6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B14D60F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1130561266
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A361C36AE2;
        Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648569430;
        bh=OALu3e4G6DViU7RlcvyUOAUs4LuErpcF4updO83j36I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=stDNkXfYXXTn9ye2hIKKav9UKyb57sgQvl1g6qr+jHcu0J4LZy69mlXJkUQW40tHN
         SfsXNq6Rwdf7lwpPFg7Err47HI4BO3g2BcF03E4y0OZIhrq+gt4qA4RDZRIi90jqKS
         HrE1ncw+wY6OZW0eiJNvMvwp+jpOgdDm25SEbvr3A0buQ0aXT+Eq5hy37ic+rtEUNl
         V3hKs+lvuKiRTbueK+PMMqkCGjgDKyu1iC6W9VpkS9+/leHqn1Kn2CjbG1d1aQ9MOZ
         V9VH3UN+aUQAeAE6/q3J14y2koYUFXI5V7XJCFXPE46yCZWv5P3ozarJtHgSsPp8O2
         yWJGJnfbaYoww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 663CFEAC081;
        Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkMOoNaIpyQf/LKL@infradead.org>
References: <YkMOoNaIpyQf/LKL@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkMOoNaIpyQf/LKL@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18
X-PR-Tracked-Commit-Id: 8ddde07a3d285a0f3cec14924446608320fdc013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ae2a143081fa8fba5042431007b33d9a855b7a2
Message-Id: <164856943041.29048.4286933805151487227.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 15:57:10 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 15:50:24 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ae2a143081fa8fba5042431007b33d9a855b7a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
