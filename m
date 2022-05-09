Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C615201CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbiEIQDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbiEIQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:03:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3E2D9EF4;
        Mon,  9 May 2022 08:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86D0FB81252;
        Mon,  9 May 2022 15:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 414A4C385AE;
        Mon,  9 May 2022 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111948;
        bh=3WqpGb4b7mV7spWAV8RawQwEEHkl0hO6Vsc2rKASjFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bAeqQ9dtNwYyeWxWYzg5ackhrkGBMhf4bHNoqedbzV/xnilOHN1b/RmTrt9xGjaFp
         dDj3gb4klNyZKJ52zEglFB7ljdxcIbG/ANXaz6SomL0OpB70FiS/aJlDh+y+Ca/xv4
         u+sEw9DZ8veaERabwo70T/YSiLmflolNCDI38VSNl7icGBVp2Qfmq8myNBSHR9jrrW
         xaR9oRYA70YQpJdL1Mp0RxciEXp82d3khiwu7FwXMcN94zfrytyB7/jDI0bgupRqYv
         8i0B1CALTuBBThlQcNgYBL34AIOdNfNbgz5Ics9bNAF3uusUT0nZhS0BbsDziSNtbP
         G2skyMcXhGy4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D392F03928;
        Mon,  9 May 2022 15:59:08 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.18-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d9007c58-71a2-e081-c609-fbf04855b591@redhat.com>
References: <d9007c58-71a2-e081-c609-fbf04855b591@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <d9007c58-71a2-e081-c609-fbf04855b591@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-4
X-PR-Tracked-Commit-Id: 44acfc22c7d055d9c4f8f0974ee28422405b971a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9be9ed2612b5aedb52a2c240edb1630b6b743cb6
Message-Id: <165211194817.13222.583089385536373493.pr-tracker-bot@kernel.org>
Date:   Mon, 09 May 2022 15:59:08 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 May 2022 09:27:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9be9ed2612b5aedb52a2c240edb1630b6b743cb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
