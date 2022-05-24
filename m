Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0B533200
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbiEXTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbiEXTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C578935
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F53A616E7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4EA7C34118;
        Tue, 24 May 2022 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422005;
        bh=JOzntZWjokUzfIQzPasLQjKkxvWVj9aE7F07KQin7Us=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AQAtDd8pge7QEx/TL46i48yugZGvKYD/gm/8l2oljG5h0GAhvTJAWTqA0b0GNzdTW
         osOlHnp08hCSqF7haXS1ljQINLIghXT1G+9HiEUuhvAHr7lHf+W5U0cOKw1zMnlPrr
         lLMKW2Fv/XbUpG+xY/NYPdMQrO3k49aNUQvs7kLtJthbNXl77qkBchJCmnUv+XhWmA
         Lrp1G4qRugceDUFw4CPUaaUaJtFmImeUhiHYwL9tNQTf9WMSlEPy0qw4P6IKwwNujl
         OVwFjrhbFtlsoeGi4KbHP629vNskkFrGxEoMAeoc7y+QHZDPO5QcE4pibDag9jabNm
         IE86W1/Q03xew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE03AE8DD61;
        Tue, 24 May 2022 19:53:25 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220522214457.37108-1-Jason@zx2c4.com>
References: <20220522214457.37108-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220522214457.37108-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc1-for-linus
X-PR-Tracked-Commit-Id: 1ce6c8d68f8ac587f54d0a271ac594d3d51f3efb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac2ab99072cce553c78f326ea22d72856f570d88
Message-Id: <165342200576.18932.1593043767652357259.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:25 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 23:44:57 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac2ab99072cce553c78f326ea22d72856f570d88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
