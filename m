Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8851DF97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390523AbiEFTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390395AbiEFTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9E6F48E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7697062193
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA41C385A8;
        Fri,  6 May 2022 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651864493;
        bh=9izC6voEokk5hZqLjo1Prxi7Rfhs3FZIxAhsffdcD0A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kqsK2oc+VtM1VqpoVU/2qEgRevrIEfXgxdJVFNs6BuH4/aJJPgTnmelxYYmYCWfGF
         8UEUOAg785tt4vJJh+f1u8b6YlJ7jDlxhHvb+LZMQJ66cCuUsyGgQErX3u/I9Kfh8J
         ywPW96MnY2ND0CNQyf2JAYijURqxHx17sdP55MfGh1MYlAAoEptPDcd8FH7klC1Z99
         Unvx6C+P9nHK1krB/TNKAmz5Uyubf5uW3Zq9ws6TELHYUI3XqMlJ5USWb79AZmLiGk
         rKPFC7/u0CR/mY9syf0LjjgzT0Ysc2MzzVgO2CXN90r2ig5FDTFEEuAeZXQ2aTtXLv
         tUZWQG+scrrSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C73DAEAC081;
        Fri,  6 May 2022 19:14:53 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fix for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-93e651e7-8975-4f60-8fab-31f695d9af2b@palmer-mbp2014>
References: <mhng-93e651e7-8975-4f60-8fab-31f695d9af2b@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-93e651e7-8975-4f60-8fab-31f695d9af2b@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc6
X-PR-Tracked-Commit-Id: c6fe81191bd74f7e6ae9ce96a4837df9485f3ab8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 497fe3bb196de7249723ba1496fb72ca63ce14e2
Message-Id: <165186449380.13372.12860414235856776719.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 19:14:53 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 May 2022 09:36:51 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/497fe3bb196de7249723ba1496fb72ca63ce14e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
