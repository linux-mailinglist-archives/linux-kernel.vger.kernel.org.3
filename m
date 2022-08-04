Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8458A361
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiHDWqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiHDWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD41F605
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B976185C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14AD1C433D6;
        Thu,  4 Aug 2022 22:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659653175;
        bh=pj6iKSFZ5nbdi4GVhD00sZg2DDo91G2ojfysH8N2uGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XpsiKiZfwSgLZY17O7u5jP1dIMO7maMFAiOh33qm2btNhkLelreHzeWrFmZNWEf1g
         e5Vz/hdOy9pNFfYtr+pX+LAN0cb/GhjWoWSWRJIBHej5cHg3aRsCK/4Jmsry3BO88S
         1JEYwx+07PnhxS+WLnAD56/1DgtpSkfsf6QqlFa63l0i5HiZwmsEH8+Wi9amjy9zMS
         YEP437Iyb+JgT4NX5gbhFeFlTx9LZBMybk/Tw0ZU/GBPe4/W9xDHEtY9qvYfqENXTY
         sp12uf6t3qdVp1AxIN4OoI42l/kPhuB3gir0yHR/0P5MG6TZuRdVYR4rL408AlSoJF
         EDbay0oZt4PGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01834C43142;
        Thu,  4 Aug 2022 22:46:15 +0000 (UTC)
Subject: Re: [GIT PULL] AVR32 change for 6.0 - outstanding cleanups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yuo/mq0VrqTH9BS+@samfundet.no>
References: <Yuo/mq0VrqTH9BS+@samfundet.no>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yuo/mq0VrqTH9BS+@samfundet.no>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git for-linus
X-PR-Tracked-Commit-Id: 2fb0ec4ae5632ba288ab233849f85069d4c475a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25e6bed5a64836621e41bc9f9d97eb79f1bdfa1e
Message-Id: <165965317500.20279.6357615482209362029.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 22:46:15 +0000
To:     Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc:     torvalds@linux-foundation.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        hskinnemoen@gmail.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 11:27:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25e6bed5a64836621e41bc9f9d97eb79f1bdfa1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
