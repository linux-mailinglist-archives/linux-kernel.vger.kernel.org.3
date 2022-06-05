Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FA53DD7B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351508AbiFESDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiFESDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40856302
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D21A6117C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0DB8C341C5;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452195;
        bh=htN06kohyK38ao+d46NvH/fGrJfp+uKOdymZVE5V8Oc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cNJD7JsFJ2qS1hja/5UigKsQW5HsoUdPEazmz/EDi5YapsC4T0+f6TMWN56e+RnNh
         j+txA9fWFHBj7VVMwGMFYlipe7tnYZmTX5oxBMBbqxtOQG5C/3PEIGFMFhBTQnWR+f
         fBznlgHukLY48aeUIT2Sa54HXi7b1a5DoMt2kOD/4eY/L8somWsQr8WCke/MwKKdb7
         mc7pi4P/ixOZlCIIpqCOkuFYwDrupR56InlG+lTpj1y2/1HQ2fegMrZlgQ8faifVhR
         mMt0Wi4SI2Za6t3IJ1BNcmZbyVgFTQ2777jIg8ozjlUzRrk2DTXlneuSrOHHgzZr1D
         SrLKqLZWj5PBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCE53F03950;
        Sun,  5 Jun 2022 18:03:15 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137546.152751.10369547750282619841.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137546.152751.10369547750282619841.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137546.152751.10369547750282619841.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-06-05
X-PR-Tracked-Commit-Id: 57963a92a70b037aa22544fbc34742e5be689c04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c049ecc523171481accd2c83f79ffeecbf53a915
Message-Id: <165445219583.28605.8677092131881159078.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:15 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:56 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c049ecc523171481accd2c83f79ffeecbf53a915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
