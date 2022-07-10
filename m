Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7642356D02F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiGJQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGJQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01A140E0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BB461353
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9360C341D3;
        Sun, 10 Jul 2022 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657471539;
        bh=mfdG5FQur+2rMCpZS+itnOHE6yoYODHNJc/5mfi2LU4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vQAk8iD2BxTzI3YXaWXgUbSFL5sGCce3lI+QkWMVcz1AKLB4DHuhEyyJ5wjJZnq5I
         PRjCw1QumolKY/dhwvKB5PY1FhnsI3HFaR2E6w9znt5GTaIEHcOSfObsw5iEhrGQLx
         G/Ua22z0Fa58+1RmkiZn1ElKVrikE6uIpn9aqfd+bKc7UooABAnsJaYe48xHYlaxsH
         Sphhn8+6fUsKGgaZod2aO4/frwtRj7U8VwtAz99kWTu6Ku8v/DceTioydSu4zzhTv2
         +meIOV9c16H6KpU7BruxhAgnEUswbXxjSPCin98crAakm5sbTEk18ZQdS5A0+N94im
         TFDHAqweo6+TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5B63E45BDE;
        Sun, 10 Jul 2022 16:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsqyrdTDvDSEfdDf@zn.tnic>
References: <YsqyrdTDvDSEfdDf@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsqyrdTDvDSEfdDf@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.19_rc6
X-PR-Tracked-Commit-Id: 80f2a248a2f92c07873128808359756f72a0438b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b9b31cedb7064b16510251cf20ed44b05b71456
Message-Id: <165747153967.25707.4525323922703761345.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 16:45:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 13:06:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.19_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b9b31cedb7064b16510251cf20ed44b05b71456

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
