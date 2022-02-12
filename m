Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315CF4B3730
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiBLSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:24:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBLSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7E6005A;
        Sat, 12 Feb 2022 10:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4539660B2C;
        Sat, 12 Feb 2022 18:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC1D8C340F0;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644690195;
        bh=C+JYODbdRTe7+6oAUcjzgmpcrgwyVON6/eu6Zw23bGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=daAeQmdV0raGUpPlkV3wxXAczBpzSxGdAWTGOTFhoSqQKRaTJkxAsbM/i/3IBcEQz
         8VsDd6gj3+PXk9H2iepkyTcAGFvifqh5abT+YKkNDyzRZOcWq94pzMRSX2tXHxepeS
         d0jRsUZBAi/SAmyqtL4aS/lpEIidhqX5vRJP3qV1Zqbjz+iQMyU/GLJLde3lm0j8tT
         WxonFcs7V8QLqAu3sN9blsa2NrXglQH27OSVi4Rd/1LYMy00yJnukVsfe5iwHd9zUy
         63k0S0QxP+ZFjy9ii/bC2metLP6OuAPZDo2Bk1TtwXr+LaMvCv/AaD8PvMnJFggM3r
         /NllbePvPMImg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9981EE6BB38;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgeMYDjVOe8n4Cis@kroah.com>
References: <YgeMYDjVOe8n4Cis@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgeMYDjVOe8n4Cis@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc4
X-PR-Tracked-Commit-Id: 28cb138f559f8c1a1395f5564f86b8bbee83631b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 522e7d03f7d286cde06bee51982121f63bb03097
Message-Id: <164469019562.16091.14351815014249516432.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 18:23:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:30:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/522e7d03f7d286cde06bee51982121f63bb03097

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
