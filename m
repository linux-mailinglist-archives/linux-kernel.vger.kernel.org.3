Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB296585507
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiG2Sfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiG2Sfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1FF5F112;
        Fri, 29 Jul 2022 11:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC32061F55;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2956FC433C1;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659119740;
        bh=yA6eELQe9LySuMbNqUxzS9omzLv9nJ8AQDz/+alZjrU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FZsS0+eXWPm7DNe9qoVPMl3ldZ6n+aEbgWdlm97T3/CNUOinmpyjUbFdWWeFsSz6S
         HOwFzgc52mAc0+CGp4/rvx5DAGn06LN99sMtL1ECRa2NpZKLMUS6tYb5EC0Mr2qKYe
         1aymAVN3bUdw/oo3uvhfF42y5RQ48vLOjfffzVA9r5SFKCfJxh3OpRARsXVHZZQzwj
         yYjy+4VIZEb4ZHOrJ5AI1vAnwZm6p3zvLfpjM0tYyQxw+2mmdA/oTJJrznmLVGRlM+
         dBnuMZdwz2bWS9dKBh/N9O1rytffv8Iox2pgaci6Q2RJeCKXcU4fCs7R38S3xxxiOh
         UOgAkOPN+D3vQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EEAFC43142;
        Fri, 29 Jul 2022 18:35:40 +0000 (UTC)
Subject: Re: [GIT PULL] Last-minute power management fix for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gRQ=DmY-nOO6ZEMF6hX_cSVVL=QX_0Kvo9wtVjwtQh2g@mail.gmail.com>
References: <CAJZ5v0gRQ=DmY-nOO6ZEMF6hX_cSVVL=QX_0Kvo9wtVjwtQh2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gRQ=DmY-nOO6ZEMF6hX_cSVVL=QX_0Kvo9wtVjwtQh2g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc9
X-PR-Tracked-Commit-Id: d295ad34f236c3518634fb6403d4c0160456e470
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 506e6dfb0f1131f104df66ccae1197bdf8f1b6b0
Message-Id: <165911974005.994.4631931989931203523.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 18:35:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 17:14:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/506e6dfb0f1131f104df66ccae1197bdf8f1b6b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
