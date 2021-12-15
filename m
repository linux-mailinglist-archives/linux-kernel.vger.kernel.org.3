Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD6476167
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbhLOTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:15:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59452 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbhLOTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:15:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13229B8205D;
        Wed, 15 Dec 2021 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4EBFC36AE3;
        Wed, 15 Dec 2021 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639595713;
        bh=R/wEC/fi0K+cxq7MlkXIaJr0RFPuM4dAhPJlP7I7/R8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pKFBElKsZtyHpK+qWy4ekRivHGnXz6kaaRzKQezmZwqgtKL8bYKpdSmWATXqB51Zx
         oU46Zw1hSd5AjjTbG+HtXYaw7T+eZ3Z+0AKSE+z9UoVj7Qifyjzz/H1pJTH8Uf7vAq
         Zjvz18luE9FHC3PiydYPOTtNLQi2t90hy6LRDK123MV1kUBlzQaSij65L97PmxKhZ5
         5z4mIyrSMsKtMQjvNXth2WNvKbeJqgSHjG9oYLN9s3aOI1DWFqQOJs24i83gJIKQ2l
         kw8cbELSPkxolV8M62vStftBN92Hdp4pSPfmfSuaQB/u47VY5DfYtvrlfKmpmBAkmh
         DqvzjKSaDVixg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA4D960984;
        Wed, 15 Dec 2021 19:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211215124625.32575-1-idryomov@gmail.com>
References: <20211215124625.32575-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211215124625.32575-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.16-rc6
X-PR-Tracked-Commit-Id: fd84bfdddd169c219c3a637889a8b87f70a072c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b14864acbaaf03d9c01982e243a84632524c3ac
Message-Id: <163959571363.3685.2546987175943161417.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Dec 2021 19:15:13 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Dec 2021 13:46:25 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b14864acbaaf03d9c01982e243a84632524c3ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
