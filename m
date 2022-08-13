Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A02591CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiHMVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiHMVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98001252B5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D7DB60DC5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 21:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1ECC4347C;
        Sat, 13 Aug 2022 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660427286;
        bh=loKMlfzRt4o3HnwPVSZ5in4GmUivDV+CrE9quqJTiQw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AhvFk/tq9kQob//WQ8C0K1tScaXir9Nb0G5Q3zltZk7ieAYSR/ISU17fJAu0qAQxk
         Q5nM8/5nfNnXHgM3frzqbgFr0Zjy8l/iPNcp60lBefNwHw4ahmFTp80SXApwGraBZv
         w/iligKL+5WGS1DHE6zsIEyF8jBVVWL6pPeSwZHwwuwhjDaC+CUzBfb60iSBjSVkf5
         76o137Y6gebcfV3+1gw5vvc1TrZczH2+D+xCYW4kkV4r6anGJGcNX0HoGFHMg0IemI
         8qwOBxX9IFEFeFSP8eMySair3io3dblt+rF9treL6K/HtnRTpl3SeB/UlCxoIDrNWE
         21U6nBrpp34SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D258C43141;
        Sat, 13 Aug 2022 21:48:06 +0000 (UTC)
Subject: Re: [GIT PULL] NTB patches for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvcedivdOTR1dsik@athena.kudzu.us>
References: <YvcedivdOTR1dsik@athena.kudzu.us>
X-PR-Tracked-List-Id: <ntb.lists.linux.dev>
X-PR-Tracked-Message-Id: <YvcedivdOTR1dsik@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-5.20
X-PR-Tracked-Commit-Id: e4fe2a2fc423cb51bfd36c14f95f3ca1d279ca92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a976835fdb312590ee5c085567a4e2b06da7ac33
Message-Id: <166042728650.29926.15227519255426738757.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 21:48:06 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 23:45:58 -0400:

> https://github.com/jonmason/ntb tags/ntb-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a976835fdb312590ee5c085567a4e2b06da7ac33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
