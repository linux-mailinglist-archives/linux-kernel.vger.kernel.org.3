Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13B5152D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379787AbiD2Ruw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379785AbiD2Rut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475D22B32
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7089A62420
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7B44C385A7;
        Fri, 29 Apr 2022 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254449;
        bh=pq+Z/q3v6nAybjJ3InPv498b4ZSVuSQkyKfQZb9feW4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DQK8DSdUK0O5+6l7q+jupD/kirGLXyqY6/dcZGrLs07QsV8WROX5tNoBSKbPLsnj5
         BrVWNucLSKT4Uk9I3cNwZjQhX7cONMSXzA++PvsNPNqKLK3l9M+ZSN/9DcIo8/Pyn3
         PHNlnvAaMaSi3fi5WGFIOr+CzhTW2PhJCE3P5yhjDIjk2fVOJfj6NTAxTjDv63jhRQ
         SbNFdgqzA5IshnM1XPF3GOrK0QKIZXn0kDbJs6kl7c4hWekOMPJhqfVGAPXOAo8M34
         pRCK8dHie9TuHi0lYfCqNBNQPgljhkcxffkkJUZ9kkWQSrZCNoPArh18QYPGNZ/kAn
         /XmgyYPRJjbTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C395FE5D087;
        Fri, 29 Apr 2022 17:47:29 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-23ee08e3-f500-4297-bd05-a1902598d9b3@palmer-ri-x1c9>
References: <mhng-23ee08e3-f500-4297-bd05-a1902598d9b3@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-23ee08e3-f500-4297-bd05-a1902598d9b3@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc5
X-PR-Tracked-Commit-Id: ac0280a9ca106c5501257e79d165f968712b5899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d0de93ca2515958e717138e5ee07ec3b6bf0226
Message-Id: <165125444979.17620.11204985121141756042.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Apr 2022 17:47:29 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Apr 2022 09:38:55 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d0de93ca2515958e717138e5ee07ec3b6bf0226

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
