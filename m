Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46355B32D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiFZRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiFZRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC1E0AB;
        Sun, 26 Jun 2022 10:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E8760DF7;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EF34C34114;
        Sun, 26 Jun 2022 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264971;
        bh=yx99ackj0pQLC4Nym5Oo0tq83cwIvG6gKcgapTCUPHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PrzgrZPBJ4SUO1tDqH7drU+XOdY4LTXncul7XXCicBPLP/rjWOLb1azVRGVVS8TZH
         ucw4qXwD8UZTG1bUqphb8O+rZEFQc1JePsm5ynYw9UqenEaHnUrtG+dRoCRrxioIop
         TRJoO1zyEo9HRPsI9ZliV+EgDujSr/CiskVg0MOv6/a+vzYJnCGIY3166lSQeWYtkK
         7SSKDCFyOLwrnLAu7AKiujvtwCS4s2otT59gwc1cKYlc37pcrArDWFkrVv1ur7cs76
         B5KHXSluthZQK9UGTYl4RemLy+7IdPfjU9zmG8rExbrrjCpxgYjO8WN1sadMXb//Kj
         H2YRxmq7GQxKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89D0EFD99FF;
        Sun, 26 Jun 2022 17:36:11 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yrh0xOWBC1+kohed@ls3530>
References: <Yrh0xOWBC1+kohed@ls3530>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yrh0xOWBC1+kohed@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.19/fbdev-2
X-PR-Tracked-Commit-Id: cb5177336ecb07fe1c6804306fe8efc827643c64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be129fab66f284c239251ec5b6e30c6e903d8881
Message-Id: <165626497155.22456.4165121966565453510.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:11 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 17:01:24 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.19/fbdev-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be129fab66f284c239251ec5b6e30c6e903d8881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
