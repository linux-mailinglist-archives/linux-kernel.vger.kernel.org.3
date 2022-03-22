Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151B94E49A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiCVX3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiCVX2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2795532EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC8461257
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4E32C340F3;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647991646;
        bh=jUvjiBYfjo9YoY4E/pz8w1ZRzXEzON98B5x9f3F5Ot4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ltwUfpjqQaFyhm7V1W6BwmlwHVfu9OxjQNx2dLXRJkUv74Vc6eUYJJ7Mi6Fk4p1nC
         1xlA/O2z1CeUujZZ8KfCf7cRwHcR94Ao1azZA7qpAqBStecSTLHt8kVnOb6y/d9/7j
         DuyYx8HWM1PRAWEmBocnsiRTwNfdRs8clIVbuIPtv94Mjf5DMaFMJeryEQlnGDKHyy
         qsDV5sjuKAoVRFx09xWxlU08LyBMU8LTDY5DoRzEKysRVHfvM3XfTBgCkMphSBwQS0
         x54CopTjjTFVgNXRwK74fsSKRTUufifXbBujAAU0cxznXTEbLzOiJPQvRx29/5nXDi
         A/flzPqNAiUbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0584EAC081;
        Tue, 22 Mar 2022 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] perf events changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhaieorORDCnPvh@gmail.com>
References: <YjhaieorORDCnPvh@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhaieorORDCnPvh@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-03-21
X-PR-Tracked-Commit-Id: 02a08d78f5c429c7dc8e5b9417b4efb518b3d041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95ab0e87683edb6766e4992725aac13aca788ec6
Message-Id: <164799164671.11565.7258392251498432451.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 23:27:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:59:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95ab0e87683edb6766e4992725aac13aca788ec6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
