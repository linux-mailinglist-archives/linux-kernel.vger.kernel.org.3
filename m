Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA63533382
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiEXW1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbiEXW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3D35855;
        Tue, 24 May 2022 15:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28FCDB81B89;
        Tue, 24 May 2022 22:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E27B6C36AE5;
        Tue, 24 May 2022 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431257;
        bh=EVLhcI3nTTHBdnbs81/n4xNy7Kq6g7ROnAa4U0ui7YA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DdntslbgOylp2lcRP1QonaK73RsXnycXwiyUPH4X8HR93vqGAbWB4ATver6zqOswO
         tYxaoA6T7wRH3u8YiVa83Lzwt5L5kHQkjuwjcumRrLqNzgPx0wW/zdcXcYaEZxak5m
         5FQsBpz7h9KACyfI7J7RHztwN9o7Ih7aDGR2cZwrlOfCGuZOQYuZHSJAE9SfPzUOyR
         fjGoXAixrJi6LVowAe7eHaSI9qxqGB1/KIM7BAX8DV6CuYeo+0tWulwJ3A50ywSwEz
         ByslPY00zSHuKmWh7VhIYUJuhnmP7/XPZ2DSJQS+aMNPGY50eo+mycalc2HisP0zQx
         6eDUcYef4DKTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C485DF03938;
        Tue, 24 May 2022 22:27:37 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523131250.90060C385A9@smtp.kernel.org>
References: <20220523131250.90060C385A9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523131250.90060C385A9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.19
X-PR-Tracked-Commit-Id: 9c63b846e6df43e5b3d31263f7db545f32deeda3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8e0f976f104a0258c0426b3805b057411cd0bd2
Message-Id: <165343125780.3997.12946616294694080663.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:37 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:12:36 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8e0f976f104a0258c0426b3805b057411cd0bd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
