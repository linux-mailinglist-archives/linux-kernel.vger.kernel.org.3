Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4201513BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbiD1TGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbiD1TGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2D5DA7A;
        Thu, 28 Apr 2022 12:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A3AB82F43;
        Thu, 28 Apr 2022 19:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC917C385A0;
        Thu, 28 Apr 2022 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651172604;
        bh=EnUY92OFuv1H14nuVbXRqLmmH4SWof73crEfPp9DBag=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J79JrAIMUKpomqxQxQmbADz1XPA5YkuPD3E6Zd82qb05Q2EAYuwFDtRGblj8RWLGb
         brukPF307KRDp5HP+mVxQWbjAvdH+1NowiR1oEaBSpg/sSjdKytZ6LcG7jvoEFQHMn
         lq+csk5dAZnX2Y8M27QB3XTKXrQXsuo/daZGpVg8yBB8eXWdmVl6jqJVz48KNaMz6b
         GFFkZRwGcdTPxzKeNb/TmVk7i7YNB6c5C0EBmBNnAY3vQJRtfUhaObd1ivKz3E8iMd
         CXc/u0nhIrMh4fx0B6DvThUMj36qqlwjBOofRGyiGtwEjlhRrOdOlVkbCFetLBHvTC
         zFSxSh8REcVgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D012DE8DD67;
        Thu, 28 Apr 2022 19:03:23 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc5
X-PR-Tracked-Commit-Id: 20e582e16af24b074e583f9551fad557882a3c9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f12d31c00b2e1d0774772695fd644b1c15e446ac
Message-Id: <165117260384.15527.6186068422852149800.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 19:03:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 17:30:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f12d31c00b2e1d0774772695fd644b1c15e446ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
