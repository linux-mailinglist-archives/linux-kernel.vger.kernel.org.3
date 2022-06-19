Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF10550B50
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiFSPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiFSPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7FB846
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAA3EB80D3C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 709A1C341CC;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=tKN0Ay/ZnaQHw968DDpaoyppvgvcjgPiEbzzF8H2CwA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dt7dgOqgpVJX+Y38NYGAxiklFi0HMCuN8uui5KTYo/QEVTHSFPkMuYURiJo6Tq9BE
         l/IjEJJE9IDzOxQaUkZzXdglhaoJdY3S1iQWuG9bagryKllAOZB4ilkFZhr8bC9xLh
         vqHQGlx3tBLQTMEBimjA8TnQlU6k0fu8486RFOLGLfIeZO+5aFtm7bIxMljGD8VVzZ
         nHJ+73UAKfk4BayjqTEaH/rhoAhK44Fl4xRY4x/9CmizI0A1+ByvOXYqU09bTh2aXX
         Rp14V3nhqr9cn08zoxie2GtY5XJEmOGDYwW6RFFN1E02JqZ+bUKWFFbVMuwJIbcztQ
         NZTNxI0PqtLaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58BC4FD99FB;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT pull] objtool/urgent for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165564430032.1413209.11657608098401674700.tglx@xen13>
References: <165564429738.1413209.17302088152547038708.tglx@xen13> <165564430032.1413209.11657608098401674700.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165564430032.1413209.11657608098401674700.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-19
X-PR-Tracked-Commit-Id: 7b6c7a877cc616bc7dc9cd39646fe454acbed48b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d770f11a1623eef83894b60686fb328794ccd23
Message-Id: <165565088735.16911.6362793532390383102.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jun 2022 15:12:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d770f11a1623eef83894b60686fb328794ccd23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
