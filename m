Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB95776E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiGQPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiGQPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2B13E1E;
        Sun, 17 Jul 2022 08:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107666123B;
        Sun, 17 Jul 2022 15:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76607C3411E;
        Sun, 17 Jul 2022 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658070385;
        bh=NZyPWJOLyN9oQRkPX94g86JN0Y1/kzbyriouw9vNRMg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L7XV0CB5/jYlEnHcO6rxl+s5D0m/vsEKKVLVxt9fAVb2RBsZOh9pnT8Xr2OUNvhAl
         ZfvIGOqkE5K7Hduux115w7fBjqimz+5m1kkutD+kDusZd59Y5zoLhs2Jd79DW5nEpm
         RYjma1kfymOJhk+6FD1m9G5uazDbgKpjsw6K3rOJ1DD/A7J4T/liy6G0QoSVJBic9P
         e+UXojrRsb16l+EL9N3iLi7zxEeEiMKypg6r3dJs4vm3zZO2/17ZgidSTxhmV4KhS/
         5U2RHkT5plVaqpWPu/dT8xdbr+LKaBnLF4sMQoCPewJhSwDnmoQ1KV8fv5jwFX+G9X
         ZAGYvwtH4BUdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FB77E4521F;
        Sun, 17 Jul 2022 15:06:25 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220717073602.4801-1-brgl@bgdev.pl>
References: <20220717073602.4801-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220717073602.4801-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc7
X-PR-Tracked-Commit-Id: 7329b071729645e243b6207e76bca2f4951c991b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eccaca7b62b2836260c6fb22156a44e3d99a74a
Message-Id: <165807038538.25191.15947983563428396889.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 15:06:25 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Jul 2022 09:36:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eccaca7b62b2836260c6fb22156a44e3d99a74a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
