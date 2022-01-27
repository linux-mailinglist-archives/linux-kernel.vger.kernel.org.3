Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70F49DE53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiA0Joj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiA0Joe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D074C06173B;
        Thu, 27 Jan 2022 01:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C96D7B821DA;
        Thu, 27 Jan 2022 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E369C340E4;
        Thu, 27 Jan 2022 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643276671;
        bh=RXEsT/TNSI0YRT/K7OBfZFxQTo6yxVDpNmkaRkPIeos=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=keIotsb8i4cGxwjMruX4luKTxfIfN2p8eQHS3dTCA+Z2rLXYwlEG0w3d2b0+poIX0
         chmkGCyIR0JMe+K1WStwb19tAZ0ADuqAYcKqG+73QMXvuxNDlZAxtt5SjBDOd5YGIg
         arCZg+yz2DxYPjOVS0mpQVBwmaGOCSKfKnntfxw+Kw9LpRTAgLzbSuc+NlIi/DcnOi
         AO98bqS6OSyy4S0t3G1Of0YB5ZfhPuzIRTeJMW2OiDSe693DvrxFgiL+XUgfQo5bEJ
         6HiPym4/LBB9f2uI5ryIx1JXQsIJpppJhCJFjlV9FTIDGFwcrM+lIpMOQKdVAs2HIU
         c8ZUBIXpqtcFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CC15E5D07E;
        Thu, 27 Jan 2022 09:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc fixes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220126154212.2452904-1-bjorn.andersson@linaro.org>
References: <20220126154212.2452904-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220126154212.2452904-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.17-fixes
X-PR-Tracked-Commit-Id: eee412e968f7b950564880bc6a7a9f00f49034da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96b5590a486106206f2dab7b28555b5b1a8751c5
Message-Id: <164327667156.12060.12779897027812295058.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jan 2022 09:44:31 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jan 2022 09:42:12 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.17-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96b5590a486106206f2dab7b28555b5b1a8751c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
