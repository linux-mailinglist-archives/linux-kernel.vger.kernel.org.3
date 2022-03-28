Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE24EA2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiC1WPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiC1WPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115063AE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA3EAB8125B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74097C3410F;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648505172;
        bh=XPPLDpYNlt8dKOL5TwrQ2XculpqIDVJykQMIREwBDm8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XwRVPd+D2bq4PVeclA4JulSC0cyBL9rR6cJROaYqpm0sVbugzb3w3dfWfmuWZb8gz
         4Uu7Ur9PWQCUp9z1BlO/gf5K+XJu8KNHOkVcrmfsJOX4WDOIJGtCwnHZAXh8DnOt9W
         XUFxOldZBXIsTg3N+zg9J7T6frOQ2co4DN5KaJWtWvUe8vJGLcq/OSdKipLqO2hcIO
         BzljP5Y+Edwu+WlaQfgAI4rOzB6nEDLpb6VBKHkYYT71MbpRBQsdfH4b7vY3QhrbXr
         bgS5W8F0MuYIHL8EtT3vl2png7R3EGWSpZpXcoZyuX1MCx0GzWfZ6zjiEA/1kgB7W8
         /bTiM7PukB+MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62385E7BB0B;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <04dd8f40-84eb-2c31-5b16-33ac60024b7f@monstr.eu>
References: <04dd8f40-84eb-2c31-5b16-33ac60024b7f@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <04dd8f40-84eb-2c31-5b16-33ac60024b7f@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.18
X-PR-Tracked-Commit-Id: fcc619621df50f63b641b18536f908b05d6782a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b83d85a5c81c1f8227dc54636c779d3f20a4d731
Message-Id: <164850517239.27348.1422241454610976277.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 22:06:12 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 14:10:56 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b83d85a5c81c1f8227dc54636c779d3f20a4d731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
