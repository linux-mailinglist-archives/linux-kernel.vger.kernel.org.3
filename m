Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C40546CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350451AbiFJTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350442AbiFJTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:00:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D62C27A8;
        Fri, 10 Jun 2022 12:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4186B83533;
        Fri, 10 Jun 2022 19:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93FA2C34114;
        Fri, 10 Jun 2022 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654887645;
        bh=1jFA1VUAtjuqODgt6WoxxjMtvZfN63q0VKqpixx7MXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=onuMFOLz3LDRj5sTwcDU/FfQKNMxUxA8gX6QNsQ9T0/gnX6q9JrsFSmjooRyvpvVZ
         qspCG+T62QqSRjEmvjq8rNHHpQhIRVxmDQzwHgKOoIpkSxo0QVfL7YlJ/5D7ur+qP2
         YOmdls48ECkRqKB7kCw9j43pGqv0gfzsDwy0pI/lLibYna9LQFukgY+pdnjOd7JpeJ
         Um73lVpB3xtx4UNXRfbmbqFtM684/6Aj1MJrQV+LrjSLjmuHVL4A/QzI6wWjc1TBkB
         J28XCBrqZrpMpV13ft+YsmmXdXxghJoirYG4yF8YauxkfnN2rw89AvOPEiqNPARfF4
         SRgYScd55RIqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 806C0E737EE;
        Fri, 10 Jun 2022 19:00:45 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
References: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j0YHi9XURA8pU=+zAyCB7kDFCJQ9G=PhfcVMygyWaV=A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc2
X-PR-Tracked-Commit-Id: 67e59f8d019fb097f35c82533cc9b27bb392e5b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bc27dec7ea5ac01f126734b723acc5f3cbe5713
Message-Id: <165488764551.19537.14380231257193355856.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 19:00:45 +0000
To:     =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 20:47:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bc27dec7ea5ac01f126734b723acc5f3cbe5713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
