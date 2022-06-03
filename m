Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08653D1D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiFCSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347924AbiFCSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A14286E0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F320619E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0205DC3411C;
        Fri,  3 Jun 2022 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282223;
        bh=c641dT+UvRtuCL3JXXaeaFfnNkizuRHmsq4rr9VKgJg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CotXGEc/45n4awPZ02q2NPy5ZEtwECMo4UGAYm7VyGFSZRGIeK7n7fRPAuQGhKc7Y
         ileHXVwvqIRYTOU5FGXjSqlV/oxN3PyoWJ4sooNpGLj/Y+G3wB/EaqMZbx6ZigIpHx
         vcahVNiqGXj90u+cEPcRc/iE7l0RKJrhpfwM4zwcM9suc+XP65fxKcdfE33am+BIaP
         uf1qfKkTM2+6LWAIZsGQSUNLOEtYIw2/Q1E5Ekfb7VLYdHrw0+i6Oe4CgxEuTMGKU6
         XI+ibOfcUH9a/pyDMbEMhr7nUb/2NnuDTj/Epfl+BomxXcX8gSXuyUXvd5gl68AmdK
         yD0V4MA2AlPzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3CCFF0394E;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver updates 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpnmYB8SN5dPweLV@kroah.com>
References: <YpnmYB8SN5dPweLV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpnmYB8SN5dPweLV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc1
X-PR-Tracked-Commit-Id: 90de6805267f8c79cd2b1a36805071e257c39b5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f9b5ed8caddfbc94af8307c557ed57a8ec5c65c
Message-Id: <165428222292.10974.6021475136262937227.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:45:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f9b5ed8caddfbc94af8307c557ed57a8ec5c65c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
