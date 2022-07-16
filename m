Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE69F577092
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGPSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGPSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69A18B25;
        Sat, 16 Jul 2022 11:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E9C611D2;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 481EFC3411C;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657994775;
        bh=ErY+x+l1LxgP8vns1PTyMC67lV1YusR54eG9lc9pwbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zt0YRwy40YotigFmtARIWDqkycrii/SKugPecQBwlGXTYu8kSj+W1WuT+adMmwBek
         eE70eoZ8MHgRj53uf1pf6rc8oXiTl6RvqOd5lpZYjlIH590c5KSirym6QhJRaGPO15
         4K1iC30Og0Zv9KgPLUbNG0hsZjmLVDX5pxyuxgDH5znPPq+aqt/XfiZkWf0LEMYpfw
         DFhrJazRZNk7UNLZkCaBEBy/V56hl7JrMgtjen4lCp4tKzaq54+rbL9DMdCRb56u/w
         uNrMdG2NlnIxmOhr8lucY9UrfhCG17CZmkWyxfgjRrMlHr3IF3tph2o0aEu+7jfkB7
         lUMtYfY1CyZ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26993E4522F;
        Sat, 16 Jul 2022 18:06:15 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gDqO1fu=i9MOWuryMG7XNp+qMTTSRzNGyxY-+Jrx3wFQ@mail.gmail.com>
References: <CAJZ5v0gDqO1fu=i9MOWuryMG7XNp+qMTTSRzNGyxY-+Jrx3wFQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gDqO1fu=i9MOWuryMG7XNp+qMTTSRzNGyxY-+Jrx3wFQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc7
X-PR-Tracked-Commit-Id: fbd74d16890b9f5d08ea69b5282b123c894f8860
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16c957f089d520893b0b08e06641329fbcec492d
Message-Id: <165799477515.6229.13663817194486669317.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:06:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Fri, 15 Jul 2022 20:39:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16c957f089d520893b0b08e06641329fbcec492d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
