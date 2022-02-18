Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE34BBE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiBRRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:40:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiBRRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276E8A30A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2499AB826B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2C55C340EF;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645205999;
        bh=kfqbv87H/SdcLeFLQTEURiMyJIoz4Fg95hFn1pukFwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CqN7/9vaBZdgCuNUFYlRxz9zK5rpZ8mqz+mT/7S6Wwk9w2IkVNqbNr8zy+cCL8dQJ
         HuhAo6Ex7BEuLFNNS+S4zFhhXsjhkeM1outKiufSG+enJRCMQWUGCFUnboelBYBrKG
         W7kNIO1cggUl6rxM/FQl7D8QTRSX3JtL93Qf4FAZUbb765hjEex7ojxQhf66IqwW2z
         Qis0itKT7OGr1xR0OXmFv4TP1rC/T07fr2YAP169EON/VJZoAHvO9SPvoLRfd1IvEl
         or4YkuTX9XBA5K6HA1QpIMleKl5Ey+boW7VLxHU05r8keHwqdjg6ML4B2RTjsuR35U
         ZTHVtHNKRLKZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2145E5D07D;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5ypc5rf9.wl-tiwai@suse.de>
References: <s5h5ypc5rf9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5ypc5rf9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc5
X-PR-Tracked-Commit-Id: c22a8086b384025ab97ce07465420a219697d3f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2848551bc6590a0f4eaaae71d60a4aaa0e99b8cf
Message-Id: <164520599972.19024.11956211959614117504.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:39:59 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 12:45:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2848551bc6590a0f4eaaae71d60a4aaa0e99b8cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
