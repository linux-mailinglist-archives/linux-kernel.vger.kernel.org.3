Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6B4FAF78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbiDJRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiDJRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406555E75C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14F260DE8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 416C9C385AB;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613152;
        bh=T8m8H8virAurVoY3+37ixpWIQK9WJCHtxC+/9UlzZbA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mg9RJDkiT8uNHD9Q0kVO+0zYhv2fNIsA9KXgfgVi29UR1UUk2bJj7dzHiC8kEykV1
         3W52ngrPEmYpFvm3ZdcMRDfMA0yypEYefv8/JWmhybrbBqNA+S2Op5BI6bGgJEYoYe
         Vvgyl0yoYCYrIBvy0sBBZ/xc7Oxq4E1D80Lb5UMOj+wE1Qc6WcKQmLuZWU8gGWEkJ3
         EP9bd+MjWw6HJjKridOZ5OpmsgP9tJrII0Ls8M2QLjunmiaHf9kyvlvi+RGm9nTkWt
         deZ2Oj2Xx3855Y5TrT1lTqNQc0B7gca6UIUn8rXJWBNQz4fkUv2ppmfKTSThx/v2C4
         FGFdRpggS/2Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2635EE8DD67;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164959340965.293972.6241179986026423856.tglx@xen13>
References: <164959340965.293972.6241179986026423856.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164959340965.293972.6241179986026423856.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-04-10
X-PR-Tracked-Commit-Id: 63ef1a8a07ef64f802af1adadae3b05ba824c534
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1519610b533754c600effd8e25cd4aa44951a6a5
Message-Id: <164961315215.10430.12654556288121925610.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:32 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 14:23:59 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-04-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1519610b533754c600effd8e25cd4aa44951a6a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
