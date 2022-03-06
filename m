Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF24CEDB7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiCFUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiCFUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:34:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080835D1A9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:34:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 561D4CE0D85
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 20:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C15DBC340EC;
        Sun,  6 Mar 2022 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646598843;
        bh=5TYPJG5BEum420Pvp4/P32yoIZjvFF47gqf1WdmIiTk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rQ1FX1gbzA//7iI7b8wGJhXHBqHr3gpq3LLLuj1vOTOsNE30QiqGRPz3FkQxo73wb
         EVzYDaQr87b6Y/nNsHsWvQeUZisXECNuDEVjBOmnDoVj4D3x0+0XFRE3/b37PV60ra
         2Mf26pIugRzh/h+RLwC5dFsHtc/566dRvVRcyUQtnxDdBlwJ20we/5yJWoXwSMquU3
         PYz3OMiaWjDo+C+P9+OBQ/Y4BLmP8YU8z4eqvEWMDIWaNSg+0g8paZtymyKwFXplPO
         yFgHhUnGm5nX4g3hz2A73jaes07eIMbMdO5AUMEbFPs3sz34fu4LZqiGZclcDfcA43
         KdSdyEgmrQLiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB60E8DD5B;
        Sun,  6 Mar 2022 20:34:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
References: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-5
X-PR-Tracked-Commit-Id: 58dbe9b373df2828d873b1c0e5afc77485b2f376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bdeaca18bf61d55029277bb35f72c2002c88c4d
Message-Id: <164659884370.14106.12409054934091400945.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Mar 2022 20:34:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        muriloo@linux.ibm.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Mar 2022 18:51:36 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bdeaca18bf61d55029277bb35f72c2002c88c4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
