Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E227C4CE7DB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiCEX6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 18:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiCEX6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 18:58:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D54286CD;
        Sat,  5 Mar 2022 15:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6018960FDD;
        Sat,  5 Mar 2022 23:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C47C4C004E1;
        Sat,  5 Mar 2022 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646524675;
        bh=a6KqUUIML6dzFTUtX/1ygJ3aFmdEV7ENwAKPSvYElfU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dDuPdTE+xqiCY6GBijlBIGZiC86HyYYD4hVwtmH197hohygLPsYDV63E3XsfpEIX+
         JHoXFudUosx8ygEjP9LX7oIUN/50Ss3qlA60GuvUvg3TWFFk5CxfDCXFtKPn+tZhT9
         WkxoWY03rSjMRLDu/pAcAY6hqKp4SqL3Kx8G+KoNnwFJqqUtYiNqmKziIt5pnF0tk2
         AiavrU3rx3xDourKvj2i1nfEObkIg2wGA9KBbjLzci9yoRVbheTz++AKF10aybfYOk
         gJDLim9ARupdoNe3P7KIVzFFmRrB1JjoCmg1NGCX87XJdmGBTNMEItehmf5VhEKRFA
         sb3XsTaHsAREw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B14FAE6D44B;
        Sat,  5 Mar 2022 23:57:55 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YiPlTcVeLWi2pDiq@google.com>
References: <YiPlTcVeLWi2pDiq@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YiPlTcVeLWi2pDiq@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 327b89f0acc4c20a06ed59e4d9af7f6d804dc2e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcde98da997075053041942ecf97d787855722ec
Message-Id: <164652467571.7907.14995493157816632225.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Mar 2022 23:57:55 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Mar 2022 14:33:49 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcde98da997075053041942ecf97d787855722ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
