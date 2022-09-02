Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6B5AB836
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIBSa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIBSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4B58DD4;
        Fri,  2 Sep 2022 11:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42D07B82D06;
        Fri,  2 Sep 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4F94C433C1;
        Fri,  2 Sep 2022 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662143407;
        bh=fPTOYsY/aQ4XYnEtunBVsdoTQdDZO9iQJvgnd1sZsCQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HctiSs6E+5cUtRYjmpBZtRpvBXYeyHjEu2evkGKNJWmc033EO0lygNM641tKsRW26
         9ISBRmbSNpBUqi3Yh0+VD9XxGyAjr7RJndFVyPh3yC69ig8sR9bgR/YXME36p03aBs
         bswVd66cc6vo8y3LAcPYC6LnAgLvJUdgFQFfHs/7HPFdBUauqodwbcTl0RX1+SLief
         juxHUEbQjmnyDJY7/cuX92Y7QgfkJUvrGaqAGjsRh5RNXHr0mWqRnAaExz0vZyQKFM
         Sx4Vd9F22g30qOsdlnr1LXw5lP6Mbd0NHjzgnjl1WLSzPSHd0a+zs+JcD9wugAnnFj
         kG9rXSmHet5aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D19EBC73FE0;
        Fri,  2 Sep 2022 18:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.0-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3766fb4c-d7fa-564c-abeb-c746cdf12526@redhat.com>
References: <3766fb4c-d7fa-564c-abeb-c746cdf12526@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3766fb4c-d7fa-564c-abeb-c746cdf12526@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-2
X-PR-Tracked-Commit-Id: 647e82dbf85124697be59a4b4cf00c0d38177dcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a2f6a3722a7c127817af24efb309e5bf70afe36
Message-Id: <166214340785.20636.11027527328160784886.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 18:30:07 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Sep 2022 18:43:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a2f6a3722a7c127817af24efb309e5bf70afe36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
