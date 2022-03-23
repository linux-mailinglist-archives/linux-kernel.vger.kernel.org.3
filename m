Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09CD4E5BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346006AbiCWXj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346793AbiCWXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7D6E781;
        Wed, 23 Mar 2022 16:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE9856184D;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F313C340E9;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078580;
        bh=7K9FJdSlVd6h8HdN99KHbIy2DMjwhOMF3qRQpBjx5yQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n3i8SfvfYAinnG7jC48DSCzeNNKcjBgWDj7v9j6q37nMn05X+X8rrq8tdc88k133d
         NKCMi8dEUwmB0x3aILnrM6RY+uEB5txgqRyQG37AhxsTJ39q06DjnQVWXtlddljp8g
         +ZbGgiM13ARyREOX/TrLxk89i+1DgNTC4aogRU4tfYC5GA/WuH1S3sOkpBweX7ZE/Z
         ctCT7N8dKwKGznCRkmr/CiDsxLG8/bBnR+jEL1rLx4q3+mR3u3oqUAUezRPlRpItJQ
         R4OZ50ACQMFyNT8EVgtMnnQSe63EvTiMmXCktsryM3LWKrHb+FtHSC4JO5lF7rCpEY
         evvUynse751DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03AD9E7BB0B;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
Subject: Re: [GIT PULL for v5.18-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322101406.459e2950@coco.lan>
References: <20220322101406.459e2950@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322101406.459e2950@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-1
X-PR-Tracked-Commit-Id: ba2c670ae84bad705ec023bfa7a48f7f8eab5e16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 182966e1cd74ec0e326cd376de241803ee79741b
Message-Id: <164807858001.14397.18040680261738090444.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:20 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 10:14:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/182966e1cd74ec0e326cd376de241803ee79741b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
