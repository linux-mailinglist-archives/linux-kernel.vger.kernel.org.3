Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50858844A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiHBW3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiHBW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB054CBA;
        Tue,  2 Aug 2022 15:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01F4B82101;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B36FC433C1;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479363;
        bh=RWQ/qsmqHgDcz5lbEE1eKyZAOyMebsoz2umPDvE0JHQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KHiT50u76rMViPo2X98H1Pth7BoHotwyx8ttbHXsRHJ7ejDmWPyvIFI1c8kfEsAzF
         M8c4Fc69SLbVhXo6ZxPiP8Z34kKDKin6EjMUYS7QjnY8UYcWIxAOU43HGvH+94FUDo
         QSLAhHGcBirAC50c+DQiqIMdsYbIj3NjAcSnfAsLtpCh0TKqVyzhBW0+mL7vwqdGWg
         vPUX6hbRupnqHPywNZS1aR3RVr9oNA7Q9PY7gq960hukmcgsgZJQoYgQS7fgz7mwpV
         CgmdB+Zxhu1HVn0f9L0REYqA/xL5sW1qgZ5Ol0KU1xMqPHuA2KiEgSYVdz9m77jOaq
         NyApLFTnBbIKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AE81C43142;
        Tue,  2 Aug 2022 22:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQtBZg1_V7yuzSZzzAB5A3gZB1KTHjx0ZBrc9yCA98f-Q@mail.gmail.com>
References: <CAHC9VhQtBZg1_V7yuzSZzzAB5A3gZB1KTHjx0ZBrc9yCA98f-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQtBZg1_V7yuzSZzzAB5A3gZB1KTHjx0ZBrc9yCA98f-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220801
X-PR-Tracked-Commit-Id: ef54ccb61616d8293bc68220d88a8e74271141b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79802ada87faeb28cfa2bd36e17591e7b8c6ba72
Message-Id: <165947936336.5634.2683838548045934896.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 15:45:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220801

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79802ada87faeb28cfa2bd36e17591e7b8c6ba72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
