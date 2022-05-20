Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1E52E4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345773AbiETGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbiETGKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972EE14C755;
        Thu, 19 May 2022 23:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 248EE61D92;
        Fri, 20 May 2022 06:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86537C34100;
        Fri, 20 May 2022 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653027016;
        bh=+g8bHb2ilbuh8waM+HYF0p83yeXeOKZUATDuTJKYzKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Idy55GefI4ac6/SHeU30qdRAsd9T8UPBNPrBsTOHDBUiSdRCRd48J9pLXOmsPwYU9
         gzzPq7LIikMc1Jft8nXQ2S2QHGnxGJHAn81lu2ipnXHJaizUzdTeOHyE/MNRIIkhtP
         Tx38e9hpqo1+gv1ZVJKiMbAv1W56FXVn2hJB5t1rkSXBQb2a0/2cHP4E8dg7eXZ+Dh
         SWweC3XtthwO7morsohtTjZtz1ctjKi9WclOov/fNBEB7pWkwQQrlzwL2tCO7zCE/P
         jSFx7hNxY/K2D+LctLAHbVTCx8cao/gt5wbraXWBApAtXgb+/WKdEUynas8dUYw/mO
         lcyWTQUzJvyGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73025F0383D;
        Fri, 20 May 2022 06:10:16 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yocp8BaZacpvwJEL@gondor.apana.org.au>
References: <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au> <Yocp8BaZacpvwJEL@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yocp8BaZacpvwJEL@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.18-p2
X-PR-Tracked-Commit-Id: 16287397ec5c08aa58db6acf7dbc55470d78087d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d7285a335edaf23b699e87c528cf0b0070e3293
Message-Id: <165302701646.26960.7262335626261692818.pr-tracker-bot@kernel.org>
Date:   Fri, 20 May 2022 06:10:16 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 13:41:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.18-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d7285a335edaf23b699e87c528cf0b0070e3293

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
