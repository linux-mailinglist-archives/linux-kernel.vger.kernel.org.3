Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549644E7E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiCZBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiCZBBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:01:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C655496BD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87841CE2C23
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 00:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0297CC2BBE4;
        Sat, 26 Mar 2022 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648256383;
        bh=/Q9VpfpcWnMk9MjFYLSoqVj6gorSj9cMvda2V+ytNi4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BbQ8yEy89meNh14feOQwdT7CzPUZ4WAKy77FAyqIUZfWYOTEoqpE9FCaQZB11LKUQ
         7Zp/OHad48+I5ZUWmpfXpmGzPFn30zyO8/2Eitr2Sy9I2aOI+JaSi3fKZYlVYmubcs
         uucc4aVBhhWgsOMoUQcUJ7ZQep32DiJ3RzIuNuXpwsWakSHlqOHVOc4oIkYvvivukO
         rZn43dkSg18xFeMDBg/AbEMoM2/6Uvw1/9nmRXTLO1Eq4+ehaLItKavZjJX14XHDtu
         rEJ/qV1sxsx1aJnqY3071NBl2QT+X/ZL/Cji6Yy5v3MYEbS5eBSBY/+c0UIBxuXemS
         hnZ/UUtsDk4yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5DCEE6BBCA;
        Sat, 26 Mar 2022 00:59:42 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220324172941.GI3457@minyard.net>
References: <20220324172941.GI3457@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220324172941.GI3457@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-1
X-PR-Tracked-Commit-Id: 8d10ea152e2fb9b4a42b282cb90bfc4d98e319a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52d543b5497cf31d6baeb0bcfe5a5474c3238578
Message-Id: <164825638293.25400.17727938399988511631.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 00:59:42 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 12:29:41 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52d543b5497cf31d6baeb0bcfe5a5474c3238578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
