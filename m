Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196364EA2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiC1WPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiC1WPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2AB12AEF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37EF8CE1110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1B01C34110;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648505172;
        bh=6CkzV+45c1vUTwoa1WAkMHX70DW/Tzm7r0usSMgtqOg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ACQC3cqShdGmP36EUQf+Y1cGyyMS+Pt+UPvvbdSkYmGoZHMpcnoHKFTu3TqCNQ0vZ
         G2Plf/QGd3vuiqPPaF/0jGfYoecDi36Sqp7py1rNPGS9OyFBDmvuQ1I2IAxoMrAOjA
         8zICiu6pMa/7imS1rL8v711ToYMt9k6KKrC5jmMUVcTSBqpEL43/MKG/mT/q5tqD63
         W4d8t43GE8yrwLDZpMIDHE2KbqM053QI7pQCt57SUnEnX3Jpd9ULwMsJRAgF2cQv8A
         6UNMuCcKdj5EcFqzRawyJ711OR9ptem0IwWsnYuf1na2oRQBXozRtn0WNUi2HIX8vf
         VGcdLbtNw5Pzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EC75EAC081;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220328162333.4jwaiwuv5knxh67l@maple.lan>
References: <20220328162333.4jwaiwuv5knxh67l@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220328162333.4jwaiwuv5knxh67l@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.18-rc1
X-PR-Tracked-Commit-Id: c1cb81429df462eca1b6ba615cddd21dd3103c46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cffb2b72d3ed47f5093d128bd44d9ce136b6b5af
Message-Id: <164850517258.27348.1811255820678049813.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 22:06:12 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 17:23:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cffb2b72d3ed47f5093d128bd44d9ce136b6b5af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
