Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F9F576654
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiGORqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiGORpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B85F2F642
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF85F622D5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6184AC36AEF;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907134;
        bh=upDQS3vqXsVzxg+tNckdGACur/G8xxuSK67U6Jd7Iq0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O1ap3U8X5XGojDmbf0JSsjtmMNbjIYIOdG6tjkoOH0/emJC9ieL5VciXlS3DZF9F8
         zRlybQGtcDBoy5xq73HsGYa0z5n/K7+nA/JN0rFru73YH4VgKt3NcPjW8+jDVQP/zo
         yLz82cz9CjeOsnfSll4WOIN4/hTq9Cbf50cUvx6nMyrNpcbuj4XtgOd5ws3GOqglU3
         Hl2PCrii/F2v61/esS4Vx2kwgXszn9z2N1yrPX6eeJOd6H4VCWbXdn4lDRpbM5NCY0
         H+dIpgO/0SJBK2fX2sOeikwzJ3GyeriRmD8CWc8FhaCKkpE/Ik/cUhiig5PeUY+j6X
         WlVPl87GPo1fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4809BE4522F;
        Fri, 15 Jul 2022 17:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220715060019.5197-1-jgross@suse.com>
References: <20220715060019.5197-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220715060019.5197-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc7-tag
X-PR-Tracked-Commit-Id: 166d3863231667c4f64dee72b77d1102cdfad11f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 339f74e38f53c83b5715abd28f7002b66731d917
Message-Id: <165790713429.27298.14101332307075836483.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:34 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 08:00:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/339f74e38f53c83b5715abd28f7002b66731d917

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
