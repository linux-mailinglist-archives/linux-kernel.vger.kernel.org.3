Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C425550CD78
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiDWVDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiDWVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72E11C27;
        Sat, 23 Apr 2022 14:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AA0FB80D6E;
        Sat, 23 Apr 2022 21:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E09DEC385A5;
        Sat, 23 Apr 2022 21:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650747634;
        bh=lCsCxJ5tsHMMjUwdTFCcCyezQNe4SyYCuH4K9jkPh0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hRJmx7DpZQeNLqaDOronaItxUiEdCC7pT+XJSm8kEeV1Nf2GtATJFF2OOv3I138bX
         M7bEivk9CZkZ1OMbHR8eWerp+tmkQ/GQebuhaom59bshEKBmGiPaKDL8xzAgmMG9AW
         kpL6+1sotmKaBA9xuDjTqz/DXy0npAyfkznAzSWEViZn9GTfWanG0xK1jD3rRjxExK
         5BJN4AE4JH6b4GKIDhjAuYbcyT9SbwNkdTyJOr3lDlDpcox8GNtNxNcwxcrUzWaGW6
         DNcRg5Cb7qY5R4yq2mcaGrJF8LjdHSiRq6wEcjoCBMI7LQETkJcy+QzLG4HqB03a1c
         I9o+1QH/wjpUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD74EE7399D;
        Sat, 23 Apr 2022 21:00:34 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a661ff2bab4959b2b9759c537e3c1e5c1b7ce3a9.camel@HansenPartnership.com>
References: <a661ff2bab4959b2b9759c537e3c1e5c1b7ce3a9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a661ff2bab4959b2b9759c537e3c1e5c1b7ce3a9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: faad6cebded8e0fd902b672f220449b93db479eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fc2586d23b574fcd3f6b14430277e91d27cf585
Message-Id: <165074763483.21099.18260513095575237698.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 21:00:34 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 15:19:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fc2586d23b574fcd3f6b14430277e91d27cf585

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
