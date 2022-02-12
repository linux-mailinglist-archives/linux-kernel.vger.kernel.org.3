Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F44B36C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiBLRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:17:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiBLRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:17:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D3240A4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 09:17:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC7361134
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 17:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AAD6C340ED;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644686232;
        bh=K9FxhrDSiUEfPIdtyrZQqRS7/xd1SjAvYu9qrqtjRFM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IwQPEdhOPywW3Jsg6ZA196lwmukcmkusvnsvjebABmWwagXViKLE5j71nVcECbJjH
         7kPKWGUlGawJbySO2qemnX8zHyBVK0THD/NjyUeDjq6w5wagB4xdHjTALUxIWKpM5t
         erKG2HG9gx2YQghwcJz4zfm9WmWiaArk+9CTUHSSjZ8NeJ0u7x4zO0BPzgX/Tj0nYO
         /gYlYz3oq/Bhf7+YsB4Z8aBTdeOoV4Ul8E5tPtYzAZYMh/LfppOxqpz943hNFulzfn
         sPP6QBYnX4da6ykk9Vb2XU1YLFC2Eh9skY5Kv1hVAA6qk3Z/6LAfLjEBKHQMGA14SA
         cxZ0spG0HWoWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75161E6BB38;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220212102509.24629-1-jgross@suse.com>
References: <20220212102509.24629-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220212102509.24629-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc4-tag
X-PR-Tracked-Commit-Id: f66edf684edcb85c1db0b0aa8cf1a9392ba68a9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a387c98b3abc7cf9a2281f01f9b4dd7dbc48f65
Message-Id: <164468623247.20961.11131810270936389812.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 17:17:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:25:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a387c98b3abc7cf9a2281f01f9b4dd7dbc48f65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
