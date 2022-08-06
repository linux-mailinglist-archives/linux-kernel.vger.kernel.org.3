Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81F58B799
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiHFSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiHFSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AFE0D7
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A4BB80818
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CA0AC43143;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809978;
        bh=GDXsTbGUOryXTZljw3sWLj6lxt+y1RQiHRs63b4rLDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oIAfCWmOyhQCEYlJPV7TAkRPIL61UuKLaG+saT7aPW9i8MjD1g6qGZ+NaBTDzmMJS
         XdbyRzGRh4bqOYTyWdf7HV9Qj/1+jOP8s+lrqn60kiYuZAqtwuu3TNejCbyMMASVEF
         01ue0mVgxKzXKL3JORswEQkX85A+ydZBdAzQwTx184xNP2/8nR0laRbcofYLiwSbpD
         p5fDHRMDT3IURic0gyDtfxfBkELnQriIWHgqFw5v18t/H+1hMmwEZqKH5RHxG1xamb
         OgqjWfDOzF8mJuJnP5fKCYhcpyvv+Vzn3Q+2g1AVJMJ+VjuHXsZ9eNieFMJld/pRBC
         VtYMet10blMvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD73C43142;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yuzh5cwYc6TLQcWD@google.com>
References: <Yuzh5cwYc6TLQcWD@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yuzh5cwYc6TLQcWD@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.20
X-PR-Tracked-Commit-Id: ae4ccaed3a063652ec5b81efec2ad57a4ee506e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 613b2a82f2e06fc5f75c2921e9908adfa7cb9024
Message-Id: <165980997831.27284.10463957981407132437.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:38 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 10:24:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/613b2a82f2e06fc5f75c2921e9908adfa7cb9024

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
