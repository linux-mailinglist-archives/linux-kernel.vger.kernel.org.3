Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658F527860
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiEOPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiEOPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:12:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19610FF9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE9A5B80D21
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A421FC34100;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652627460;
        bh=0+v6o4r3OvphyPnnoH8be7X3l7d+awsY5uQw80PILzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J4VRt2VTbnT7YK1/V2at31/ZGmB8DLpUj6SAX0s/rRWWT35xnGhbvRjR1Uzpmu0e1
         6ZnROGsCygkCnJYxectlxf9KsWpHCU7LV1yzkRT10TdPOwK1brbKarJZUpeL7Phj7m
         c32IbIg7j+86wzKBAMJWSeU9x/6UhxYwKGuyE6T+ey8MEsyxiQq8j/WiOZOxeK/dsc
         JRLUiEAzxNAEXxQ1OeLifGYpkisDBLdqj3JGjmujz5kK7uZkN+4FOV+bYibZ5/H4VH
         ods7/8Xl+vpAH4WjTf85mrM+EGvVFdkFhrkrLAn9hFhPU0TUBynTQ3/qpI8kO2T91o
         RfRmfmkOePH0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E44BF03936;
        Sun, 15 May 2022 15:11:00 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoEN35dp8yUoKcDA@kroah.com>
References: <YoEN35dp8yUoKcDA@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoEN35dp8yUoKcDA@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc7
X-PR-Tracked-Commit-Id: 575f00edea0a7117e6a4337800ebf62e2a1d09d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cdd776ec92c0fec768c7079331804d3e52d4b27
Message-Id: <165262746057.2129.15765567081971781458.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 15:11:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 16:27:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cdd776ec92c0fec768c7079331804d3e52d4b27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
