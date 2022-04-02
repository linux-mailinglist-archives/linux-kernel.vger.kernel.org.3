Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336304F0602
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbiDBUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350387AbiDBUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A9E0ED;
        Sat,  2 Apr 2022 13:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F32D2B80A25;
        Sat,  2 Apr 2022 20:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28CBC3410F;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648929657;
        bh=GddKHp+FX06NWWUMBUhR907LRbVDTGpJVORHR8pyYPk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HgyDN+Ok1caHpmNLMyM70CtD+7+m4F/2cnolVM73UAYoQDqV+fpQaJQnudHrrvG2G
         q3ft4PDJ316pCOeLhi/gCAdoBj5fhXUR9NgDYroK8l9xtkZBvuoono0ySZwDxiYnkO
         FM5KyHe+FzGF41KSYTtzRqvDcLqx0tksR80F5bAE373HXq1gXPfbwZjW1pqbiORU02
         eJUlBNjSxxvmQHHabV7DVC/GP9wwD9TP7v2xZMw1IrpfCc5oKSv7xUisJh2+x7nedQ
         BPB1YMMVYOLTlmICuTnvVPiaVxhb0K9G7/lv3p4MYhcKOGaTIyxWlwDx2jBGNebL+k
         YW0tj/ifLD1QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90E0EEAC09B;
        Sat,  2 Apr 2022 20:00:57 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes vor v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220402112719.GA5234@alpha.franken.de>
References: <20220402112719.GA5234@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220402112719.GA5234@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18_1
X-PR-Tracked-Commit-Id: 41022eff9c2d21e658c7a6fcd31005bf514d28b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b0fa57a2772be5bcef199ae5e769295afec0de5
Message-Id: <164892965758.29522.14434602391550083691.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 20:00:57 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Apr 2022 13:27:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.18_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b0fa57a2772be5bcef199ae5e769295afec0de5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
