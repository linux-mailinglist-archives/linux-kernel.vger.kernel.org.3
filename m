Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1C4FA2BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiDIEla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiDIEl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:41:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E43A71C;
        Fri,  8 Apr 2022 21:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07504CE2EEB;
        Sat,  9 Apr 2022 04:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AEC1C385A0;
        Sat,  9 Apr 2022 04:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649479158;
        bh=Z7QYTmVS6p3z2NybpQqu5jAgAyXrncGJtZmjaHDUYuY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ocg7JTrb/zZeby5WUjfpKKtbnNiHL4SpfThqfKoRVfOYHkCXaRSwANo78DklkBCA6
         8Ngxxj0bGl4uoFw9bnhawYAkeXLsOUK88zI3nTFPLzPHK5R753RxdJ5P7sVVDhvpXW
         YXmHIukqiNaWODdsh+PxlqROQbceluOCk/W6I5FtsQOOO/ync8d4FeqaqExF2NMofX
         HIerhvQbS3BnbKRq+SCpRneyelWIFn6/yOuX2Zs56pHTx7b1X0GukCRm6NYwniQQkM
         Ebu1gKLX/k3pMlMgyjQkhWVcOwGX8miGJhHXnLq1oLGLVNBUeIAIrkul7XKQsjobkY
         fLg1Fv4pSR6Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 510A5E85D15;
        Sat,  9 Apr 2022 04:39:18 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g+31PFhkoROu18aT2CLGkn61v7aLgiPC3M_zbqqf_yCg@mail.gmail.com>
References: <CAJZ5v0g+31PFhkoROu18aT2CLGkn61v7aLgiPC3M_zbqqf_yCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g+31PFhkoROu18aT2CLGkn61v7aLgiPC3M_zbqqf_yCg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc2
X-PR-Tracked-Commit-Id: 87ad236001eb95cf1760ccaf7670c94722231097
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d017a3167bcb76caedf2b444645bf4db75f775a5
Message-Id: <164947915832.5739.5376590233982977489.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Apr 2022 04:39:18 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 20:33:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d017a3167bcb76caedf2b444645bf4db75f775a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
