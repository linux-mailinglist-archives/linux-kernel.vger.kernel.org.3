Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C334FEC37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiDMB1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiDMB1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:27:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7D2D1D7;
        Tue, 12 Apr 2022 18:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70737B82010;
        Wed, 13 Apr 2022 01:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C9B2C385A5;
        Wed, 13 Apr 2022 01:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649813087;
        bh=xvkS//h0Dl41XwgUxoLGBwUOPT/oWr4lEtbJpkZ40GI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AqxrSOUbKWE3h8Vw6e5anZS2dzQLXHXe2YltNwmljaKsilN4dNo3UkwUtlqcYj7A5
         bDF7VW02jQr34bqIcZxNFc2SNEYAKJbqQGS6lG5vVbn3dLPn3T9wSX369L3pmEPZSm
         oQyYZl0a7pnsPAM3roM1UPVeOvK/1RnAIIhBQuJ5S+u7ztHqGR0cQmW8Vp6Es4w2dX
         VrqdGvdjHfV9A8hfxE20UrDpXNMZlzn/a24fI4KfUkTQqSwAUkMhH03kpNI5v067Hm
         OqkVVdRlEw19YjAsN9KeMjzFpNk6rHsX7XW41vzCbygNPtfQGKGpf976X+nOhOWKlc
         fVLQZ75hRXrww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 098B0E6D402;
        Wed, 13 Apr 2022 01:24:47 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.18-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <90de8805-387b-70f7-6e9d-ef353d1d3f60@redhat.com>
References: <90de8805-387b-70f7-6e9d-ef353d1d3f60@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <90de8805-387b-70f7-6e9d-ef353d1d3f60@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-2
X-PR-Tracked-Commit-Id: 753ee989f7cf0c0a76a7f56956827a8863a60f97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7281a59ce3a584ed7379bbdcd06a2008c47c3e5c
Message-Id: <164981308703.9925.11874986847530206419.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Apr 2022 01:24:47 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Apr 2022 14:01:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7281a59ce3a584ed7379bbdcd06a2008c47c3e5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
