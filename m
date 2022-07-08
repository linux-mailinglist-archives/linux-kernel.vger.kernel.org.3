Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565DB56C493
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiGHUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbiGHUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA045A23BE;
        Fri,  8 Jul 2022 13:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5381EB80BFA;
        Fri,  8 Jul 2022 20:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16715C341C0;
        Fri,  8 Jul 2022 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657312357;
        bh=WhuDTZMeAq/uA5Ny/4FK7RIqMaT2M2cy3G9P5OszzLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WkyffjdCjikJnifCqdtCnHWRJBBt26DF4u32YvFEBLa4noXmdoWr+YXzqgUd5SJrm
         F2ilob7xYAXwEWcjsSPwiQM4ch5V08myjS3o6trV7h9wicNsEZUaeoknhqVSN7OvkN
         FWYpcCU7vay200GqkZF0CMDr1CyA9zyfMi+6NWu03pgX0vK/8IvllIiMXkjxiLmjKL
         D8vtgXiVwLSbkBCUMjsBC4cd9HGrf55tPlSVzaqcjYLSolDtLLLczVg6C/ifCIz6b8
         8zipvqqk1vN7FA5rXxb0ZjhGXOgN+BMJaa622skxwzoc+27YK5yq/rXw8RwGeiWn5f
         31A2OE0VbccdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF531E45BDB;
        Fri,  8 Jul 2022 20:32:36 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJcS9bQ07tRaN2KjOF_8+VvyRRrXNN6aQ=cujog1xXDg@mail.gmail.com>
References: <CAJZ5v0gJcS9bQ07tRaN2KjOF_8+VvyRRrXNN6aQ=cujog1xXDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJcS9bQ07tRaN2KjOF_8+VvyRRrXNN6aQ=cujog1xXDg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc6
X-PR-Tracked-Commit-Id: 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 525496a030de4ae64bb9e1d6bfc88eec6f5fe6e2
Message-Id: <165731235696.2541.17872676248443708104.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 20:32:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

The pull request you sent on Fri, 8 Jul 2022 21:21:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/525496a030de4ae64bb9e1d6bfc88eec6f5fe6e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
