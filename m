Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376224ECFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351725AbiC3WtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351718AbiC3WtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:49:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECB2BB18;
        Wed, 30 Mar 2022 15:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BAD0B81E68;
        Wed, 30 Mar 2022 22:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C81D4C340EC;
        Wed, 30 Mar 2022 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648680435;
        bh=TqoXHTIQj3N/C0MSOVsi73OTPXPS+rA2/YEx9bH5YZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GbYDO57+NDLnraNSu5t2pYdJDa1mNtCXnAI/pUqMpFx+UUEnbF+H1GtCHd9gq6BVV
         RlbDBNZsCNF7Gii66vKwuwCa9xE4/2V6nrJsybilPicM8Wo2kWBBb8uVoLSjcYnhd2
         E65syVh7XQM2av+N2RHPB64/WFrWg0OxMpu5inZmsw/AHxVvaivZ03y4KKthL5pPy+
         08kXUeQ9fr9O6vOGEL3wxZBeQzdP1jBSmCbMhSbnYJQyLHvG4zyKAswoJZn8LSBM6M
         4ygVLLcSwX/oR5IANC/sJceYurxGl/i+GSZNV8iR5T+qN7XJi1lYLINPuai1i8gCcr
         5MRGdzuDzRCzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B497EEAC081;
        Wed, 30 Mar 2022 22:47:15 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc1 - part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkSAYq2dExCq1TcP@p100>
References: <YkSAYq2dExCq1TcP@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkSAYq2dExCq1TcP@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-2
X-PR-Tracked-Commit-Id: a9fe7fa7d874a536e0540469f314772c054a0323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5fd43bac8396c9b213faf14cd4560d73b30f618
Message-Id: <164868043573.15820.5743713699715152378.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 22:47:15 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Mar 2022 18:08:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5fd43bac8396c9b213faf14cd4560d73b30f618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
