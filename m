Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55255A541
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFYALK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiFYALG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D88E88;
        Fri, 24 Jun 2022 17:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D043760F54;
        Sat, 25 Jun 2022 00:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7B6C341CA;
        Sat, 25 Jun 2022 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656115865;
        bh=aVDBjeL2Jfbf2uNjH896eQcE7CRnt/0rfG43avGRCxU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LPuvLt4XH4aC/JPBHuC+uK0haiyrR0rRMshL8JQxIbGH1LTTimlnUdMJb89HltHHA
         1tBUBPVWgZmOx3dojkjCbFU4d/IiAx3t8wjHITsB7UQuF5/7ooisBBiigmcR57UnTp
         iooL/lVAMIeYANY7YT19b3dyaWDCIPs6GeyqlK3y4PzAIIB/clO8Yll0KuUeM2Yxsx
         3si7amYpDaiNxLnK7EiBouQsL2924yO0B1BEa5jlQByL7csYlESXyjJVny0i6KH+kQ
         qav0rzjaPYvoPLElPG+UiTzQtb41zMFqsIdVNECGNahmhbbVvAjZzkFdRYkYnkCBzg
         fLgzerTlRIlrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24F7EE737F0;
        Sat, 25 Jun 2022 00:11:05 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624231812.5878-1-brgl@bgdev.pl>
References: <20220624231812.5878-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624231812.5878-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc4
X-PR-Tracked-Commit-Id: b0d473185ba887c798ed0cd6f5abf4075363baa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c23f235a6a8ae43abea215812eb9d8cf4dd165e
Message-Id: <165611586514.28692.11372286090415449833.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jun 2022 00:11:05 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jun 2022 01:18:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c23f235a6a8ae43abea215812eb9d8cf4dd165e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
