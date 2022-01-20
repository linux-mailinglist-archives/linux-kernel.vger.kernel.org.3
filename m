Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE19494D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiATL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:59:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37856 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiATL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:59:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5F72B81D51;
        Thu, 20 Jan 2022 11:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54E3CC340E2;
        Thu, 20 Jan 2022 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679952;
        bh=3a6xqGs3N8evBYWEOoEaV+LmETZi3PsZIZoYMvUG1oc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LxiBHTKHf0iqyN0x3eljwldWvH/jvuY4sJcVEPcpg9sFuCPK2cS1lNMPp4zXU2lwZ
         jATpMr892kbxGgNnHNELwBQKUt7uLmEMCJOLH8LU0XB3CISzKffnDhSR1N+KEEs0GI
         jsfhEQ1BM0+lDmHSlBf1lyTH1QI2X8ptCHzXCmiEMZql6n0CLEddxVn5P2J0b3A2IV
         hEu090nwATCjNBncG0hCYpYGqJLEyIzrLK905qx9tayybwtxh4XpYZqd8afl+ludZQ
         glgzNr8LfvSJkH8iDPTsg92rxeDgZhCWwoKvl9pWm9r2slgkGJqn7SOwwcBS83J2v+
         lZU/p5Bs878WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 444EFF6079A;
        Thu, 20 Jan 2022 11:59:12 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120113748.26602-1-idryomov@gmail.com>
References: <20220120113748.26602-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120113748.26602-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc1
X-PR-Tracked-Commit-Id: a0b3a15eab6bc2e90008460b646d53e7d9dcdbbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64f29d8856a9e0d1fcdc5344f76e70c364b941cb
Message-Id: <164267995227.31408.2363209478237733534.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jan 2022 11:59:12 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 12:37:48 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64f29d8856a9e0d1fcdc5344f76e70c364b941cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
