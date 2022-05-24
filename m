Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E6F53212F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiEXCwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiEXCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AD22289
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313BC612B2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 884ADC341D2;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360676;
        bh=f0AqG0F2y0MHXRESM5UeQcyEv9e19rBMOEFLxRh9z9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n4TkSTOAdidncW6rOmW94Idu5xnUD51V09gOZ+V9oMse4kcDwUKyj4LoTyW/mRT8x
         3LRditAtvqQw1YW3zBCKrwLDEtfv5i3dzaqo6J+aYj5gAeUGvT/DzspoQ+idkm7kB1
         d277h4fsG2US6G6bUDfm5AT2zmlEhHhViS59zgUOas9XL0HohVbmOQLQYhvA6lfwTc
         NMDeYgS0/nMQ1ik7DX0/n8lHGabTAQYXvalI6vsD3QSg8bgCn07eBnskC/0yVnYwfp
         Je3VhadFCbMRDXBZZy77NwYXc11+EJsi7ijFhH9HVBDM8Hz0ygVk4XGK26VclkJ3wz
         Klp+3sMTGkegQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 766B8F03947;
        Tue, 24 May 2022 02:51:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/splitlock for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yovlb9y/umFHY42Y@zn.tnic>
References: <Yovlb9y/umFHY42Y@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yovlb9y/umFHY42Y@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_v5.19_rc1
X-PR-Tracked-Commit-Id: 0180a1e823d7c41d9a1c19f38e6069b38fe60c87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e2cbc016b1d08463925db9b9bd3bd253f64b8b0
Message-Id: <165336067648.14181.15659269051571302723.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:16 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 21:50:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e2cbc016b1d08463925db9b9bd3bd253f64b8b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
