Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA394B2E28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353179AbiBKUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353157AbiBKUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D6BCEF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 622D6B82C93
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8493C340F5;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609920;
        bh=9XkIwkraO6g55K3RrhMq3cJq751ATHP2Havc9Cq9XSc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aR9e1paOK1Lr1+LpWVC1t0hcogJViv5Nmsk2nuJpzefMDmfWBnfh3g/NaRVfb72Kl
         zOgkI0QrxRdIVet44tdU46Xq+eSX4VkZOKOi7YMqS8X5qwX8qBhXmU/YjxLRFi1Dxb
         ia0/qiGrGcc5NieAbiH5Qz7rYFNGh2xeHmYJEpUvVSuaWDe/H9gTZpMEacZqGonFgm
         gOYiRzfd85LiVaOYsLAgi/IPDi9FWwTRcHmpTNxpNeAomweGnpWaXmmlZZ1KT0ZLV7
         qcXVHdphnWs+MZTfyXuQQEm+uwEc85owHHcV5oSnJgJX3tz13XdLAz31QtzGwzTez+
         LUSKBEV/aYCFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5F89E5D09D;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgawjGlDGS4l5pBY@arm.com>
References: <YgawjGlDGS4l5pBY@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgawjGlDGS4l5pBY@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: da5fb9e1ad3fbf632dce735f1bdad257ca528499
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e47ca403262680db81dbd8bbfd40e7f522c7f147
Message-Id: <164460992087.1412.11184759436369751545.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:20 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 18:53:00 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e47ca403262680db81dbd8bbfd40e7f522c7f147

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
