Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB98F58B8C8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiHGAuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiHGAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9C10FCB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0759A60C95
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D332C433D7;
        Sun,  7 Aug 2022 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833403;
        bh=hVQ401EV5DbrpwNtv/SO3dfFf4K1qKd46UE2Ic9n8Z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnxAOE5dIsFgWMvMC8OkaPwoSZS3Z24N4U/vOdGxhczLzui2AOBL3AY+tki2ApaFe
         DVIJWG6F/+LvrDge/3YD/iTafn/QfUlrMojCUM68VCEJdIebgoopnqblcivYSwyqBs
         k/nj9u486RQjBrcqABaBSCLptoZpyREU4kqtv6h5CEPdIgXF4OeMus+lVRYVn4h/EX
         +pgXqKKE9R1mgw1mMUhRpEVjiicv/hmRY+eoF01FSYbkV8iTuraE55Yd7watUs0y/w
         pe09fsHtzFIwcs30mxATjynPwt+N9EON68QvYPx3ZSqpAjgZgf/sTaziXYN0VgQmFY
         Clpvv8HY/f7ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43D39C43140;
        Sun,  7 Aug 2022 00:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877d3lan4c.fsf@mpe.ellerman.id.au>
References: <877d3lan4c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877d3lan4c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-1
X-PR-Tracked-Commit-Id: 4cfa6ff24a9744ba484521c38bea613134fbfcb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cae4199f9319f42534ee2e2e4aadf183b9bb7f73
Message-Id: <165983340325.27609.11042525073896478174.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:03 +0000
To:     mpe@ellerman.id.au
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com,
        aik@ozlabs.ru, linmq006@gmail.com, wangborong@cdjrlc.com,
        viresh.kumar@linaro.org, rashmica@linux.ibm.com,
        bagasdotme@gmail.com, rashmica.g@gmail.com, ldufour@linux.ibm.com,
        baihaowen@meizu.com, xiujianfeng@huawei.com, deller@gmx.de,
        nayna@linux.ibm.com, rppt@linux.ibm.com, jiangjian@cdjrlc.com,
        joel@jms.id.au, muriloo@linux.ibm.com, masahiroy@kernel.org,
        linux@roeck-us.net, ajd@linux.ibm.com, arnd@arndb.de,
        kjain@linux.ibm.com, u.kleine-koenig@pengutronix.de,
        npiggin@gmail.com, oss@buserror.net,
        chris.packham@alliedtelesis.co.nz, mkl@pengutronix.de,
        andriy.shevchenko@linux.intel.com, hbathini@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, zhouzhouyi@gmail.com,
        farosas@linux.ibm.com, pali@kernel.org, cheloha@linux.ibm.com,
        linux-kernel@vger.kernel.org, wsa@kernel.org, broonie@kernel.org,
        juerg.haefliger@canonical.com, maddy@linux.ibm.com,
        sohu0106@126.com, linuxppc-dev@lists.ozlabs.org,
        damien.lemoal@opensource.wdc.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Aug 2022 16:42:59 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cae4199f9319f42534ee2e2e4aadf183b9bb7f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
