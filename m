Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C74D226A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbiCHURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349932AbiCHURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A05130E;
        Tue,  8 Mar 2022 12:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45BCEB81D5E;
        Tue,  8 Mar 2022 20:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 082D0C340EB;
        Tue,  8 Mar 2022 20:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646770570;
        bh=UET9JUnGo2TFqvGUJxqNHq0Mc0f6+oonLVedVCPPto0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vuol1LqvJP9gJvWfXPbmB870zm0iP8slirXcgDBRslBzD1hnruyFTosOpGglMbAOG
         vR+ma5244L8gmU0ug8RTzWVTA8ov2BmlFvK2xDqU18UTPCQae7giXPXfS9+6WvYmMV
         U/OXm9Tc+fJHKArkGgIPcHhTGtTKzVs1BiAW0yL3vx/WxJwQzZwMjOfgAG3N7vfpTp
         PSPGaxV3Bi5qti4L1wS+MqhzU8d6oBeQ+QKguwZ8Un3iD9rCRToy/EPy6AfGmNQdBk
         zlFa0ByainWs88LPi4VO/QKjF8CWNIRQttuithOhzgMmTlj3sQh0B/k17l2rtGeh46
         7gh9NjXgkrh2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8045E6D3DD;
        Tue,  8 Mar 2022 20:16:09 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.17, take 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YiexypCIC3q8dHPZ@robh.at.kernel.org>
References: <YiexypCIC3q8dHPZ@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <YiexypCIC3q8dHPZ@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-3
X-PR-Tracked-Commit-Id: f6eafa4022dd61e029205bea4d4147d26e69fef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f86a6b46e5377a300b1d49f51c687450f72fb6d
Message-Id: <164677056994.13922.3321050391472310921.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Mar 2022 20:16:09 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Mar 2022 13:43:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f86a6b46e5377a300b1d49f51c687450f72fb6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
