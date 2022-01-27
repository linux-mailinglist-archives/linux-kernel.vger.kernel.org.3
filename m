Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA549DE52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiA0Joh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiA0Jod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EAC061714;
        Thu, 27 Jan 2022 01:44:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63AED6171F;
        Thu, 27 Jan 2022 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB5D6C340E6;
        Thu, 27 Jan 2022 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643276671;
        bh=Ffzck3eFl4mkVuJsdP0IVa5GHoXlurx5/oGYPyox2k0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CedC0SvwhUF5c8Z+NSd4jcZUTc+p7RQimKuCyf90JjBzz7bN/eLQPbP1WxsZVqILw
         gcnzsWNvbGd7cc8UMGprQicurmn7ZIwAYuy2m1wDQeHxd5cTFeqGWj7e5HYQQ0oYXN
         MgbFaewc/KCFqPHNQf7FK3cE6yItI6Xg39Alvdo9djc9bmeltATIXU6lDcqotnqv9e
         gF3x+cH0nuTiScp20W2LqvAZH5KTZtVDaWPQyQHTb0xwiLvOonD5uP32Ajak3+g5BT
         Ap2xtdVEzjvMG7nDsZdTTmuW5tZBWwHCVIz7bj5eC/ho3qHH2RmtRD7fnqNUVryXHx
         2CMlGKE0pGYfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA0BDF6079C;
        Thu, 27 Jan 2022 09:44:31 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg fixes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220126154233.2453010-1-bjorn.andersson@linaro.org>
References: <20220126154233.2453010-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220126154233.2453010-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.17-fixes
X-PR-Tracked-Commit-Id: 7a534ae89e34e9b51acb5a63dd0f88308178b46a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 626b2dda7651a7c766108db4cdc0825db05b980d
Message-Id: <164327667175.12060.2197137780478914338.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jan 2022 09:44:31 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Sujit Kautkar <sujitka@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jan 2022 09:42:33 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.17-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/626b2dda7651a7c766108db4cdc0825db05b980d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
