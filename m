Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76548585508
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiG2Sfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2Sft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:35:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37FC6582D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5328B8280F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5840AC433C1;
        Fri, 29 Jul 2022 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119746;
        bh=OCUgqgq6oA5L1bujpOSEC1Yhdu7BQt0gqGMKaTa9wGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FucbcQEnLccxIc6gHzhEimBOu/fM/tnvM0Jkm1DzWGqyo84zZlDjCEk7gH6eEt8bk
         vNmjoywysvnPYFnGcEOuNGcQL7yAqgByUTQ2q/0t3yivo1yBodOX/mltQKZgHoacKh
         PS6befycMDS+RWvExXN2UhOe0b69+4JMXJhxSE4YFbeBu9VH8ARi+10WMyQJquUf4K
         RBdjUhHFzadu9IjPbayXmxkHXBXeG5H5ulXAifwYAM2FRlaZFmbGnEsSlDVkD/mDo2
         DmyFz6ZeQ0c+P0OlOUAoYDPbpaZda8d2dqlgS+vbDi8wWdLDx3EaenMBU6xGorbfGw
         TYGVaE8eXWtZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46525C43142;
        Fri, 29 Jul 2022 18:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mtcsaxs8.fsf@mpe.ellerman.id.au>
References: <87mtcsaxs8.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mtcsaxs8.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://lore.kernel.org/amd-gfx/20220728203347.2019728-1-Rodrigo.Siqueira@amd.com/ cheers
X-PR-Tracked-Commit-Id: c653c591789b3acfa4bf6ae45d5af4f330e50a91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d928d9b78beec5d4b8afde9c144919b979685f2
Message-Id: <165911974628.994.14000085628404581425.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:46 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        alexander.deucher@amd.com, dan@danny.cz,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 22:49:59 +1000:

> https://lore.kernel.org/amd-gfx/20220728203347.2019728-1-Rodrigo.Siqueira@amd.com/ cheers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d928d9b78beec5d4b8afde9c144919b979685f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
