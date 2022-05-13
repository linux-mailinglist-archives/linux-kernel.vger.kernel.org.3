Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C335526882
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383055AbiEMRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383057AbiEMRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:30:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63F712D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0EBCB8311C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94B39C34113;
        Fri, 13 May 2022 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652463000;
        bh=NXH9v48sLmkaQQ47kOchYJr7b+1f2KNdj64uZXUYoU0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=of4wf876HavJB+7H9PVQElh4rd1mHqRhf5riCQ0BG8Sg2Kyh/8itL4VQKDWC0HIKs
         W42l+6Fj71EDkw2OWCoW8J0fjr+lw15P3Tt4RLhe0gQ/etJaF73/cng2ax2PhQPWf7
         LCrqaYam/YJNG+oiKetFefUoHprp6rxz+39V1NLAmvTypw2VV7/JIxZvuJVIT96soj
         kLxMQOZJEFhz4oOU815kkXsN5BFCPJ/QF89tLXVro2S6gW+gW3i58jYLaDQWYUq2fh
         Kpx7ub3ckdi/2qxxjlPUt3zTKj+9KZoxgJ+KJm7wZPtX4sDMtVbDypHk5AsIyVWL44
         1j/dFYVgjjs/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F7E6E8DBDA;
        Fri, 13 May 2022 17:30:00 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220513165233.GA32168@willie-the-truck>
References: <20220513165233.GA32168@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220513165233.GA32168@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 51f559d66527e238f9a5f82027bff499784d4eac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91bdba8536b87b25adbbf79ab9dc661840bccc4a
Message-Id: <165246300051.14811.9008613779888711718.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 17:30:00 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 17:52:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91bdba8536b87b25adbbf79ab9dc661840bccc4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
