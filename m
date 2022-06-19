Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9E550B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiFSPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiFSPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1964FC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C854B61195
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 393CEC341C4;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=2ZVzM3z8iZolsJPDoMOfwFGPSkID4j0K2DXKx1zpSAU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qwfHGZd4+VoKLfzQi7UbypvXCRhTJX1e1Vjx88TUKl2dhN4UN2PZWPp6ytXXhshV3
         ORQLmljKInU7JuK46+N3x0wZf/3aaYQtWviG4hWfigbKplkIVvbOhdnhESuRyBhiiV
         umdRep9XvRC2W64xkfX07YHaEnZMp3faJN0z6x0sQhmjdN9uAZfQn6lj4DRzU65ULZ
         bTPyZXaiChCYYLKwLLMwJYZMJYv6PwMUqm14JQw2z8PI9F8WbkpXavmRzSYzMK5vk+
         hMNZCiuhruAJiBq9wzf3+fjULUd0VQjhrcL+Ir77innfKARAlmIGyHSHBfu1VbvYTx
         yUs1TOM02wVqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26EC9FD99FB;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3 - take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yq8JO6i5zqhZLqa2@kroah.com>
References: <Yq8JO6i5zqhZLqa2@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yq8JO6i5zqhZLqa2@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3-take2
X-PR-Tracked-Commit-Id: 928ea98252ad75118950941683893cf904541da9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc94632ceb4b4af47b2c86f8f11177884821fb94
Message-Id: <165565088715.16911.7332133790070796913.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:27 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jun 2022 13:32:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3-take2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc94632ceb4b4af47b2c86f8f11177884821fb94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
