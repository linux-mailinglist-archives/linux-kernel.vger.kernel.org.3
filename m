Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03652D9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiESQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiESQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA4BC6F6;
        Thu, 19 May 2022 09:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AA461C4A;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3097CC385AA;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652976869;
        bh=G58ptIjn2GJ1aun6Kx0042yWFtBKi+hQ+ndMF+DadbA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MYqB6HJV5sDK5aDLjvOcrhLcCe++NNqmpyL6jIfz1BqX4vgjPo3wAq4xdc0h4M75J
         hEnaDygvwNvhZX2+omCCK6vqXYhExoKuQ80+8KRtsjHfcFdV0c79dzna4D0RpFo2OV
         GU+Y7YhVQXCWSp+blpjWzlkMrOyvvK4AHrYvR9gtDChWMeQVc9gNfB3/rTNWLSEMEl
         MvuCL4A8+1Drmj9DpWG0kgHwhQ/MB75diB+oPyp2KNFg7LcPKyL5lt5ldt6tEgQ8WM
         LGNqhqMxhGbdu/0MzeRTgEXWjFV7UvvZ0uw933uxxnUf0PGrqp3BcAflz0vUUI7Qdp
         tXzG6LKDjsUjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D671F0389D;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture cache flush fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoZkpODq/SGRunJC@p100>
References: <YoZkpODq/SGRunJC@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoZkpODq/SGRunJC@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-4
X-PR-Tracked-Commit-Id: 798082be69fea995a475ca1db8f9873589e207d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b015dcd62b86d298829990f8261d5d154b8d7af5
Message-Id: <165297686911.7702.14789683282223115092.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 16:14:29 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 May 2022 17:39:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b015dcd62b86d298829990f8261d5d154b8d7af5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
