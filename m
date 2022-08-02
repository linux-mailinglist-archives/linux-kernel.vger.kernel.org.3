Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2B15881EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiHBSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiHBSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4F13F19;
        Tue,  2 Aug 2022 11:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49817B82051;
        Tue,  2 Aug 2022 18:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEA8BC433D7;
        Tue,  2 Aug 2022 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659465250;
        bh=k+ReUNBygIUy8He2pTekmX2pvrBYv1f08+rYdReepQ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jiyvrjP5xgszSz05tAJ5Ic0tDaVKx5ZxR1nwgFC4ahlTsGzlcr1XWl11ZXh0qvW9f
         eZGlTC2Skho5y5dGYu+Mf/Whbst7O1FQu8uXMmr+5A34z7a+zd1SQt1nkc9H0R9MJg
         OX9fL8GLUu2PgbAxeKGy+1UNZs8Vl3SziNpFbqEsUxKa1sFpMiuF6kPOWDyU52WISO
         Fdw5BeOFzU390zRbS7YQ9vqNHTrwUeZAdeOHnrVNd6tBPbElyYxHtVD5dGDvEGlVVZ
         kn3zZB7BL4WFJzplPCwEObZ+zvMUeCw15EmTOKXSuYEOtpeSUw6I4+Mi9EyU2nlN7U
         SJdfg3Azj4bMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C851BC43140;
        Tue,  2 Aug 2022 18:34:09 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jsKLQLf-UXyTNSjhYYSMo3XjjF6fNSW_Dbzbrzi3+NSg@mail.gmail.com>
References: <CAJZ5v0jsKLQLf-UXyTNSjhYYSMo3XjjF6fNSW_Dbzbrzi3+NSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jsKLQLf-UXyTNSjhYYSMo3XjjF6fNSW_Dbzbrzi3+NSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.20-rc1
X-PR-Tracked-Commit-Id: 6352f3478a95cc413ecfee4fdb3300009fd3679a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fa0db3a9b8ef310eb40cf91481141ece084f584
Message-Id: <165946524981.2519.1078573144623103324.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:34:09 +0000
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

The pull request you sent on Mon, 1 Aug 2022 21:48:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fa0db3a9b8ef310eb40cf91481141ece084f584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
