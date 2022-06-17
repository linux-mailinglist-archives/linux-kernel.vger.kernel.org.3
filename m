Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8684054FA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383123AbiFQP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383126AbiFQP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027D3B3DC;
        Fri, 17 Jun 2022 08:29:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D337B82AE1;
        Fri, 17 Jun 2022 15:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA2CEC3411B;
        Fri, 17 Jun 2022 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655479751;
        bh=e/s8Nf7AJhMiHMWzQtUVQBsG2ImOoRhmQKwhBeMTXLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VwwrCvEj9i/3QHQ9UbFxqgrwNcWY/aHXstE0antK7kjODN5apjAsJ3qjkbHJy7gEJ
         +/iGDhsNgCiqGq5+ffhp8XZDTH6blu3IJk5JnRQEUHPXZ4JwaT7EI4fgM5hwnORr+w
         TdDq79mgaoZFJbPiWdwVxlktIXypiHWcgV8J89ntRQjQz9bBfbLTx+QYoWToUCcHxh
         Spe0YZzWgbMdLy7Ntze2HFvNiwdih0ovw3dwwZFl2BXL2gv1NPwWPA/b33FeM6orIY
         cvkrBac2ELb2SJdY7a1A03D6zR5+fA9zjh8wpxfsl30VLjEeP3ZaXZERu4A1ajSMHR
         it6zsvS+jagUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5003E56ADF;
        Fri, 17 Jun 2022 15:29:11 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
References: <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.19-p2
X-PR-Tracked-Commit-Id: abfed87e2a12bd246047d78c01d81eb9529f1d06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79fe0f863f920c5fcf9dea61676742f813f0b7a6
Message-Id: <165547975179.32273.12656642641011485398.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 15:29:11 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 16:29:33 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.19-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79fe0f863f920c5fcf9dea61676742f813f0b7a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
