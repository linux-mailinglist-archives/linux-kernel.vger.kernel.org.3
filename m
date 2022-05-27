Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8753691C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355126AbiE0XI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiE0XIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E562227
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A3EA61A1D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB383C34113;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653692933;
        bh=A+oRepZSQMqjKQyN/Yb7erpjHMIebZXI4vseepVcx+g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=smfFKZyPY4GPgg3+99ujRoMOwgN0Az7KuuzsO6bNFaQwqXs5t/lM56ms9FGZRTsBl
         9obxYLAVzbpFUH5qlqVGhahljGBsGLNOPIYBLci+3A/zCqyGGDB4nNxFnuxtMxhBKA
         +5of/3XPd/d4ycer9LM18DttZ+nVO+LkDZdN51bdMrMmsHdBnM53zQyqlV+qlsJBI6
         Htm7IOMA3zM6Qa0nydqge2qJ5i6a0oYIN+yU7PyftmXcmQ8rDyL4lw2T9W0qPF4cbB
         TOD0AarSeuv7W0uDJOSu2R87FMt04CqtLuAdIgUw419x133Uhu1eJMQ0bVGF5wgKJS
         e1y5qUZU86n9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6480EAC081;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
Subject: Re: [GIT PULL] LIBNVDIMM and DAX for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gyd=k7qx7nfnLmnmTASFmrJF-nOBAs9cTqM5DSuCZU6Q@mail.gmail.com>
References: <CAPcyv4gyd=k7qx7nfnLmnmTASFmrJF-nOBAs9cTqM5DSuCZU6Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gyd=k7qx7nfnLmnmTASFmrJF-nOBAs9cTqM5DSuCZU6Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.19
X-PR-Tracked-Commit-Id: f42e8e5088b9e791c8f7ac661f68e29a4996a4e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35cdd8656eac470b9abc9de8d4bd268fbc0fb34b
Message-Id: <165369293380.12283.15539059634683739876.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 23:08:53 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
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

The pull request you sent on Fri, 27 May 2022 15:34:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35cdd8656eac470b9abc9de8d4bd268fbc0fb34b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
