Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DEF526880
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383076AbiEMRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383047AbiEMRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB54712CA;
        Fri, 13 May 2022 10:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED24E62111;
        Fri, 13 May 2022 17:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D918C34100;
        Fri, 13 May 2022 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652463000;
        bh=UFsKT2fXtjt173F/jRTCA2mX/10dgGh8GJpWJt+HLCQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cUurPn3Lm1XAwWlFIhwlRJgKrpsH8wuaQF4Oxc5jtSpkEEp9VAw3SQzQ3UDEEAEph
         zhonx0tfMExh3RMq2nv5od3ZftKhvwRyqv44E/OJtooTiUgEmkhsaprjomH+DEezG7
         +t8VItI9d+An8jwQqgIuYa6i93Kw2rNFSg8wbaTh4qMNXE6FfGHAKDp6BT64pOLLhV
         te18IneZ69dZ/l3LFPpTOrGp7wNtdgBzk3tldMKJqA2THuOzR/HgDLj7/W1Fly4DDu
         QIZKyLCT056OS743uyQC4bh0c7Frgv5Y/lurFh9m37rdIjgcR+tg1NLCbcvZmoBveM
         95StIrxWBDpqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A0DFE8DBDA;
        Fri, 13 May 2022 17:30:00 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220513130705.2488340-1-linux@roeck-us.net>
References: <20220513130705.2488340-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220513130705.2488340-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc7
X-PR-Tracked-Commit-Id: 151d6dcbed836270c6c240932da66f147950cbdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359ee4f480c604a2e5896a73026184fa29d36c9f
Message-Id: <165246300028.14811.6530928144615159622.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 17:30:00 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 06:07:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359ee4f480c604a2e5896a73026184fa29d36c9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
