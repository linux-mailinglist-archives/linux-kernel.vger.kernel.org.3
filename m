Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB34E3435
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiCUXZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiCUXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7373134B531;
        Mon, 21 Mar 2022 16:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D23A614D2;
        Mon, 21 Mar 2022 23:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0348DC340F0;
        Mon, 21 Mar 2022 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647904725;
        bh=ge9/KE0MvPV2x4BOJKi7lxKFuT0TDOkEUBeJ1gTLFTI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jESsbixbCw4x2xf/+Da8jgRr+MXdwWKADpN2Kw6DRC7G7dH0na+anH9Yr3YCjc9gy
         mxqX/9uCa81UrhkgjL6dTYbwgP9AbVP8ZW59L2ijm2Sgc9uNLn2+PvndGhrmIs7HRB
         jMX0W5LxTimtj0J+Sbkh47kAEbehjtsYH6+/0SlucU2qn7OqV5LT2rMGaWBzd4l/nZ
         W/54NuBNZVgq+Y9/9JjeGsWbU28bivfvNgYk+PmNCSAoKqEzTpF0zSM9C74EnRz8Kq
         yU1zDPnJYAoJ3/VucG07Q9D1SPJucgJDf895KjGd98AiME7xIR0Z+JAS4O8jAk7J6G
         uX+An6v/2cdQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E60A1E6D44B;
        Mon, 21 Mar 2022 23:18:44 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yje766s7fIqYg1Tk@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au>
 <20211102035201.GA23331@gondor.apana.org.au>
 <Ydzlo+UmL5bbDgUZ@gondor.apana.org.au> <Yje766s7fIqYg1Tk@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yje766s7fIqYg1Tk@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 0e03b8fd29363f2df44e2a7a176d486de550757a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93e220a62da36f766b3188e76e234607e41488f9
Message-Id: <164790472493.24500.15386999744557853585.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 23:18:44 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:42:35 +1200:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93e220a62da36f766b3188e76e234607e41488f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
