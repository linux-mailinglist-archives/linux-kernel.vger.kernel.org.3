Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5ED48EBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiANOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiANOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:39:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DECCC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:39:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56810B825F5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9864C36AEC;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171159;
        bh=NJtVr6Ce3LUAkvC3PMu/SiZGGVBKhsePi2TzcCwdqZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BZsoyvl2JPcCsal7DVDGyMi8Xy9yfR1wLd8IC11nu+eKj3+KyhzyN7/H+yZIWZcQh
         2bmIK3cKBimqahEe29ozGdLm4eeAJOGC8R4uti0vD/g2bt6XYYjlC7KLD5bpmFeGsC
         d4qida+aDXWKx3ol01PdvW5FeDQtZC3n68UsmPfM+Wzcw8WWKbgSRcO4uc6at+Norr
         R139Kzcd5KhtXQfHHX8vfzhc4fuJpJbp0/4yL1zKeoMaRVTODR45BazUzxjWLmMgnZ
         IR3OG/0y46rXwKHS8olmralMDDr9/saB6GEX6zKf2zYBXHmqoNuqI9oywbQXBCKgh7
         NkEHvWwTKpiVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4C57F60794;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8ym1qce.fsf@mpe.ellerman.id.au>
References: <87v8ym1qce.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v8ym1qce.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-1
X-PR-Tracked-Commit-Id: f1aa0e47c29268776205698f2453dc07fab49855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29ec39fcf11e4583eb8d5174f756ea109c77cc44
Message-Id: <164217115979.3976.13936421146650676596.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 14:39:19 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia.Lawall@lip6.fr, aik@ozlabs.ru, ajd@linux.ibm.com,
        ammarfaizi2@gmail.com, amodra@au1.ibm.com,
        anders.roxell@linaro.org, atrajeev@linux.vnet.ibm.com,
        cascardo@canonical.com, chi.minghao@zte.com.cn,
        christophe.jaillet@wanadoo.fr, christophe.leroy@csgroup.eu,
        clg@kaod.org, dja@axtens.net, gregkh@linuxfoundation.org,
        guoren@linux.alibaba.com, hbathini@linux.ibm.com,
        jlu.hpw@foxmail.com, keescook@chromium.org, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com, nick.child@ibm.com, npiggin@gmail.com,
        oohall@gmail.com, peterz@infradead.org,
        ravi.bangoria@linux.ibm.com, rdunlap@infradead.org,
        robh@kernel.org, sachinp@linux.vnet.ibm.com, seanjc@google.com,
        segher@kernel.crashing.org, wangborong@cdjrlc.com,
        wangxiang@cdjrlc.com, yang.guang5@zte.com.cn,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 22:58:25 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29ec39fcf11e4583eb8d5174f756ea109c77cc44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
