Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1E4EE180
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiCaTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbiCaTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0DE239337;
        Thu, 31 Mar 2022 12:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7624C619A0;
        Thu, 31 Mar 2022 19:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCC6CC340EE;
        Thu, 31 Mar 2022 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648753967;
        bh=uDyNBjEF7PaH09wbRXFm8lyjBRNLFNyqwu53PDdVkn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kKLGhv+hr7CPl7KKP2YoJEjfOKgvJujqXJe8nV30g5E/cuOJCcZldRrzvhxLZ2+pO
         sgZof/lwMQBuTMw8cVYRZtxlsiAQQcGALrkF0DLW1h81mMgjeZDbbZ/s8CXAJG1umZ
         PkJRUeRJ3t1WyjQIOaIgzKexIBPC7AdF0BQ9c2e9wYipUM4tRwnaKfY+as95jcn+el
         rzZtZ4WeUaLUCVazXKJy1OwpeHnIEtCN7vOHQDKq690WDRIQObx8OMEaCv7D/er6vr
         0zx3FGGSO5HHow+vIpddkiCfe+7NGCHnIzIBC7J+hNweJOCdKk3mKxUiZhDfwRS8ee
         HOrnOt44dRxcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C811CE7BB0B;
        Thu, 31 Mar 2022 19:12:47 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
References: <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au> <YkUdKiJflWqxBmx5@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.18-p1
X-PR-Tracked-Commit-Id: aa8e73eed7d3084c18dd16d195748661c7e881b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93235e3df29c084a37e0daed17801c6adfce4cb6
Message-Id: <164875396781.22373.16661691261433119146.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 19:12:47 +0000
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

The pull request you sent on Thu, 31 Mar 2022 15:16:58 +1200:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v5.18-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93235e3df29c084a37e0daed17801c6adfce4cb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
