Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90696495E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380289AbiAULwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiAULwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:52:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE1C061574;
        Fri, 21 Jan 2022 03:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B9B461A81;
        Fri, 21 Jan 2022 11:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C61A2C340E1;
        Fri, 21 Jan 2022 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642765939;
        bh=VJYfDLCxd0Zt4kkzA3/Qkgo2ircVuD5F1uHhM3As8Js=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GCKE+Gk1HGWgKor3elJ9E1dmAfceHnHSMYLMDnl/srKF0kBnKFUeDv83cb4eyFlvv
         R52+sE+BjvHNvpG8+mt/mR1TEiMh7GgUCJNLIh/oqnkvYJgkjQNUPQKy7Q9DEjxIjf
         7Qj/FCuOKRH+ZIikMfEz+6O5etGAba/eKIECar2sGD2lSFM5/i8uJjsts4HGWbi/wI
         bKGdDBlD5v2sX72BeZPmneDMmUxSvtH1+LLY7CWPYDXXQxa+0LGDTG7th5WjR4V+Y8
         yIG/T0WDamN80W34T7N1v1eSdQbJ042vB+ku15xduJqWeG+rU2I8t6dayp+1thbn32
         0lkFy6IXqDk1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B602CF6079B;
        Fri, 21 Jan 2022 11:52:19 +0000 (UTC)
Subject: Re: [GIT PULL] RTC changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yen7oaDXAbd4tFOD@piout.net>
References: <Yen7oaDXAbd4tFOD@piout.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yen7oaDXAbd4tFOD@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.17
X-PR-Tracked-Commit-Id: 5ceee540fdc7f1d65ca6e2b1b193ce5aa95ab99c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75242f31db6cabf602a5eb84c13b579099d72a65
Message-Id: <164276593972.2956.8722499040092955713.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 11:52:19 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 01:17:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75242f31db6cabf602a5eb84c13b579099d72a65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
