Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6024FAC21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiDJEzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 00:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiDJEzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 00:55:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9312E13D14;
        Sat,  9 Apr 2022 21:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D149B80B73;
        Sun, 10 Apr 2022 04:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10455C385A4;
        Sun, 10 Apr 2022 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649566402;
        bh=JRrlCrRJPitCLHB3CRBfJ2XmLdVztP+KCK0OueXHxr0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ow6QI1HUvu2ANH17so/4yHzhgHOdOkL7si1G6UCfhsvQ38Sk5NJbx8UPsmqz4qDLw
         pU4Bzx1LoTv8qKMLqjama3hvRr+t3UuHM0W4LSy3ByYoKmlhE+weq/KK3t+yoHlYJm
         ZfzkJwoISo2yKLnFvoj90iwKpmwCIJNchhFuWJb/ZZqKwygpMCkCEoVozp/U0L+NIR
         8xhlt6HjF3J/wThRJaHaDJOf/dXwWamaAGRioOLRak/9z21epzKd3EMatonjWCoADj
         t1oJwtduWh9QAm1ifGytyKbw1sJSbzO+pBiq//kq25rf4M/74+vDAY/Vk4w4jLXHDg
         cNHjy9i/X3J7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F20E8E8DD5E;
        Sun, 10 Apr 2022 04:53:21 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220409205134.13070-1-brgl@bgdev.pl>
References: <20220409205134.13070-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220409205134.13070-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc2
X-PR-Tracked-Commit-Id: 5467801f1fcbdc46bc7298a84dbf3ca1ff2a7320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa3b895da8e06d6e3dcf3e6941a3fd428343e3d7
Message-Id: <164956640198.12943.3531936140894712927.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 04:53:21 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  9 Apr 2022 22:51:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa3b895da8e06d6e3dcf3e6941a3fd428343e3d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
