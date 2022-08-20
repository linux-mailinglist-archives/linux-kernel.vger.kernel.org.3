Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2B59B0A8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiHTV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiHTV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 17:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF27B25;
        Sat, 20 Aug 2022 14:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D01F60C33;
        Sat, 20 Aug 2022 21:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0828C433D6;
        Sat, 20 Aug 2022 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661032779;
        bh=DxX4Mo2TrLWZZueRdak/bhqXmMip5cQ9KQlzd0gOVwc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dMshRntZ/jBl5xVIl6SjJnbexGhEk+7GKz4qFua98jHRuH+iWFoMnCyE/HubQw8lV
         Fg+HaUSRVut8qKWZwC86KDgEC3ez/6iw7mvepN3Hq95tyiCEPpr2XBHuzUj2kyDGow
         RoLPm44QrCX9kxOVnfLIAyLKllb/QhEeps1MDh4jqjmB7D+PMyd8+no6WQYjtrgOoI
         /4VPCr1E8AiR3P2MAsc2Jl1urRWNU2QQDEGfuKnjRBLFrR2XaIL2B+XI70RLJ/uPav
         adcFZh03siK3WWsf0Iwvpku/F2omi4WWQlQAjw2s5Etb6xB3Ai/wLPiFrg0Zh6okQU
         69QujlIqMbCfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B25B9E2A056;
        Sat, 20 Aug 2022 21:59:39 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAS55=qvacmoL3Ooio3yqYR9PLBjRjyp=ZWgdHojO1meoQ@mail.gmail.com>
References: <CAK7LNAS55=qvacmoL3Ooio3yqYR9PLBjRjyp=ZWgdHojO1meoQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAS55=qvacmoL3Ooio3yqYR9PLBjRjyp=ZWgdHojO1meoQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0
X-PR-Tracked-Commit-Id: 4be72c1b9f298b4ad42391322eaddef64b282716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
Message-Id: <166103277972.18400.4844385308575892489.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 21:59:39 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Aug 2022 03:07:03 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
