Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146F4DCF86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiCQUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCQUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:42:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D9B82E7;
        Thu, 17 Mar 2022 13:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56614B8200B;
        Thu, 17 Mar 2022 20:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E63C340E9;
        Thu, 17 Mar 2022 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647549657;
        bh=Q7jdUq/TXyJQ/AkZzk1Y/hc/BA0YWfpTX3RTM+IexcA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RZwtIy0BcCAAag/CFpKG3xPhtSYXqf3tKcsKwyFY2qco/46kKjNPCdjoCd2A9lo5/
         A3finhsVjKETKkr0zZ1LShoiD2qcMSIwn8Jw5GkhQVd9GzgQN19Mgqb37c3tOv8q5z
         kNRgJviuC8OWgGjXa9vu33Yh2qVOgDXoUdquJfNHw3toMROcacqna8Ryvi4e9b0a77
         +k8vdlPE92RqG/L8pcOnRLOYDLCx82rRHP5mfBgr5J4B2nFEB1a9PoXIVaGorKNn3l
         kwQ4l363SuYAGwvrVI+G77bg1MJD6Ycj8RrfAwZObNETB2RmG45DWy89lnyNIQKinh
         VKJiMSmfjjVng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1993E6D3DD;
        Thu, 17 Mar 2022 20:40:57 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjE5yThYIzih2kM6@gondor.apana.org.au>
References: <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au>
 <20210817013601.GA14148@gondor.apana.org.au>
 <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au> <YjE5yThYIzih2kM6@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjE5yThYIzih2kM6@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: a680b1832ced3b5fa7c93484248fd221ea0d614b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d34c58247f73c5358ceae1ae648fb9daa408ef23
Message-Id: <164754965784.20112.16356756424689821980.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Mar 2022 20:40:57 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Mar 2022 13:13:45 +1200:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d34c58247f73c5358ceae1ae648fb9daa408ef23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
