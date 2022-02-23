Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602B24C1CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiBWUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiBWUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05C4C7AD;
        Wed, 23 Feb 2022 12:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B16D161729;
        Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D083C340F1;
        Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645646898;
        bh=+v9dPdclb0VGqPcnS02hTI0rZ+j350lUUywsJAyGNEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hq4vSx+ouvROdcmjR72HdC5sr1yZw4gjViMxUyDymDkl4F+y6fxulNm1jzT9VxpK+
         4aFumAtxvtfhbDATgASTbzJjnnxNsbqjN/45xZNB3to5GXDrF67FG8Y+t9IlR8/4PT
         p/2ss9l8ubJa761W9NiEqftwztY2aUu0ksBz54Q2mF8qICXwS9ducJiLcEgLpSsvkf
         WTyQkUZE9QB/5aJglHPNVMNW+DbysWj7VH01YdPUfc1m2t/CtzpzoMHIANeJZJQ9Y9
         aY2JSc1aPvzLBKNid2OXQ6lWc+uIJdC/gaclGQekPUSF4xbAEG0Pf1AMNjGZRLl4SW
         aAxA1aEi6XcgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CC63E6D598;
        Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220223150012.2176490-1-linux@roeck-us.net>
References: <20220223150012.2176490-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220223150012.2176490-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc6
X-PR-Tracked-Commit-Id: 35f165f08950a876f1b95a61d79c93678fba2fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f5738db96ddc3525de21990ed569ef43e05f42d
Message-Id: <164564689804.4348.17601764579997477011.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Feb 2022 20:08:18 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Feb 2022 07:00:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f5738db96ddc3525de21990ed569ef43e05f42d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
