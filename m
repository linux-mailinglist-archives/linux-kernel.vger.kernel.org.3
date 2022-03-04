Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE54CDE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiCDUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiCDUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59D151344
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95856B82B8B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47553C340F2;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=ytGZY9VItoWDUzY9wExvq+MKYgXA96wESg6XX13ZWxw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QZHODvayfQtw3ULjF2BYU4UP7Q5MwyTl8HfgMnJzPSszZV38ebA/UpgWWwtGpMs/q
         7xIET6EeIIwaeK1rWzsXF7xvGTE5wPZCmUgQ94JQK61UiGAF2tmuut0IKl4Szf5PTo
         zo1lf+dfh/MPDVXnxvJ2frak17Rb1x7ffeQquuThP48AgH7RSr1lYS4H54eGTZFrIO
         H4C2BgmU7OpI6f22mkhnkCTvVUOXTmeMxE/+EgHhFvIshk205Kh5/eYoMuFlCpa8GV
         /Utoz2xn4G/dijs0LQo/+KMwxpH010H5Ms1EGP/7FmDr8Ebk5kgVbe5+uxLLx3bv8+
         Rzmz45TwV+StQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34451EAC099;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ho82mrt55.wl-tiwai@suse.de>
References: <s5ho82mrt55.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ho82mrt55.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc7
X-PR-Tracked-Commit-Id: 0aa6b294b312d9710804679abd2c0c8ca52cc2bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d670948f4d6d372935b7dcf9f7db14548859b67
Message-Id: <164642532120.24805.10120001757678167310.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:01 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Mar 2022 09:58:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d670948f4d6d372935b7dcf9f7db14548859b67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
