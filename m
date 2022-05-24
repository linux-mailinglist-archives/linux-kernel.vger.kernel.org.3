Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B155333FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiEXXmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiEXXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDE5A58B;
        Tue, 24 May 2022 16:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800A761828;
        Tue, 24 May 2022 23:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FE7C34100;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653435734;
        bh=7KzPnFEI232jKLnnLUBFggfxgS5x12Ej88dqeiDuAEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ozGUMpbsj3uFWS8P91Xqf/R9+yvsQSV+xQ/uVPDs+CKtcKn+mxYMkpdBkfMXQyoDK
         WbrO9oRnTNhXV+7Q57aaZ75DuJF1RxCxlJD2iMqoezViQKTtFsJvsOlb5ZCq+LWzxx
         vKgaacH8l2VNERpCSo9ZNY2IdkK7mhN1ofrrIhwS6e/634gmn7U/+HlzE4UXmLBQpp
         diBCY4/0UoNA8F/4HmbE9J8n61KQtdH0PKEkeIyzWWFTr1l8fwygLMSisS/UQn4fh3
         ey9eqERoke+W7QeYhRbAHY82BuN8V8Iw4Ru2gZCL5oKY/njGGx74HVU5NbmNqYMGT3
         0DKe86HzF0EJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5677F03942;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hKBt3js65w18iKxzWoN5QuEc84_2xcM6paSv-ZHwe3Rw@mail.gmail.com>
References: <CAJZ5v0hKBt3js65w18iKxzWoN5QuEc84_2xcM6paSv-ZHwe3Rw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hKBt3js65w18iKxzWoN5QuEc84_2xcM6paSv-ZHwe3Rw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc1
X-PR-Tracked-Commit-Id: 0d64482bf29917e659c556aa36cea241b17c33df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09583dfed2cb9723da31601cb7080490c2e2e2d7
Message-Id: <165343573480.8820.13683203333530720740.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 23:42:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 21:42:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09583dfed2cb9723da31601cb7080490c2e2e2d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
