Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2383159AF9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiHTSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHTSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6782BB28
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A63D60F37
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 18:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7C2BC433D7;
        Sat, 20 Aug 2022 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661020834;
        bh=uBiTZyfAAcPk2HA5AW5UZ6xvApMNfZLG9IsLcs63Ey0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n2oOEzO57r2PtYz1DiRmMFQ9QuN2usjWnB/3N5tAlwe4HY+B6cpetsfw6AMiq6OZ5
         y1+TZMirqzuictJcOcI6N2StdBvUvtBJL0jX65uBmCEqCHVvS/ImH/VdhOBcE6fNe5
         K1vPddX1lHXkevIg6Chd8yxv0zUO6xI9lUXWhKgrXpBZj32CgFGrE/qAvAmscoo50R
         9nPDwsQ1nm5Quer2jE/D2dY4cVgzAKRbUHdRA0KOlZQd2R2JpOHOr3skGiSnWBhI67
         0T14nH6x8Bu3Xa0OqCgfiaN/AjB7VHZw4x7TGrqanPkCnckZjmXeS3IZ6rQ5L89vhx
         r8/bwkribfqFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 929EDE2A052;
        Sat, 20 Aug 2022 18:40:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wnb3ld61.fsf@mpe.ellerman.id.au>
References: <87wnb3ld61.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87wnb3ld61.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-3
X-PR-Tracked-Commit-Id: f889a2e89ea5b4db5cf09765ee5e310be43c7b6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32dd68f11058652a37152aed12bf552455914b40
Message-Id: <166102083459.30631.540996902473133866.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 18:40:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Aug 2022 15:03:18 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32dd68f11058652a37152aed12bf552455914b40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
