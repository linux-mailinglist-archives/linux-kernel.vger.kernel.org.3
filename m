Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76A518AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiECRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiECRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756161EEC4;
        Tue,  3 May 2022 10:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF22260BD6;
        Tue,  3 May 2022 17:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E076C385B0;
        Tue,  3 May 2022 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651598380;
        bh=U0CBZeqndkqDdISAr6ltxVXuk5Deu1J5DRVMOf7h9yA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uQNohu/V+tqFdVrHLdwZYyeoSvIn9Rt5idrtWvpASpNA7HU054Pmh+n+BeINUGbHj
         mqeYp3HAbgnd4A7BT4nsiPbpOl/RjTqLXSoW2+4W00/Vq6uMQbVevsZVfOnJc7VhRD
         0kzoROlY37j4eUmUIo7x/ju3lAgEaqNqxh2+10epA7ZujeFRgEoRvK9DhzMFCxDxzw
         y/RMXjlEX5ibO6P+LSS92jFPuRaZ2WBi9T8O0yBBuMN7fGZvEYan3C29G9npJEUTTv
         8ceZlfhUgP7X/nNCtpejgZh3obn2jQXwWb08hdOAZiBltmfI0gc9mETSfhq++0agia
         drcO+3/SlBSEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8FDF03848;
        Tue,  3 May 2022 17:19:40 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220503060000.2839547-1-linux@roeck-us.net>
References: <20220503060000.2839547-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220503060000.2839547-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc6
X-PR-Tracked-Commit-Id: 08da09f028043fed9653331ae75bc310411f72e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b
Message-Id: <165159838023.8156.6094364623234823410.pr-tracker-bot@kernel.org>
Date:   Tue, 03 May 2022 17:19:40 +0000
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

The pull request you sent on Mon,  2 May 2022 23:00:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
