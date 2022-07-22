Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999B57E7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiGVUIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiGVUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A73AF70E;
        Fri, 22 Jul 2022 13:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3BB061FCD;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42F81C36AF5;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520478;
        bh=0DntByFR+CmI2YlloKu0HUBT113Jm7W6wPnaKTJtsbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NKcBoS4a67d5batP6leDoee7IgtoAABkaHsCofQG3oY6cb355NL5ZB2scilZ1oadV
         tcitRxxivjCWzY6z2oJI9HlHOWdrvmuITCA3zSrz8ZhZhdKCI0oxsuWdZD69wREZey
         MHJHD2ermaE23DljNSl/BT1UPxUWTmAwTVEYLzWpciMbQh4gdzIUtmo/t1I4N0m1u7
         W3FTc9MdVwxipStm2zAkvcnlY4oMc9P4rRl9HVyyOdKGYd5bxmSVdA1IK2P4a8sVxD
         UvKigwpFsKqsSqH6mImMk4oIqTNBgbfsMYPXroDxbznetHabxX+znZ+3w2MCRrAY41
         lwRa8LxNnbqlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2930CE451B3;
        Fri, 22 Jul 2022 20:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220722153344.151561-1-brgl@bgdev.pl>
References: <20220722153344.151561-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220722153344.151561-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc8
X-PR-Tracked-Commit-Id: 32c094a09d5829ad9b02cdf667569aefa8de0ea6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f8e4e10434e2345c1e929aa93919808f99ba66e
Message-Id: <165852047816.15752.8822314857302768925.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:58 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 17:33:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f8e4e10434e2345c1e929aa93919808f99ba66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
