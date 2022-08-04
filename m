Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D758A13A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiHDT1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiHDT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:27:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022426BD5F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADB2EB82719
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62FA7C433B5;
        Thu,  4 Aug 2022 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641237;
        bh=P0RDCNBh9PuMvcZxdwIXMeW5ilKhdsR2GtY9WiDSLF4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=csmnRdZ1BMjKJi4UHAiDB5k3HiJ41Ayc0IiJ1LLptxliURhNBmGh6y5+H/EiNfmKl
         FSeonBFS7nXC2E2ChNJYrfoF9YFHsmfShyjeyE6HeFzJyLvP6Ffr5PXD9GZN01n7/Q
         BSBQuQVO+RN2uL0DO7voj6mDZtKFviUgzn2kn+LzTImQpa92SJLgne1TDK8XKwk+vS
         vieYv4ChnsrxW7IkupWhzm1QXqZMrKW6ylPv/Z7N1AbQjfB05Eo41w0DyBovXu6pzU
         l0XtdxOAE7FJpRkudd50HrhsW0A0GdSOx2RA4VpjrHi3bEnYQThio2ECIIJ2YCg+m1
         R6+RAq+JUwkRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54111C43140;
        Thu,  4 Aug 2022 19:27:17 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuvQdHf3ySPA78/1@kroah.com>
References: <YuvQdHf3ySPA78/1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuvQdHf3ySPA78/1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc1
X-PR-Tracked-Commit-Id: 87f600af59e8cf6abb04bac15328bcb517e26485
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 723c188d5cd42a07344f997b0b7e1d83b4173c8d
Message-Id: <165964123734.8981.8407165927018219827.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 19:27:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 15:58:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/723c188d5cd42a07344f997b0b7e1d83b4173c8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
