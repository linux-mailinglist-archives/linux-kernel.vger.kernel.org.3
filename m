Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C8047E785
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbhLWSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:13:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47990 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLWSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:13:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D86E61F3F;
        Thu, 23 Dec 2021 18:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F50C36AEA;
        Thu, 23 Dec 2021 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640283191;
        bh=i+htNJbk26CF6fX5WfPE4sP4Zoki3X7RJA+OchfK5Rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GQLEOt8ma0rJJ03I6DOoM2KVIa325mp4wFq1ODND5wku1/+lC8Z41Van6iVt98VsV
         vzNYNR+z2qD4ciFQicIeYiD26FVxrfnGQk4SCvjBFeT4ojQpLkK5Pahb/v4Xe3gIN1
         uda4UGuF0FBJDAFDsJMuAdi+ujG7XOq3puptoT1vxrhGXuZeuQeitiXKg0speIlbq9
         2Ekr8YYXr4VR9aIJarUVTMqZQmjKqnK+Kb9DL5lxm/fLTuv69hKNZA0qbJGSqYPKpV
         3wMw4GcShthKBa5x6YtMpiVyVYW05p0V6E7rutZdS5jy6F6RqIc5PJgINnmAFu76pM
         rYO6CcP12XXog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B68E0EAC065;
        Thu, 23 Dec 2021 18:13:11 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211223131726.10956-1-ulf.hansson@linaro.org>
References: <20211223131726.10956-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211223131726.10956-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc5
X-PR-Tracked-Commit-Id: ff31ee0a0f471776f67be5e5275c18d17736fc6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d81b5faa234e92a56df1bc8ef3dacb7d5203efd
Message-Id: <164028319174.29771.17730196775919154719.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Dec 2021 18:13:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 14:17:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d81b5faa234e92a56df1bc8ef3dacb7d5203efd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
