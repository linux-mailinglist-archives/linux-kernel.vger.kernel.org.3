Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75B562141
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiF3R2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiF3R2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3366205EC;
        Thu, 30 Jun 2022 10:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC4362169;
        Thu, 30 Jun 2022 17:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B0F4C34115;
        Thu, 30 Jun 2022 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656610114;
        bh=tUYJESFZcL9zAPBOX3yLa2RjD8PyCujISGXkfEXN+9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s+RDmODDpEGek41QPITo6IoBLR+Sc2ScjI5wzhhwvfFrALCeWLwU569Yj0o/nIwxb
         DFA6kwe8MzR55apWXuLfYNTPPm1LRDi3VKQApuhbcdJzk1/Sb9Gknp3oVO7/3NHgPs
         ThiCHW4JTlzuawcVgz6AqJIEgFvOkDIGu5kDMBi2C3fJ6E/Kd0GqcaNVz5MkFzzMbG
         qWglcsaYL1+UqbVmZAwda9IdTzUpMQwO93n4HGqwaaasU8b9PFcHH1V9JQWO76jf+d
         S5PEkRLPnrrWPloMN7GXd5HSAoGv8Du7AWiUqQ2yZPv4Vxf8shVmxrp3xgzMVuyIor
         qU6ymWxMSgJ+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68486E49BBB;
        Thu, 30 Jun 2022 17:28:34 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
References: <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au> <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.19-p3
X-PR-Tracked-Commit-Id: 87d044096ea62f1f230e8c4679ee8abf03266f64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5da5ddf81ad0bfb91fa5e7d087e2ad96f26b7b7
Message-Id: <165661011441.6493.15300000467947229478.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jun 2022 17:28:34 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jun 2022 15:56:44 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.19-p3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5da5ddf81ad0bfb91fa5e7d087e2ad96f26b7b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
