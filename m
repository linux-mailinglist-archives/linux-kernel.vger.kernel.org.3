Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B124558651
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiFWSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiFWSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:09:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF123BC982;
        Thu, 23 Jun 2022 10:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D28B824C2;
        Thu, 23 Jun 2022 17:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3252C3411B;
        Thu, 23 Jun 2022 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004796;
        bh=b61ScdAaa+H+Y7hsckbm7PjKuEr3E7rgPVk5cGCsWiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=du6m9Vdpk6a1fjJXXEwFFXDlx2G9xSLqy8ggwLsIYjcfJGiAXBcmDH7rwX4aukfM/
         e6j7yuliKEzS4HTO6NAichMe5GBM5fmv48H7Lx8CfoqfZ43DfU1NTSymlNMh9hXVi0
         E6OWBhakiq7bW4UvKJ0qy5xBnVulvP4mldPSQd2JsGCRyrbQXbif2Ipm4Y9c7tQXLn
         koz6gk3atkAnmQX8mEGpFhtn2CeMHdsH+kBrgiy88NidJeYwz0iZAgIIK8eyKQPstW
         J3nG8SRNpPcyEJG0TPOwofSXmA8Z/+UZBD2L7N9CzNcWH8/LVUBe0qALzBHM8Z3zT+
         NDuTTUC07qtaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEE02E737F0;
        Thu, 23 Jun 2022 17:19:56 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes vor v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220623164032.GA14476@alpha.franken.de>
References: <20220623164032.GA14476@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220623164032.GA14476@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.19_2
X-PR-Tracked-Commit-Id: 3748d2185ac4c2c6f80989672253aad909ecaf95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 599d16912d0746aa67ec645ca6c121efa7bfd377
Message-Id: <165600479684.24638.6525235646511509098.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 17:19:56 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 18:40:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.19_2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/599d16912d0746aa67ec645ca6c121efa7bfd377

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
