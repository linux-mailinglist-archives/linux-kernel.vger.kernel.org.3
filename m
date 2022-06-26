Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1854755B32F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiFZRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiFZRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803FE08A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52AB760B2C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAE58C385A5;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264973;
        bh=4eVfnsUZoSyF5LXwFiqWxJLLxFU06Qjwb2aa/9fyguM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=axSGuYa/qav1ieIlkLofyIWzFym95pOaNc+fyys6lZH9oHR2n6xOlc/LuEcyjh5j9
         Ld/5h4qnLR3dLa3/YmkT5nrCditHh6dnaKDFvsXXDX7w2j5z17/O+d3zKx2X/IlKs/
         LIQ/WWDrPKUNYzt4YlguF2VxxPbchoHUyncgMaVm3PFocg79CAlJmd4ABAyW6OA8iS
         XKck6be5FNUINBeAexg2PcwfbQwzuOplERVBNqF4KH9Yhoehh+vhZ6Ch1O/LhCptRa
         UzEV87F6Nz+A4rTr1CpJ95IwTN/5NkEp7rxhUxbtsykD5bkx7Y3DZiROr9ZT/sVfvt
         Uf/1r5hQv354A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9873FD99FF;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmiw4592.fsf@mpe.ellerman.id.au>
References: <87pmiw4592.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmiw4592.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-3
X-PR-Tracked-Commit-Id: f3eac426657d985b97c92fa5f7ae1d43f04721f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8100775d59a6789c3c6c309de26fac52f129cba8
Message-Id: <165626497369.22456.13163681330452248984.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com,
        ajd@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen.n.rao@linux.vnet.ibm.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 10:50:49 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8100775d59a6789c3c6c309de26fac52f129cba8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
