Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B014E30AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352527AbiCUTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352678AbiCUTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495932FFF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72D1BB819BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19707C36AE2;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=xxUCaEjmFMEt92IZfn6D4i9W0XKUuLSHve8L6v4vR4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rvSmttoLBoT0EReA5ekxlrk5wMvlNvdFfqjrRhGMoyprigNg1c4qaSigTh9IR+30n
         pGh3IfSX5d7MjzUiWpVTifODWbN12/F3wuw9toptt0T6C7eEAa/nluQUcqYYpfR5rd
         8MN738i4ite0nOW7rZrzx+piYjtjXl3VilcSr/fPFvl9bEbXpLOmJaKg/suhBRBVEP
         OiUNiQn8NgCgnEv4oNgyoTG2mD75x2EhU6xF1Pixl2xGF2sHw4l8BM9piDM6ynulwo
         pLp4TivLacKe3SB1TZGYNCObN0ipG8pj0jGrpW5cikOJXvAccc2Un11iFDH+j1Z6Y4
         4+Sjjzj+dhnqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03F7BE7BB0B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhTbqc1CNwBpENY@zn.tnic>
References: <YjhTbqc1CNwBpENY@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhTbqc1CNwBpENY@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 686016f732420f88dd2e1d67cf4bb5dffdb93c82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22687350452c80c8e8d2c62d05c1511902c27f42
Message-Id: <164789031400.24158.2732889387052203689.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:29:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22687350452c80c8e8d2c62d05c1511902c27f42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
