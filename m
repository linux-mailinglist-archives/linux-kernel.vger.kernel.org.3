Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012FA58A490
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbiHEBuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiHEBuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB272EC5;
        Thu,  4 Aug 2022 18:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DCD561884;
        Fri,  5 Aug 2022 01:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C891C433B5;
        Fri,  5 Aug 2022 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659664204;
        bh=pmU8tjUJ9uZr3KXi6j2extww3mtUreJqOFcd09NjOM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GSr1ZPYar7JtJ70Z8+uFfzw+q2qhPFmQj1vz7S2jZFpb5QJxAvs46i7Yp26jDKM6X
         6w0leV5vcoVOHDpztUVHBw7UAEXOXI0jwZTyChmF7/+xAPn+lHWFbcfcsITHMTJfYC
         Ph7xLN2eFIXyJZZBF7NrJuFEmqkp6JhA4bEvmOUUgdTPJXUVXIxX/nS57V6x/pKMzo
         gfFCL9KhaA8nW1zZnTN3hxfajK5ZqXyyp+7ZObe5ThEffBbu548n4GAwv+iDmtASx2
         RJLexZYpZOPA9W1ZxOvAqu4rlx2F2NBIjSt0etShAt6HgeLxv8DynRm5X6oZuu2qFs
         Q19PK/3u+Q5OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B052C43142;
        Fri,  5 Aug 2022 01:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804124103.1088581-1-brgl@bgdev.pl>
References: <20220804124103.1088581-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804124103.1088581-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.0-rc1
X-PR-Tracked-Commit-Id: c4f0d16daa6d1c5d862d063379c03310387095d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37644cac6e8297d0908aef054caabb439c467c7d
Message-Id: <165966420402.23541.16954063899419724442.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:50:04 +0000
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

The pull request you sent on Thu,  4 Aug 2022 14:41:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37644cac6e8297d0908aef054caabb439c467c7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
