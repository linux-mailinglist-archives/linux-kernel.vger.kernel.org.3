Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C04E5BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiCWXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbiCWXhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFA70047
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D5E61840
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2679C340E8;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078580;
        bh=DxN5U1tmtUukyd6kbiD0mNyqry3B4UWJPifei+LekK0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F+dGpKYYkgTFToWhA7LRbJfvMC++1+YqordTO/Rf4qaUl/0oFHSGZ2022FsKgHoN0
         dBd76DWRwp6Jgt2yT56igHbqIDC0QRj4LKhmo5eWYcTIHWylCsubNdYk5ACgvU2QQn
         XwbAqvRN4WLNDTYTpt2l0jR8ME5y211Vt2V53MgHAEcs+K2oacCbAl7CvaMOHzInMh
         7yl3tK29LgxJ5Zh4u7hgmLqQ0NpfsfGWjiA05ASfiyMOJ5fl/kgpyUChIsq/7Lzm+U
         OTgwZUQGkGvKgZuaBc34Iv+rIgcnCBcSI/2zl2Koiqb/YsZlHOK7unSg2DA1MnHktn
         tllsljL+L6+5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0763E7BB0B;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hfsn8tyll.wl-tiwai@suse.de>
References: <s5hfsn8tyll.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hfsn8tyll.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc1
X-PR-Tracked-Commit-Id: ef248d9bd616b04df8be25539a4dc5db4b6c56f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40037e4f8b2f7d33b8d266f139bf345962c48d46
Message-Id: <164807858071.14397.13735784189226560658.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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

The pull request you sent on Wed, 23 Mar 2022 17:36:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40037e4f8b2f7d33b8d266f139bf345962c48d46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
