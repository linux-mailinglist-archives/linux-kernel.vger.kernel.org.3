Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1174A9E74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377291AbiBDR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:58:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38246 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377260AbiBDR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:58:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B5A8B83881;
        Fri,  4 Feb 2022 17:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23A51C340FD;
        Fri,  4 Feb 2022 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643997505;
        bh=Qd1QpO029yfnEIyPKFG+DXXvp4tuXxLyUSA5ZjYqMSc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lLM+rlmOYVdkhetfNpvS61CMU4RFL/qAhuE1Up0orpXCUq8V2CmbHZIchADtLMn1P
         3grnhZlR6yxKLWsQUeXQDeSccFcc6zDamSV+0N3mTbW11eFpQ+BZ74+Q7R9tU+35aM
         oftsblTlsphCebslT9mgmz9wpFHjumxlB8LLWGSn+gPGN5HcwbLpaj9vtpuZ3i/+O6
         u4jYAPxrMTqzMZDdXy4HbwYgb0utXB509+62Klm+TBYG2Y9myGOsr1TvIqfXrVo0wm
         TI0WLYKnd8g2ZOszNVctrF9YHjL6KnPOqVApoJehGFpPn1sS44C0Km4wGUApVwIGjY
         lsGkKgWGhKe0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E90FBC6D4EA;
        Fri,  4 Feb 2022 17:58:24 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204131518.13859-1-idryomov@gmail.com>
References: <20220204131518.13859-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204131518.13859-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc3
X-PR-Tracked-Commit-Id: 038b8d1d1ab1cce11a158d30bf080ff41a2cfd15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cff7f2237c2b494a07c90f70291588d218b77e14
Message-Id: <164399750495.18890.15474672888789225709.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 17:58:24 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Feb 2022 14:15:18 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cff7f2237c2b494a07c90f70291588d218b77e14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
