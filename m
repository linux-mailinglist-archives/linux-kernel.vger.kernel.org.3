Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE14AA140
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiBDUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiBDUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF1AC061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408BC61545
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC7CEC36AE7;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006879;
        bh=OxEV4ko9JBvT+QzexsW/RLixonuarOEOimOpxDwyki0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CkGlP2H9qK9RoaAgui0wEOi3XJ+YG54yhfObdwdFlIr4akL5CCWD4LjZ1FYvCBhM0
         HKB+0N1kWIys+BIOe86y0Q2gUwma8WsQFxyoOk1fikM0widvZ8lcYv5OvH/z4VACvi
         t/DiNL1xEFlcIblpuIix7eEioawnLrOLO5NNrw63Wh8o4zqtanZRIoPU2vTcPC4S5c
         T7XrBNzrSBpUqK9NZOgdKWQ674hjRwPzakRbbM38wii8hwng7UgAD021Xraw9OESOo
         OC4dwMM+Qt+p78if1HJRlmHrZqBcWfSdAoG6YKKvBMZ0K6kIvKTsU6F6swkxNZSJG+
         4IC3QkrJyTzyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98309E6BBD2;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220204184242.106531-1-Jason@zx2c4.com>
References: <20220204184242.106531-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220204184242.106531-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.17-rc3-for-linus
X-PR-Tracked-Commit-Id: 9d5505f1eebeca778074a0260ed077fd85f8792c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba6ef8af0f3be2e0318aac7e6e43d3a04a069a6a
Message-Id: <164400687961.31755.1917563584044569280.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:39 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Feb 2022 19:42:42 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.17-rc3-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba6ef8af0f3be2e0318aac7e6e43d3a04a069a6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
