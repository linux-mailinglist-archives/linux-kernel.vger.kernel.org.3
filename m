Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18C538741
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiE3S2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiE3S2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848E59089;
        Mon, 30 May 2022 11:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03DE460AFB;
        Mon, 30 May 2022 18:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BC44C385B8;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653935303;
        bh=JmUf2/MjiGdTyYlimB3p5TQ3BXKEJ10GBR8WKJ12xSE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P5e1mFEiDH5rYfoehOanPcEBp31xtpGmMhmh3Ioget2iU79Kvto0oMbgrpqtdelfU
         IYtGIlheNiKf8HRHABjbsBwUr5V9K7I9g6ap3x0c6BqP3i6jvNhyLpRHARdw1Ja3gX
         5NiR6x2JI5a3Ho9tTnZeJJiDrFP1Icxtvw0362+AOkUZfyXM1vEreQM0+7fOgfHjrd
         uceue2qTEmR5CZnKGGtU0BwaIJeG11k8R64os2NfmKAFn2jptK4xI84zBP0g2inoLm
         pxRB/e5JG3PDxfyVIlfaRLwShmkK8u4672yShf6HXDb6AWen8PbmdxHGjH8WnNruNx
         bwNa3PBWIz/5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51471F0383D;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <707bdfb5-a6d5-df4b-4b47-735bde4ec8fd@linux-m68k.org>
References: <707bdfb5-a6d5-df4b-4b47-735bde4ec8fd@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <707bdfb5-a6d5-df4b-4b47-735bde4ec8fd@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.19
X-PR-Tracked-Commit-Id: 6b8be804ff376f6657ccdf6b29974e7c793d88c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d2da475ac0eebfbf40e5c5ca8c0409d62d23424
Message-Id: <165393530332.32021.4768153658173767437.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:28:23 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 May 2022 14:57:24 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d2da475ac0eebfbf40e5c5ca8c0409d62d23424

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
