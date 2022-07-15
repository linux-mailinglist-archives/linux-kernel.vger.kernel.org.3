Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CD576650
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiGORqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiGORpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5032051;
        Fri, 15 Jul 2022 10:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48566622D1;
        Fri, 15 Jul 2022 17:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0F11C36AE3;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907134;
        bh=sl9S1Nd36uJ6hxsL45EvPqB72+obWxJZbjL9QOBYeYU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XE8ZRH4tjLL/mpvBTbHyhiq7jecaaP+yFC+Lt2h75Q75VzUgt8VYHumAlG6g91dmr
         lwl09R5E2wZlzHUKqorDsCpis212wLZhNYm0Vou5Cqzyunt44j8OaVs8xnSIqRY1P7
         ALddiJQnnCtJYnOjOYURrPbPX2qWMgF2J9hcebs46Z/35FFn+dgEHWXH09xLdIOJhH
         HVjWGjo+WvmJzJQxGzxWmpZKw5YyYneqPmb2jke3ZC6haU0wgVb+e1ityji5Avm/j4
         FaP37xNHJ/xkTmhIMVg5jnJmDnsYm5b1MmEuiY6Tlpl15GJs2nmXZRck4MB2rRQVDt
         EiohudG++A7Vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 950E5E4521F;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220715133200.2A098C34115@smtp.kernel.org>
References: <20220715133200.2A098C34115@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220715133200.2A098C34115@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc4
X-PR-Tracked-Commit-Id: 73d5fe046270281a46344e06bf986c607632f7ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8006112d6c4137bc48ca723261198c63d9e6d38a
Message-Id: <165790713460.27298.2486708565414581628.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 14:31:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8006112d6c4137bc48ca723261198c63d9e6d38a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
