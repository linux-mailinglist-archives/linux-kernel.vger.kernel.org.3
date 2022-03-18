Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C64DE1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiCRTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiCRTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A210E040
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DD2D61BA3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8A8EC340E8;
        Fri, 18 Mar 2022 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647632336;
        bh=j4D5K4Hhy82WdYf0r53E+7WeQiz17ZwELPCQ/Brt5Hc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kOBGiu9GXNzFp988TFEhOjDI7KvYD1tm8HHbWZsBniAkdM+z6q+EvdbKYrj6nl9Gt
         8xkMY0u5KjIfBqoP1QjCJiIs2mszffH44lR2TTElI8RpMyJ+nTxTNB1nWTiEQJh30Z
         DgV1LpDZ32vbW6T6awfrD/Wel0t29buVGibP9v5mwFIMKsFBy49QM1xq8JcA4aWwZP
         NibFhLjndA1fmAMZ9eVQtVeFa5VLNqxCKLo3fivhdk8ZZJ4xYN/qchm0LpsoWMpUoq
         QSc/hGtVvTyX+jsGZN3efyATl+3HOa8IyR9oETRCWtpEveutEUjunhzgAliqnBf2so
         IWouC0QhTiBlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B25F6E6D402;
        Fri, 18 Mar 2022 19:38:56 +0000 (UTC)
Subject: Re: [GIT PULL] arm64-fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjTQQvDwjwIYQ+Cx@arm.com>
References: <YjTQQvDwjwIYQ+Cx@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <YjTQQvDwjwIYQ+Cx@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 316e46f65a5497839857db08b6fbf60f568b165a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
Message-Id: <164763233672.31275.2714082286042648418.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Mar 2022 19:38:56 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 18:32:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34e047aa16c0123bbae8e2f6df33e5ecc1f56601

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
