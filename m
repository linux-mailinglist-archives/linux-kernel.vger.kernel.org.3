Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C955A1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiFXThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiFXThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE481D9F;
        Fri, 24 Jun 2022 12:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 374A1B82C0B;
        Fri, 24 Jun 2022 19:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9298C3411C;
        Fri, 24 Jun 2022 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656099430;
        bh=DJny9jY5uYafRIk0V6dO2proepeYJQf4aH2nj9dG6PA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JHZBCy1x5raWA4Y/SaB8kula8LK5nvzNeH3nG0z3TsM824GR6GBn/CZWl2d/W6Ucx
         DJ+qQUXHUqwNlvIPWzwbVkNUtB5ygHB4L2FQd68B2ryV2eJam/Ul0fBPOu7/nMOkGl
         45v80Tq35jafQwoKC8bW4XHoRfvnrYVmvDugwka5GY8LWxmtphCvsjIOR0BDXNcTnF
         WbE1Gwcaver4AR9k7Si6/rIetSra7M0oH0n+3UElX/brrKIcuLkCzkpJoWGKCFb4hF
         mAT+l3sxroXpcPcwreLxhzzxOyg0borqEHVbaMfWYM1zlVTwNO8Fjto4DjglMJUZqg
         YqY15NtU9Okbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D54CBE85C6D;
        Fri, 24 Jun 2022 19:37:10 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrWdUgyjZL10zE2Q@tuxmaker.boeblingen.de.ibm.com>
References: <YrWdUgyjZL10zE2Q@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrWdUgyjZL10zE2Q@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-4
X-PR-Tracked-Commit-Id: 21e876448792af2dd5261338907c72bdf37fa056
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6e9d01468087e41c0905a60bba6a451882dd3b8
Message-Id: <165609943086.3020.16671491898847181676.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 19:37:10 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 13:17:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6e9d01468087e41c0905a60bba6a451882dd3b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
