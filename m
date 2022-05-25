Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75545334A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiEYBQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiEYBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:16:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F182608;
        Tue, 24 May 2022 18:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC7DB81C06;
        Wed, 25 May 2022 01:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81C9C36AE5;
        Wed, 25 May 2022 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653441389;
        bh=kOB+AZXNYvdw1fPN23hnFzDmtNYh2PxjJAy8kFCF9kc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jGqEOoC/tZ8zC/B20qPlG6FbDz8FKDaDADoEM+3JDJN7gQiJStxD/U5/U/ZM+9avR
         2IcCtZ0bV+jacWTht8vYcGgnr1wskPWl9okeY7Onjo5hFKN0n8+RBM60IS2jhjrsi4
         3AN3JovzDV2bBk/+CUG7z1r+Z6rPMhO8/9R+h4O8PnWCZGeF3dakQfL/FU7FXkRokr
         DdNjLdw1KQtH4CVl4tflZPev7stljr/Np8TLb1WHgw52vyZNAGNiUt/IEPCTsHC7Mr
         qUvVpxtyqCPU9Lc/23KkOjtg5zOCeKOYob6+VKcEpRLsPA1L8DYXpvMBZ+M8Vft9gL
         x2Ddx0sRWNNCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB39CE8DD61;
        Wed, 25 May 2022 01:16:29 +0000 (UTC)
Subject: Re: [GIT PULL for v5.19-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523091255.058e306d@coco.lan>
References: <20220523091255.058e306d@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523091255.058e306d@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.19-1
X-PR-Tracked-Commit-Id: 340ce50f75a6bdfe6d1850ca49ef37a8e2765dd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 827060261cf3c7b79ee7185d5aa61c851beb9403
Message-Id: <165344138975.23610.13766209463283800364.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 01:16:29 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 09:12:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/827060261cf3c7b79ee7185d5aa61c851beb9403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
