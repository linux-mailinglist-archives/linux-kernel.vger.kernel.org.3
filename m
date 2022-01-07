Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24CF487E50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiAGVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAGVc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5AC061574;
        Fri,  7 Jan 2022 13:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7043762022;
        Fri,  7 Jan 2022 21:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA924C36AE9;
        Fri,  7 Jan 2022 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641591174;
        bh=h2P+GHgFXIHftpuzcCs1zPKBaH5mHwSiCdTvJYfMeF8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XcEhEk+RgFU3FbvGSDCa/mCGI7aTboAd2iBw3+JffLS4eXQ6y6ZrriHtmWT+Wxn9l
         YwpC3h66PFWRWRG27WA5VfL3DxXpE5UR9vtQs/y/hofgiA1uJ6UWmZfAnIN3dI6RDT
         sOe28PBoAmzCqjswis1o3blWYX4vF5EiXbQOmbF39tUOcxm3h+YJv0aUSWMzOZBQ9t
         DYQY7F4H3XJdy3pPaugZaFDlr+D398iboQ0lYMTwWJcVXtK2oa97S+RHidLsPNysii
         cfkp7Wd3IQWQsjwIO/zrFkIVcgePmmujQGcOb2Lmart0tjiqNuKoWxYF/+3fv8EyxK
         XdSTrQlMXFsmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F20F79401;
        Fri,  7 Jan 2022 21:32:54 +0000 (UTC)
Subject: Re: [GIT PULL] md-fixes 20220103
From:   pr-tracker-bot@kernel.org
In-Reply-To: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
References: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <C0F28A74-39F7-4B12-BC8F-96E2FEBE0AD0@fb.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes
X-PR-Tracked-Commit-Id: 46669e8616c649c71c4cfcd712fd3d107e771380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26bc4f019c105234639068703186c01efcabe91e
Message-Id: <164159117482.9111.11078202780818048933.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jan 2022 21:32:54 +0000
To:     Song Liu <songliubraving@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Norbert Warmuth <nwarmuth@t-online.de>,
        Guoqing Jiang <jgq516@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jan 2022 22:28:16 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26bc4f019c105234639068703186c01efcabe91e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
