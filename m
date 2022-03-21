Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB65C4E33C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiCUXAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiCUW6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E946E777;
        Mon, 21 Mar 2022 15:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293A36156E;
        Mon, 21 Mar 2022 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B04CC36AE5;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899628;
        bh=GJkjL4UZBkaIhfOg8EoXxAXciPyo1zbm8cTIH/VGHMA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oijYUMoHqXTTZgw0UJU079FLbSQ1cBfqLwhba8WknsAHviK4mB/9I/i3sx3Zg/Vy8
         3Y0b/LOWkuFnMObTzgwYGo30HFOXGKC3uCuChgGKLHIWCpx/4ydK5t9PXQTkPXwqtR
         wmZ8MgkmrBn/H6cYTYGUBykEQNiuIhPO3Oc2UmO9U/JSYZXhrtClUAvD++qHKV44Un
         RFI2tt3vRKo9pE+XewrgU4u0AatFqxMYMElUO67b2KzzJ0XggZ2F6G7l1iAkSI0jzj
         Bv8o2Z3rdGLIAx2BKjpKaSsmiFsjhNcIYi5YXfsxY48O94rTqdfPDZkFCoMgSLHXYY
         InDsqnZKmSY+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73739EAC096;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i+dDvX2J7CHfawmFXynifkNZ-0ZHYnraYv-HYJN5bdbA@mail.gmail.com>
References: <CAJZ5v0i+dDvX2J7CHfawmFXynifkNZ-0ZHYnraYv-HYJN5bdbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i+dDvX2J7CHfawmFXynifkNZ-0ZHYnraYv-HYJN5bdbA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc1
X-PR-Tracked-Commit-Id: ec3d8b8365e9865b43099e943ec5f0bc12f28f96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02b82b02c34321dde10d003aafcd831a769b2a8a
Message-Id: <164789962846.9856.5443443057848471317.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

The pull request you sent on Mon, 21 Mar 2022 17:36:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02b82b02c34321dde10d003aafcd831a769b2a8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
