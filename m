Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FF53AC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356526AbiFAR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356507AbiFAR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:56:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76E995A39
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C982B81C13
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28BDEC3411E;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654106160;
        bh=KMjErbkYBkuO2JcCPryqWCjXo1azdH24+SYmgTvmPTY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G/uQzEo2xJ5cWAiAT0PhXQnVGVafwHTxkDHG628vSVO+P91lT5FrRXn4TnlhRrC7w
         kGcjCdrOqClZDK2+X4JQu1eKrwnE4EPukI/K7bcj0dtekmfgbwS0HW/kVjH0F+8t7M
         ru3Fj478pqVT7Mxhp8Nx/4Hc4qFmPmzSPaO22e3uRu0hW8F4s0W1EDJSFMnorggQOU
         lRC0tQGlandAhnv/tyfVmllEPsXiPz6LgkTxV+DJSg0bkN2JtzcqqCwBubPjDZpwEC
         eFzKxuT1do/5/Ia9spLHofnL+X+6u4u3vT/GgtC2Q6WzQWEMe+LlPtgMnqO1prWbVM
         TPIYys4wWZYtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 100F5EAC081;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
Subject: Re: [GIT PULL] pcmcia updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
References: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypb3t6HB1D51+hfU@owl.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: 2ef4bb24ff39ae4af89b80bcc5d516f55368e8ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2380dd691e1fe1ebe3f346d0ce54f8fc7eacc167
Message-Id: <165410616005.7706.12124904375045689010.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 17:56:00 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Jun 2022 07:23:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2380dd691e1fe1ebe3f346d0ce54f8fc7eacc167

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
