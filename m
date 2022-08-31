Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18645A8425
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiHaRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiHaRUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:20:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6C32DB1;
        Wed, 31 Aug 2022 10:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC849B82209;
        Wed, 31 Aug 2022 17:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A52A2C433C1;
        Wed, 31 Aug 2022 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661966404;
        bh=PTI3pquDblLkkQUGtkNM6wHryacO2lN9/Uf5YsR7VMU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CYxp8Jp2aGnetKhdKSIS0sJhaWvqVjWXzuVPhAyO1AP4lXDzwD27l4xPPciGL/NTG
         CLbJGrBpf4oWswvDUikdWyIyL1DhQD7j+GTqMvFDW48uuwOfawy+VgFv4sxhxQT9mF
         002pqwo7KCd3HPWEsybImtUIThjzpOum+hs0l9lEDOsm5iNeK57byGt1jBU/NzszYF
         yzL7Yp6SaYthLBvAgIlipWAfv1SDv9htyOwvuOT5GJDiG9VV7sd3ODVyT/wGw/DOGE
         PS21JUNacoi2wyYxmPDEhJUmgh6tGo99sLucdfo8MgIar67bhWDbhYjre9mf6YedlG
         ezTo/sUcz7m2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CFA1C4166F;
        Wed, 31 Aug 2022 17:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yw8iAwgcPuBpGiGM@gondor.apana.org.au>
References: <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au> <Yw8iAwgcPuBpGiGM@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yw8iAwgcPuBpGiGM@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.0-p2
X-PR-Tracked-Commit-Id: 874b301985ef2f89b8b592ad255e03fb6fbfe605
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2361d3841fddffdd4b495a4510c507f0b8f17061
Message-Id: <166196640456.5039.7025978141773120093.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Aug 2022 17:20:04 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 31 Aug 2022 16:55:31 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.0-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2361d3841fddffdd4b495a4510c507f0b8f17061

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
