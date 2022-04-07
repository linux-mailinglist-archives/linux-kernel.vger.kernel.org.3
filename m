Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8851F4F851C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbiDGQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiDGQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E121AD1DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA4C60E09
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B6F6C385A4;
        Thu,  7 Apr 2022 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649349792;
        bh=G1kmkAzc/v6/a7491B96eQCfmXGwG/ELXHAQ96XDX30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tvmIQxVTCE2c30UPT+XrXsHXIWjJR5pxXnMVyHNxeNJeOulg5rud76nV9ZcfQzBFi
         qkOjZ1Y2TWCQ3wYuLuLQkM56Ihp43j0gczXzEcRkMGUwORtA64u3lGhimGJYubFyMt
         NJSAq8Pt71cyOig2PCNmSUylJt0uZNv9dsYtHbQ27d0EDWfq4KGzuYpViE8ptIpPc+
         5x8nYnpcYFjj+3uUzQr4zF9DLyIDK5yW7Fv7ODgsHmpYNnw0m5dW6/HNx+AcpFNwbi
         Qytaoky9TVwGBaXnl5yflSt2GWdA1fbmOV4rrnFuWyjMmj1zl5jV+CC70WEU2hetfh
         tOOKtGgTWpfew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED439E85B8C;
        Thu,  7 Apr 2022 16:43:11 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220407132839.496822-1-Jason@zx2c4.com>
References: <20220407132839.496822-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220407132839.496822-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc2-for-linus
X-PR-Tracked-Commit-Id: e3c1c4fd9e6d14059ed93ebfe15e1c57793b1a05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3638bd90df9930511fa85f9a811d02feee4e0b97
Message-Id: <164934979196.4180.6383045242745186297.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Apr 2022 16:43:11 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Apr 2022 15:28:39 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc2-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3638bd90df9930511fa85f9a811d02feee4e0b97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
