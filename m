Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8970858182F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiGZRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbiGZRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1F13F20;
        Tue, 26 Jul 2022 10:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2516069B;
        Tue, 26 Jul 2022 17:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 025F6C433D6;
        Tue, 26 Jul 2022 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658855541;
        bh=LgzcUoHvC8x5lU5Lcb/CQQ/rFkryEerg2TPSvS6Xq3k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aiFBe8LolkN7MZnWRvAkkAx7BmXRyssM2wIXh18sA8fY47ebuszbiu4Siq2cKhMYc
         ooVNcWRTdTzp3zBM19FljzeA4PMZ8j7ghJgVNZbFiycgWZDYHYTUUznh/aHHMymYb1
         1VH3mpr4NaHRnqAva0UEqL0mCdq7UWVDoQX5rZvaEXHry8Nou+n5oc1v/CAHRgUJK8
         cGqsm8tYWpy1EwF5f3MqOG9ET4ijQUYQ/sGaFnBHctJA9YXGehGajcGCSrEgkmBCKt
         6HDELFLU+LxXuFSTAWWFoa9TZOlCu5Ai4KZci3Q618QrF3rOQjGrZe2VyEMdgmaY9l
         VmCtby+1o9WOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E36ACC43140;
        Tue, 26 Jul 2022 17:12:20 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yt/vZo1eY8/C/6DU@tuxmaker.boeblingen.de.ibm.com>
References: <Yt/vZo1eY8/C/6DU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yt/vZo1eY8/C/6DU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-7
X-PR-Tracked-Commit-Id: 918e75f77af7d2e049bb70469ec0a2c12782d96a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5de64d44968e4ae66ebdb0a2d08b443f189d3651
Message-Id: <165885554092.22071.13291395142322653451.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Jul 2022 17:12:20 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Jul 2022 15:43:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5de64d44968e4ae66ebdb0a2d08b443f189d3651

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
