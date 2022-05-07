Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9A51E918
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446763AbiEGSPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446772AbiEGSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F082ED57;
        Sat,  7 May 2022 11:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C8B5B80B56;
        Sat,  7 May 2022 18:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A09C385A5;
        Sat,  7 May 2022 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651947112;
        bh=6kgtpEG1o2R8CEPQPu2CCt0G/PJtsDlVmVYI37Cj0yc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SJm2PnwYbcsGJALXIL2MXWQNfsyZMdnrHq3MDa8Z/gp3tW3O6PFj/QYIOeF71p/ek
         CzTWWJuVDlsuTbYlbGFiPkJJi30LhRyq88fceFP7vj4rdE3HfkO55+nnfwfeqgzqrT
         5VHdl8am9h1HLEMpAVWWEBqQ7ti4WJAQJcG9PnrEIPbvjb4cNKWiscYjQGC4LAXtch
         BTxsYBIFi/K/D/SFmS2awx5PYmUrnI3/tceHIC4kmyT5GZHHbBCEbTlf8LSPLq8DbJ
         z9Azs+ODRW+kSvH3c0jw6eDPeKDEuwy+LvT16yrfllMO9SOe3V9q7g57HPL5lDiXD1
         Cz+O5aM9ormZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE9B7E5D087;
        Sat,  7 May 2022 18:11:52 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220507135247.17566-1-brgl@bgdev.pl>
References: <20220507135247.17566-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220507135247.17566-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc6
X-PR-Tracked-Commit-Id: dba785798526a3282cc4d0f0ea751883715dbbb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30c8e80f79329617012f07b09b70114592092ea4
Message-Id: <165194711270.12019.11776612242162042611.pr-tracker-bot@kernel.org>
Date:   Sat, 07 May 2022 18:11:52 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  7 May 2022 15:52:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30c8e80f79329617012f07b09b70114592092ea4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
