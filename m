Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42C550B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiFSPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiFSPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923064FF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF95461198
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EAA7C341C8;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=2BHh4523W+MwX/LR3O60Gui6mhL+FQFvAxbjp+mZ6aI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T+tuUeLTKGvU5pHN072kkjrzMoRMtk7Lnf/bAloHlzOZFSqcX3dRiwmgIn9A9+E0t
         ToPrWyoTaZXnLvfSQTcX3hldgX+gPQxdEkwgc0ueUUYQKuS3kbe/x1s82VvO0AyjdT
         70TbRmBAT8hQEOPwnCF4pMHHcP+hCwmSw0JoCiJ8yDrWE6RY/QHitJZMgn42uBGe0f
         KWRJs14msrSPkHwIVVslT6p7LuERTBoKWNH3/Bx3LYQe/9J3+Q/edugXbb9PUHPKdZ
         P80LPdAOQya/cw996CFSbCwM2hPLnVZBZme2EET9X0isLnmoujvEUbSLvJsK4jAT5q
         qAuvUJ4woqhYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32145E7B9A4;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165564429887.1413209.8729918730024457105.tglx@xen13>
References: <165564429738.1413209.17302088152547038708.tglx@xen13> <165564429887.1413209.8729918730024457105.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165564429887.1413209.8729918730024457105.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2022-06-19
X-PR-Tracked-Commit-Id: 4051a81774d6d8e28192742c26999d6f29bc0e68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4afb65156a79c59fbdbc10abb0bf06ff83f73e23
Message-Id: <165565088720.16911.9395222975484897875.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 19 Jun 2022 15:12:35 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2022-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4afb65156a79c59fbdbc10abb0bf06ff83f73e23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
