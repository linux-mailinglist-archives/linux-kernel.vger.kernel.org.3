Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D851DDD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443905AbiEFQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443890AbiEFQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5B4551C;
        Fri,  6 May 2022 09:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF4D62031;
        Fri,  6 May 2022 16:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57691C385A9;
        Fri,  6 May 2022 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651855680;
        bh=9Or0gQpn6XgC35VPDTr3Yn7QwZGrlv7Zlr90vB8qbjg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xi4/mVDtitzPDXNBYeANtgt6CFslc9arVw7ONfXQEMWfeqBEPlU1VUCuiR0kgNfNI
         Zot3CGd4jEFCAEsGFoEIgMQQscXuSEBJLrR652MsnFpQnV3qvCTOqP6qMZ0AXoq9hp
         dS2KqKemmDsr2OmNDYBdlmHz8mq8XGAM4I0XRY5G7dt/dqAS86WcodGW0PecrgGj9l
         jObIuMK1FIv3gW6ywgkZuNCnfe3Cac5VyQ1xe5e5dmtgaO5kGphKDVOOZkqt1vZFfa
         0scjYWp9ac5EBxjkbULFSmPsM8ZUzkMmX25GtfbJKQ4RRuD9ri0UO9timnwzbmAdU6
         i1HM1N2RIRNdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 423B4F0389E;
        Fri,  6 May 2022 16:48:00 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220506084238.279365-1-ulf.hansson@linaro.org>
References: <20220506084238.279365-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220506084238.279365-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4
X-PR-Tracked-Commit-Id: 3e5a8e8494a8122fe4eb3f167662f406cab753b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64267926e01b06f43e26232722fb3dc3f4819823
Message-Id: <165185568026.1698.9469184276486713504.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 16:48:00 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  6 May 2022 10:42:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64267926e01b06f43e26232722fb3dc3f4819823

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
