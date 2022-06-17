Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3954FBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383032AbiFQRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383115AbiFQRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890F34B86;
        Fri, 17 Jun 2022 10:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3547561E96;
        Fri, 17 Jun 2022 17:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA1BC3411C;
        Fri, 17 Jun 2022 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655485643;
        bh=u6NH63xnCfzpONJQRj7RT7To28O0JLP0suIS1EqXWHs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bUQf73+lYKSDMb2XGaJ/F+MUiwSCj1Hm/pjeNYXbPLzvuzQ+xV1WPGHciXwNEfNTg
         giaj8JSWzMCV3XWufRSh2HrZhMyP57CbZeapYSu/4NzHuoLirp8xxDTszdEWe+jtPE
         hkaTRlTD7CYfY7N0/HJHiJEwN9iuTCGVvwrxntDTrq1ftaSbJFihQMg9wnH1F7T7aO
         6LIoIf2bOxsK2VZ17bTkeKx72y/DelDndeLlPzSTnSpoik7XgxfS+0A5YJUOmAhZEp
         0OoJqqK+w1wFtvMPyuYgK4UmwG+Qjm0hfW7G63W0FirWDD3jHxHu6t7TGatCR8jCBu
         zGyWwRniXgQ2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89A48FD99FF;
        Fri, 17 Jun 2022 17:07:23 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.19-rc Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617104820.GA10498@www.linux-watchdog.org>
References: <20220617104820.GA10498@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220617104820.GA10498@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc3
X-PR-Tracked-Commit-Id: b6c8cd80ace30f308aeec0ecf946f55dec60cc68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c2d03f15f52fb92d3a0602995fd1fb8fbffd475
Message-Id: <165548564356.14433.12140944651151653516.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 17:07:23 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 12:48:20 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c2d03f15f52fb92d3a0602995fd1fb8fbffd475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
