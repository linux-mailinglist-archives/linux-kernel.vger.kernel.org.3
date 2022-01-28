Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FD49F4CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347118AbiA1IB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiA1IBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E0C061714;
        Fri, 28 Jan 2022 00:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A491A61D2B;
        Fri, 28 Jan 2022 08:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 179FBC340E8;
        Fri, 28 Jan 2022 08:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643356914;
        bh=OjCmcRObEmogx6SH4Qut1KQ549pRZmSJtfj70AU6IGg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NzfDkCXVScPbr1kgkZ9H+biirqI43oD2WmA89DNgrAAxYcYo6qfspdef3FQ7Seauf
         5dE4mp89EvhxwkMnVPX7WEyTaRSYU0ka6o71kS19NZuUodS6L5Z5VjQfqt8Xh0lyP/
         KHrDOKIBeRFvS+fY4JQtpQNH62DUTD82o+LkpKH3BAerZDsevnxyCzBy8KD0pJHTyN
         DnupO2CRNZ0JSbNuJG9NV/3M9r3n0/nIcozkw6Z9Ar4O0BbRzxt/XSzmSdGzXm/Mba
         xPBBncuvk3zZHCiVqRWKxb1OqNegp3JLn4niZIqron0oLGx/GGbyrrO3pRn8B3WNvJ
         en0/MfSVvj7qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 050C9F60799;
        Fri, 28 Jan 2022 08:01:54 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128055440.3947883-1-linux@roeck-us.net>
References: <20220128055440.3947883-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128055440.3947883-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc2
X-PR-Tracked-Commit-Id: 79da533d3cc717ccc05ddbd3190da8a72bc2408b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 374630e3f94efc8184a727694276088f52bcc3d1
Message-Id: <164335691401.26371.6391816821881752961.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 08:01:54 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jan 2022 21:54:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/374630e3f94efc8184a727694276088f52bcc3d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
