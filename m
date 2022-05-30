Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A9538782
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiE3Sqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiE3Sq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC068988;
        Mon, 30 May 2022 11:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7113360AFB;
        Mon, 30 May 2022 18:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D60A5C3411D;
        Mon, 30 May 2022 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653936384;
        bh=FK3RBuhhbPWpKLifkaEgW7JHHZCZhRTJYB37iVtrb6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fyjATaRnD/ZZ3aSczEzBHYVfry0A0MF53QNISYvdl9FTnIV1eRhho0Mxix7lRYaFr
         LncY/I2pRFKsDuRyLM01jImVoRwF3UHBy2StUKTbr+a83cdxrN06wq4tXMxfcmRP0A
         19PzG30tMbd4loO/d8KfW1QyY7Hx/I22UP4Vb5vSoqmnkenKafwpc+pwmGwpERdzzc
         s95BU5+Ekhcv9k1WAKqZPJMxonLYBJQZxA0vjCzNvkUJUMKEzR8fKU02NDl7CYQ75Z
         aP+24gIF0vpHMfQWL2yKu5FUfCGzZuHY09eq8qr+wx2XCyuhaXfwqO/RbJD8rzx3x3
         SqFA8P4dpIvKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA484EAC09C;
        Mon, 30 May 2022 18:46:24 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hJ2X6aR6rLsm2g1ysiYaSvePTwXhE6k5cW-q+8dcLOmA@mail.gmail.com>
References: <CAJZ5v0hJ2X6aR6rLsm2g1ysiYaSvePTwXhE6k5cW-q+8dcLOmA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hJ2X6aR6rLsm2g1ysiYaSvePTwXhE6k5cW-q+8dcLOmA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc1-2
X-PR-Tracked-Commit-Id: 9f9c1f6844bdacb4a011cc69e19b929997038f4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ff7bc3ba71d398d349c49103a3da34bb4ea02d1
Message-Id: <165393638475.11978.14630172677706868403.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:46:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 May 2022 18:52:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ff7bc3ba71d398d349c49103a3da34bb4ea02d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
