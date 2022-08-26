Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192F5A2FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHZTJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiHZTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DDDD74B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E773F61EDA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A4FC43470;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540965;
        bh=q+4Me8XpP5l2dtCSAqvLCPDCu9ahJZ2IXskzO7Z1Vwk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bcU6jhGfH6XiPe0b4cXKDIclp0eV8YDvjVM/k8igY/3oUU4lZJUdUIIX6lS6eVUbx
         FOByKPadJBlhfqz8AdZK4fAbexE4KbdpUPWFIg82NQyEC5M50dbR1xETcbxud4SrS5
         DoSR29+mJQ/A7AwwPI+1tXP4F7tZ01UXPr8kGGo8F27bIBkNL1I7pJvF9e2joDazB7
         BzyYohrk7hqHBoNh6FOpnH5qSv9dzG4kpPxCemVc7NOB8vDwFHXsPd1xIUX+dql4e+
         o+8PtBr10HJD6pN7DEokl7xls0jBAnwvQ/CxQydqQ+f1HreeTD0uF5eAHvOhPmlhAQ
         CJk4fa6fr4yww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40599E2A03B;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
References: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc3
X-PR-Tracked-Commit-Id: 1709c70c31e05e6e87b2ffa0a2b4cc0da4b2c513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 012bd7e859df9d6aa0a8ab4484c00aeded108071
Message-Id: <166154096526.10698.2507268314030595927.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 19:09:25 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 09:01:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/012bd7e859df9d6aa0a8ab4484c00aeded108071

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
