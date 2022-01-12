Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24A748BC80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347829AbiALBfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347821AbiALBfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:35:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969AC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:35:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264E06164F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C9B8C36AEB;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641951351;
        bh=Y0jQZ8xW+LQmMqTURJgKhPM6sP4HreoSo5nBXRVxQIA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q8gHMJDPmv8ZMQjn31KgaFO73pTzrimSYH4vP7uHyRgv+f0BWbrYewW9Or5bWR1ey
         vswH0cXJSqfSmb7jAGg+XqeAzte0yY3OzkbM2um0LvKj0cJ4/Q2YREhYfMVAwHwbjX
         9lbd786PXckIbZf/Anfy6IhzfdYo0iZAoAeiZHkmxCFCkVdrn7f6YectUWM9iXvjlj
         lxz9ld5drEYkCe19a05+Q7YVOMDb+I3++WWc84OWkEK+IGHw2CUUOvg+cXYWSZxguJ
         y4VR3JWhjjsVH0RvD+L6lw7jaFyld2IIeOxOszr2AjJzaY1u3tjJ+ngZCLcFMK7L6w
         Lst1KhTi0+jvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ADC4F60793;
        Wed, 12 Jan 2022 01:35:51 +0000 (UTC)
Subject: Re: [GIT PULL] locking/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd2/yMnHa8zHe02U@zn.tnic>
References: <Yd2/yMnHa8zHe02U@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd2/yMnHa8zHe02U@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: f16cc980d649e664b8f41e1bbaba50255d24e5d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daadb3bd0e8d3e317e36bc2c1542e86c528665e5
Message-Id: <164195135149.30057.9627466230188569494.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 01:35:51 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 18:35:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daadb3bd0e8d3e317e36bc2c1542e86c528665e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
