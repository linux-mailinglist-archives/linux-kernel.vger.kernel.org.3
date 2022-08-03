Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A515588539
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiHCA5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiHCA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FDB4D16B;
        Tue,  2 Aug 2022 17:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1474B82029;
        Wed,  3 Aug 2022 00:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D2AC433D6;
        Wed,  3 Aug 2022 00:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659488260;
        bh=7uos+e2oUNx7Mbbre5RHKEoAotCc4pHCrRF1RuUJgRg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TTlBKJZOpQ6eFx6vVB2vVcKlUbbpmcA3uKpe8sI/m/KKjNnAlQR4A7MywNYMu1aEJ
         e/uKmE/gCCaxNvGDBHm/4pdbvATddEqKKPSe8+QN3BD49dPQHWeS/sQEmZHLRJ2Sen
         GvRDskt0uPRFQotFdp7du3fuMYtOobnVovaHGhXUhUiLLL1vmxRkiWSEwVwNPev5yV
         REI8G8DKz3BhE9MJQTvwLQDrEw+gUHrBsAfFm+dVIBgD5yMszsnvdTgIjJDrfbuxgm
         5QeTjemcXrXgg0ZPqX5W2erGaIBMakcnvurEMGF3igHAVPy8LRC0NDeaiULWmodO39
         Xtea2bKdnt/sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6261BC43140;
        Wed,  3 Aug 2022 00:57:40 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
References: <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.20-p1
X-PR-Tracked-Commit-Id: af5d35b83f642399c719ea9a8599a13b8a0c4167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2a24a7a036b3bd3a2e6c66730dfc777cae6540a
Message-Id: <165948826038.18250.7000517425956638332.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 00:57:40 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 14:05:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.20-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2a24a7a036b3bd3a2e6c66730dfc777cae6540a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
