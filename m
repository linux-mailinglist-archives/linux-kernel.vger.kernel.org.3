Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31CE586F87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHAR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiHAR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B75FD6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B44F4B80FE1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63632C43146;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=Wdriq4JURkk6wm8phlXmNRZuB1QdMpWxHFbXINNITNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gPCGKM+Loufzq76VY2yN6LiWg9Ots7SNXbUD8WcTDn0YgRZkYKbypqkyhdGI4Xwyn
         ltXbJKSNriXgYNhEOTH+mJuqRyaDDWjx4QA+t1zoYBeRBph90J0hA6AqoCpwZEhq4N
         XlgYGw5MR5P3StQ1/0tZWl60l9zq6SRsS7dIxQUa1+iiIKYgtk6uUGiWDb/SIBOtAF
         5bamh8xj/6kXfQUtYvxKlftdHRXqTJz+L+RwWAUn/I4ruoHjtHisZUhdUwyFZDU++b
         Xwi03dwN5VWKDd9PimTR0WJ/QyE6FRs+i+AOSzFxqKv6+aky60czD7lzi73JQJltaj
         Yjllfa9SWd1fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52F1EC43142;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yue6jQd37wpssGeZ@zn.tnic>
References: <Yue6jQd37wpssGeZ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yue6jQd37wpssGeZ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.0_rc1
X-PR-Tracked-Commit-Id: d906fa730827456711ce29c1f2994a0ccaff49dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98b1783de202f3e82be7f32dcdc10a3d270b90e5
Message-Id: <165937482733.24126.16566745876111518830.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 13:35:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98b1783de202f3e82be7f32dcdc10a3d270b90e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
