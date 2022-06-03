Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11F53D1CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348027AbiFCSuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347504AbiFCSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599E286D4;
        Fri,  3 Jun 2022 11:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9AB619D7;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0F25C36AE7;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282222;
        bh=8NA296whxbQALTbAWWKlmrmJRhvlT+x4uPyIF3dF4wc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmEYysEzgm2xSoqAFBs98usJbIYqwIauQufGl88AHq4KxBH+zco4UYiIo5jx8HfRQ
         Wm9STDt31Xu+hwO+R5KHecHWrsHZAYlGDh7tjJitY4N6STzE68eksDD+/cjhIZZYNa
         bY9LNWpcmazIuQ3MobvjjamfM5Jd2Wo0w6Scgf2Waze8R9SKfV9xy+YpKv93Ob0P6b
         GZIpiDnOtRqKE1XXaaqm0lGjqJJC9oz3yQDIJhHHsRPXAfRUt+0+C2tL/yNJitHwH0
         8sf+5MMImhK21d08isGE9Gm8nT5vIugJYWHKVfcbEekcC0NiFaeQ7jlwudU27aC1Zd
         SJ0XaBq0sHpYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD01FF03950;
        Fri,  3 Jun 2022 18:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypng7xL2s6mAlODi@kroah.com>
References: <Ypng7xL2s6mAlODi@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypng7xL2s6mAlODi@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc1
X-PR-Tracked-Commit-Id: 25e02ba60f0fbe65ba07553b5b2b8867726273c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 932c2989b59008e530ffcc7c7e6ef507a28b28ca
Message-Id: <165428222269.10974.5910556569757197227.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:22:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/932c2989b59008e530ffcc7c7e6ef507a28b28ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
