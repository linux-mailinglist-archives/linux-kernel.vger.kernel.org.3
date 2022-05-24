Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDA553222C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiEXE2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiEXE2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:28:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185308A336;
        Mon, 23 May 2022 21:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95BBAB817B2;
        Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C42C36AEA;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=wGU1NlPmkMketE/d9nvWkPz/u9JtPngoB6P0IXt6r8g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HJq9eirnHmYMJPp0Wo5X3WMobQ849VQur+dQ8vk7pKidF3oBCoChVGVZb7FtPtOg/
         Ev1a1MuwAApGRCFviET3RIczvANUs9f+5iUT/J7ldUUlX6k0PYfHDyZ+OngA4pQwKs
         a1844hwdQvXMJblCe/VoaOARvYWfMaUyuFGBe4g7aNAfpOouY/W5b5NS4oklHtQi+6
         4oYAx0ciEJ16lNz+RKXTiChY61xbqC/tsHd92fa6lHrZf2DCaG7fsjazOa/Iizai46
         X4UEJwohqxM9qH9AfffR1VpZ1o4pyVc+yULM4xROszQDaPXhtodF2W/hNbcLXsNReU
         zyOpmIVpZmzhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F141F03938;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.19 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yot+xzLZETNTxNo+@osiris>
References: <Yot+xzLZETNTxNo+@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yot+xzLZETNTxNo+@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-1
X-PR-Tracked-Commit-Id: 94d3477897481b92874654455e263e0b1728acb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95fbef17e8253775876a08ec2011d3665b86a55f
Message-Id: <165336644318.29742.3782868753205190590.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:23 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:32:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95fbef17e8253775876a08ec2011d3665b86a55f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
