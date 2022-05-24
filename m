Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C66F531FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiEXAXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiEXAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E729433B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66E86B81710
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A079CC34119;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=nvwNPH/13JBddz573MYT+BIO+WQbKghR7/WK/XnuiX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K2G1PhawhHFrgxPpikGTjvOQUxFN+WsxDmwmQhlw2L3LZjnrKmzAAph6eD7NC4aSg
         UoKSrNhjfKpiPlRmAyLbCl0ln2W3qQQSVqOXPGcoiQx1I9KBA8gti+k+Z1YtMHEkv0
         v0zCDtbhD0CvqNsD5s/ebzYd1fPUGeifnPqMgE2JTe0+2iSQ8JDGEu4OTYYSSOjZaZ
         lDdyBkbkDGAPEefAhR7wCA7+vI1sVYGSSSvCaUs0i7WVp3KAO4SCEzue0zplH6H6bw
         p/Mj14MgsI7asEIzvLtkOyQyBVNeS0qVGOpCIhwU2g4p/zNEoh49nV8pVeGaSknVJC
         ifL5Avf+JwmbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E2A6F03938;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] x86/irq for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329268482.3801280.5762082984267519856.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268482.3801280.5762082984267519856.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329268482.3801280.5762082984267519856.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2022-05-23
X-PR-Tracked-Commit-Id: c25f23459c117d950e657458b0d3dcaaf9039ec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03e1ccd45fa70904e43ddceda140854d22b7e871
Message-Id: <165335177057.4476.4801757357630651193.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:11 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03e1ccd45fa70904e43ddceda140854d22b7e871

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
