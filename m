Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDC4EE179
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiCaTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiCaTOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622E239324;
        Thu, 31 Mar 2022 12:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF254B821A8;
        Thu, 31 Mar 2022 19:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79EA4C340F2;
        Thu, 31 Mar 2022 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648753965;
        bh=0X0OXtWIY+cc4n5plCvLHcAHg5dVOByfI5T7MxgnulE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tciSiqD3O5JnYLW3HxiiOMoXDHmQ7aJHTJahzMZhOV1kkmjwOhh8UhwT5ZCJ34RhH
         4DKtjT+/Hsdane02fxQwhYpr5cQ1hOxamkcbMfEZScSzDPu1TlPMoqGkeRHE1JGskY
         iesT3SPUgWvINA162Q3eGUzOE1yaUofzNxCJ53i/RGKi+5kfb5SslBt1oXaPI3x8rP
         /mP7Z8+HVSlwqEKQXOHFD8ILAxkuPPycuZFwGjA1s2wOBGl0i2fRm7nDthJmDLAMSw
         XuFK28xICl7uCBL7JAzTaau6wJ/jaF7f9XyTbuQX7tY/JJmba3JG3yPoade8dWPTTb
         FlHL1AuDBe8Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A863EAC09B;
        Thu, 31 Mar 2022 19:12:45 +0000 (UTC)
Subject: Re: [GIT PULL v2] Kbuild updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQ1OPH-WFLyUfmVMUE4in7tbcdNME-Cp=OvJfUAJAPZ9g@mail.gmail.com>
References: <CAK7LNAQ1OPH-WFLyUfmVMUE4in7tbcdNME-Cp=OvJfUAJAPZ9g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQ1OPH-WFLyUfmVMUE4in7tbcdNME-Cp=OvJfUAJAPZ9g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.18-v2
X-PR-Tracked-Commit-Id: e9c281928c24dfeb86b11c31b53757b6a127f8aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8321ed4a40c02054f930ca59d3570caa27bc86c
Message-Id: <164875396536.22373.4406763365905728162.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 19:12:45 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 12:28:03 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.18-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8321ed4a40c02054f930ca59d3570caa27bc86c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
