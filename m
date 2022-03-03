Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07064CC5E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiCCTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiCCTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A44A4186;
        Thu,  3 Mar 2022 11:18:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0B87B826B4;
        Thu,  3 Mar 2022 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 837C3C340F1;
        Thu,  3 Mar 2022 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646335089;
        bh=r5P3nD4nSI8TjvUBy/LOvE6AB26Q8ppTwpWkn6oaE+8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oDM7WLiOE3SPK0PKCXzvt3CTF/qzxnICU7dEZXlKm/LNK1YtN2K7YSHALpM8hO2aM
         rclF3E334rCJnC4SgZBjIVGTp1h/T+PSF/lFEcN1lycmH1/pARC/zGvMw37aPWmD4o
         aqZwwkum1R04JvENdoNtM5G/+b9fIHsoGulYbCY3f6SrolanMBKcxY60M+z7G60UGj
         AQw5zzyKqIWkcsn6en6tBQrVHZgKk7yig1y9zapaaUneEh8vX2d5rOjr8/Hws0zRl0
         uh5OVxLS+Yy6GImaxrzlBDR34RsUzJmZ5Xbq+yk8k1mFOJ6CGCYn7VatL1dkFcCR/f
         BPTtDqOLJNyug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70282E5D087;
        Thu,  3 Mar 2022 19:18:09 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220303164842.GA12460@alpha.franken.de>
References: <20220303164842.GA12460@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220303164842.GA12460@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_4
X-PR-Tracked-Commit-Id: 5d8965704fe5662e2e4a7e4424a2cbe53e182670
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e58bd49da6eb4ba80175f82025d6c0e084237abf
Message-Id: <164633508944.14270.12109512669879819927.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Mar 2022 19:18:09 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Mar 2022 17:48:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e58bd49da6eb4ba80175f82025d6c0e084237abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
