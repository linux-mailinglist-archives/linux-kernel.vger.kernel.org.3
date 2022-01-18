Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823C2492074
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiARHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbiARHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:41:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D0CC061574;
        Mon, 17 Jan 2022 23:41:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91910B81223;
        Tue, 18 Jan 2022 07:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D35C340E4;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491711;
        bh=VJK5YndyNcJo79YrI3RHQGjym+tKUCwvPuE3w07Fim0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vs8cPw7AWY1UOfNkuPJJzdrWh+mJccSOMHIVQnH9Jn5xTANmkMZw1P0Njq6WQe4XH
         TnYcgLVy1+w3sjLwongpFWF9lqVqZpQ4eXGmVk1zd6Lm/zifWUps4mELenTj43KRmL
         8f3pHa4WLERe8nko7qhb7cjA0qMwhfggv44JRVm26gE6crBTIXWs5kGBDA2jIm3kfa
         VNUI2EAyNZcl+V0ydJ5YzwxlJJhmdiFwJfA7DMnF7hgybbIoMDf/85lhqsMQuwitcg
         0XIiRVpSGf5qUITyveuDLkNoCJsQrWeCAfheqXttwPkT5SP+wxUdWoMWZYkMBLFVjL
         +Jj+5Rnb0m05w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43E5AF60797;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220117220204.1694313-1-bjorn.andersson@linaro.org>
References: <20220117220204.1694313-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220117220204.1694313-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.17
X-PR-Tracked-Commit-Id: 8066c615cb69b7da8a94f59379847b037b3a5e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc9d6952a4bbb9908062726fbfb009fa6ea5c7af
Message-Id: <164249171127.10229.9673806362615091996.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 07:41:51 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 16:02:04 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc9d6952a4bbb9908062726fbfb009fa6ea5c7af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
