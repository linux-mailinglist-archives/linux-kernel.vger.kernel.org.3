Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984974CDE29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiCDUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiCDUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1CC15168E;
        Fri,  4 Mar 2022 12:22:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8787161CD8;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFFB7C340F1;
        Fri,  4 Mar 2022 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=XBKiEUJm1uOHuu7CfMVAd8S4iZPKDI6uXW1a41y7xiE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gh3qXoLuTmBDJV4M5V4uEx0gMcsiJ2npoKziBQ1t1GsAZtpQ2hmuepEbdDN4C5cxl
         29x8CQG0gw1dXnlzUXSV3hAlKAuIK9WTY3q09NUrhsnA2TBwX2VPUWJSL2KOfmK3Z8
         GmwMZRnCtDBQHGUvdOviRHyaM3S+N812uLNtnegy6Xvi9msydeQQBEL01lt7bVj6K/
         fi/WaFnrRz+HxaW/dl+HiQo8NSzAH9vfQlKaUyw8n3cj+BilRcxueD+9RQRve6UwPq
         /rYS9b/ay6f8EMy9Uvi849tXIKN+tdaEg4SrLB+VMxCt4ImWAHkTYAXc0GuItn0pso
         3Ij3PwFW+jl2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9D36E6D4BB;
        Fri,  4 Mar 2022 20:22:00 +0000 (UTC)
Subject: Re: [GIT PULL] late pin control fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkda0eFMzvfCjtXYiRoe=Wa5XqacL1Lhy4mBBOo6pu_Wi5w@mail.gmail.com>
References: <CACRpkda0eFMzvfCjtXYiRoe=Wa5XqacL1Lhy4mBBOo6pu_Wi5w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkda0eFMzvfCjtXYiRoe=Wa5XqacL1Lhy4mBBOo6pu_Wi5w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-3
X-PR-Tracked-Commit-Id: bac129dbc6560dfeb634c03f0c08b78024e71915
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b7344a658e66a6835ad96dbc5dd35f1e876078a
Message-Id: <164642532088.24805.2325334987312852345.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:00 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Samuel Holland <samuel@sholland.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Mar 2022 00:41:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b7344a658e66a6835ad96dbc5dd35f1e876078a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
