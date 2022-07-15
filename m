Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB31576656
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGORq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiGORpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C12F3BF;
        Fri, 15 Jul 2022 10:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 192FECE3081;
        Fri, 15 Jul 2022 17:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86427C36AF3;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907134;
        bh=FKwuPmbifdJp05q/AXewulk5IWiHNM6MudgMXbvD4BY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dkvu4gOZe5ozMAQBkRfmq243/9LI/A6UgVaHCiC1uhdPquTaN1a7CrNC2XX3j/rRe
         TQIQ33CoBIaQvx5eirRR9UhnfAe8/rP5kcdlSGBd56rww4xho4W2dUb7uOyKsXG2qL
         daTovYbH9o89xjz3fvCwWnxO782tFMM0HNqCtIYb3IDMEoBCBiIWYv98L06gQHsBDc
         BoZMQbgAZv4wJ5L2DGEl4+ZuEn2+aFv0hj+iQPBqs7CP8KuZORmZRp6FBBOtrBD0yt
         LeTqNtyslUpZcZVsGpuiutsgp/dFcLmYJun0ubSeSxyfMXPBe9ekc5iFBusae16FJQ
         IddwhROLRECJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F3B1E45230;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fc307e0b-2b4d-165d-230d-8c5cddf64dd4@redhat.com>
References: <fc307e0b-2b4d-165d-230d-8c5cddf64dd4@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc307e0b-2b4d-165d-230d-8c5cddf64dd4@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-4
X-PR-Tracked-Commit-Id: 5ad26161a371e4aa2d2553286f0cac580987a493
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a347a06ebb1b186a5cb919c9f5ab6e040554be7
Message-Id: <165790713444.27298.509695428095453831.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:34 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 13:24:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a347a06ebb1b186a5cb919c9f5ab6e040554be7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
