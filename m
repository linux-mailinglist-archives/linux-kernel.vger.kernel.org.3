Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594B5534921
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbiEZC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbiEZC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D07BDA07;
        Wed, 25 May 2022 19:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C324617E0;
        Thu, 26 May 2022 02:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 019E3C385B8;
        Thu, 26 May 2022 02:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653533964;
        bh=etUrKmGKuLKuZ6bzisyXVPBoM3iNs+yUKcq4mQo8lnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sh5GcoCe6UXLlTyiQg6KD0sIwLmQua/I1LUymZKYJugEp2Yjz47DUWoFj0D9YKrbU
         LR0+uAYQYAq/K3cd+UpFouiEPOmSR4HEl2dlheDkx9+LcfUIc9BIccVKzsRett+1NW
         gR1g3eCp5efLCYRUcbVE+cTek5VyT3VA9mummeRCvlElPiJyWxnWOTAT2XE9/6EOV+
         3IABQb4Qmd3L0iIi0xojeEoYBL76HqA+4Ic28Oj77qVtesqjjSpDmC/YewTzPkhZhh
         DZDooPouf6+DSf2aXvUH8t6guufm8GH6XXMYdrERaJNtvkaX2M5SrnCerHVDCatnAe
         qrMpz0rVJQYmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4EADEAC081;
        Thu, 26 May 2022 02:59:23 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220526022053.GY2306852@dread.disaster.area>
References: <20220526022053.GY2306852@dread.disaster.area>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220526022053.GY2306852@dread.disaster.area>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus
X-PR-Tracked-Commit-Id: efd409a4329f6927795be5ae080cd3ec8c014f49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: babf0bb978e3c9fce6c4eba6b744c8754fd43d8e
Message-Id: <165353396393.29187.10817291830005746263.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 02:59:23 +0000
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, djwong@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 12:20:53 +1000:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/babf0bb978e3c9fce6c4eba6b744c8754fd43d8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
