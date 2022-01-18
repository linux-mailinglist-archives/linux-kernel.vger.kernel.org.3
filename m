Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB781492071
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiARHl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:41:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44606 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbiARHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:41:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC042613CA;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30CF5C340E1;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491711;
        bh=AfpuOGbp5zbY5QSWZJAHH10h0JbDq2H8JF2ZFyklIfo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b5LGh6d+QhbSdJo/pQA/k7AlrP7aA7bFEd9+rrF95j3G1RD6kUZ5l92P5gaCAiPex
         Zthccjam0v4eV7qBUOae4p6bvtUnEnetX04uPY2or21AcjOirZU9C3FjxrxkXy2/9Y
         jiSRqY6Hp8PhdwHEmBK9mn+XRYNOUjYEmfpa9sX1eOEVZx1dfgjYWiP6wHR0Kqwbql
         fYp5TS/CQQkCbYYKQKHjJWhEGdWEhjCWP6EgcB2qNNhJgvqPREbOOZonbaatssc41v
         TEEXTxxSH4JSXh1RCrScvuXN+JcFJHU+e8eUxShdz50LgF5XXQbvwsccSaDaGyKr5k
         x8m6fk9KCbCDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19E8EF6079A;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hwe1bdpymAMMv-W-mpxZGMZVdE5UM4JZbammhS0rdPMQ@mail.gmail.com>
References: <CAJZ5v0hwe1bdpymAMMv-W-mpxZGMZVdE5UM4JZbammhS0rdPMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hwe1bdpymAMMv-W-mpxZGMZVdE5UM4JZbammhS0rdPMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc1-2
X-PR-Tracked-Commit-Id: 5865918fe49ed3cb9d7b5d21f41aff8a68fbceb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8357f6fb3d9a02ac55f0d758b9c79b4647c18bcb
Message-Id: <164249171110.10229.1730890672644474596.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 07:41:51 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 19:11:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8357f6fb3d9a02ac55f0d758b9c79b4647c18bcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
