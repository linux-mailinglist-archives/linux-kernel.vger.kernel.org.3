Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF4558944
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiFWTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiFWTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F77C50C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF44617AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E8D1C341C0;
        Thu, 23 Jun 2022 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012608;
        bh=zyLe6wt39Wb6s3oWmYzQL/cc8t5ray/rgeaP+1Ole80=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OFGFMohyXsngDhFTxAOafHKVk+RbCeTslY8q/1nu3HxFTYNHPz1s2DjGRDFMpnj5O
         VxsyOQmXhGgGsXZqavVMZ5Qy5l24fjnpkG3mGlKPbXAq9/bf1ciZY3kRCh9/iWs/t7
         x6tGi6MPvcmiVByYUHnFiQbfn0Vh/nIyQaC9k/kJw4CTHVJYM/vVUlG8R/1rzoAOko
         g4n7KkJAwsdc2Uoyk9o+2dUQVQrEb7o2LbRoPZienYAqFJOS7PDabT4OxJphtjXOUn
         xHNtsICUar18UNj7uTPuvwdgMWiASWSAoXT5EPbAWePh2VU/mv/LE2cOyap8/q30ad
         Bi1vqcg+02hiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D6C6E737F0;
        Thu, 23 Jun 2022 19:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220623185446.1351600-1-Jason@zx2c4.com>
References: <20220623185446.1351600-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220623185446.1351600-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc4-for-linus
X-PR-Tracked-Commit-Id: 63b8ea5e4f1a87dea4d3114293fc8e96a8f193d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba461afbef604f58e05676ca38c2a599f073f296
Message-Id: <165601260804.24693.10068706609616412473.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 19:30:08 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 20:54:46 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc4-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba461afbef604f58e05676ca38c2a599f073f296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
