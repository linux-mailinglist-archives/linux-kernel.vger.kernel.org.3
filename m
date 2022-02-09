Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2744AF8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbiBISBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiBISBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:01:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9EC0613C9;
        Wed,  9 Feb 2022 10:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 038FBCE2242;
        Wed,  9 Feb 2022 18:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74F5BC340EE;
        Wed,  9 Feb 2022 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644429665;
        bh=ppIoTAUwx50n1FTdZ+mgrgbsSo5XIdGZPcFL8jdZU9M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UwMIYCR9mGunH4vPzHPrDSnryw15wp0XbY8hVv72C0ZxzctU5tYcu0QhmYITdISPX
         SAIztUSF0pJ6q+79a4EZOZWzF2JF7HD8N77apOF3djmxhr9bTXMFS2j9A87mO3aiAm
         ycgcd+TUyJowR5bBR3UGOkiODLogsv2mnYcwxRrDO5wgTcyAgitGOuoT1C/1DDLY0d
         9GQiIq2tVyv675H9xvRuH1ynevHO/QoN2ySOyLs+87IpfU5vc2aep4j13HY8/Cdl5z
         9Sn6625O6S/VA7gpT2kQzQkVEZBK1f7Xl5kZqF5yRv1prcZ1Id2iyIVGrx1fhEczE9
         TYHPNaGDry08Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6366EE5D07D;
        Wed,  9 Feb 2022 18:01:05 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgMn+1qQPQId50hO@gondor.apana.org.au>
References: <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au> <YgMn+1qQPQId50hO@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgMn+1qQPQId50hO@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: c6ce9c5831cae515d375a01b97ae1778689acf19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9f94c9d2c070941a5688f0f751a489c7d0e5039
Message-Id: <164442966539.2385.10203962847263444677.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Feb 2022 18:01:05 +0000
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

The pull request you sent on Wed, 9 Feb 2022 13:33:31 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9f94c9d2c070941a5688f0f751a489c7d0e5039

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
