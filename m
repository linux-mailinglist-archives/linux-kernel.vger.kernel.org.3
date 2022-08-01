Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E1586E73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiHAQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiHAQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5163E74E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 393C3B8159E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF67C433C1;
        Mon,  1 Aug 2022 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370682;
        bh=sT3zuzgRt8w5uFTOCXg5Oir3O7KYZNoeVUz6YW3xGgk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gQCBqek5g02tUKaYpp8CdgADICgCEQG4KiSXisC1A08b5ll60Mrta8zkjFnNIJSg1
         L6UymPNJ2naqJBsbYeykxTYb9CO5D8EIM3+Ko7b7jO9l8JkbVdkzieTXay5+9RC/PJ
         Fexgzxklw7cFclf4dpqPTdO7VGYhg0I5lRnqQk29wsGyCe+rrvhYlTslr9/fjUA7D4
         /P6EDSyaK+kudaScVBKlIFp7Fr/YNK8aMKZ4FdBuSaPu1Xo1CTcExqoICg8A2JF/M0
         4lPZ211Q1hHjpIaABS4Lj+why4iIZwYDxEemFgYtR9md96Iim3XgrUN8wSndUHj2SY
         xggAjb63YGYiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72A4C43142;
        Mon,  1 Aug 2022 16:18:01 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YucDJOcnlB7EOD8g@debian>
References: <YucDJOcnlB7EOD8g@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YucDJOcnlB7EOD8g@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.20-rc1
X-PR-Tracked-Commit-Id: ecce9212d0fd7a2d4a4998f0c4623a66887e14c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88745dcfd9de5c7de1c17f81e7cecec3d88871d
Message-Id: <165937068187.17475.15354625708863816235.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:01 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 06:33:08 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88745dcfd9de5c7de1c17f81e7cecec3d88871d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
