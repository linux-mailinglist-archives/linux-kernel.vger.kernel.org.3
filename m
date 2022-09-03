Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB60E5AC15D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiICU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiICU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413F5245A;
        Sat,  3 Sep 2022 13:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F04960DE7;
        Sat,  3 Sep 2022 20:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB62CC433C1;
        Sat,  3 Sep 2022 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662236949;
        bh=5565w3/bwkb3qWieTCNNWPDqPqESCuufpbO7asrfnMg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sp+edGZ6ZtUpv2HyQInbQPXbpQvPzEawP2/INlpDnifZLv770+O5dtQklruGSfGrf
         JEDfBphGWyqtaocrtdbuLBz5W94Jf3QBdVX+uuzF+w63jPWrPu4mdAWxAh0OJW0321
         wlE2WCIgdjPo3QpROzGH5KotuSOH2PfdoKhJfbvaRyrvAwhLSgre14LeTuGDn/4rOJ
         tsVy183S+cEr0YgeuGG7UsSfaeMhLgzi6FIQQUmSip4BK3X3Q+bEDWq6RGiNuE/oqm
         ekZoufjVzKOipazOSX2ias0UQw/hn8Efl07wHs5KSUU//w+2/efhk3jufg1k0vhsk5
         gnkDNuIwTXIsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A94E0E924D9;
        Sat,  3 Sep 2022 20:29:09 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01662197774-ext-9772@work.hours>
References: <your-ad-here.call-01662197774-ext-9772@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01662197774-ext-9772@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-3
X-PR-Tracked-Commit-Id: 7c8d42fdf1a84b1a0dd60d6528309c8ec127e87c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cda9a8486c48f09dabfec0c17ab109e352fe368e
Message-Id: <166223694968.8828.4720583457733412215.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 20:29:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Sep 2022 11:36:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cda9a8486c48f09dabfec0c17ab109e352fe368e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
