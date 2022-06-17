Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1054FD77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiFQTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiFQTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:22:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B5496BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00127B82B49
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE935C3411B;
        Fri, 17 Jun 2022 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655493741;
        bh=afgKFOZfhid1Z1GdrGk/y5v1z3bbFmUPlBQrjnLteew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o1ev2tsJqQXROBC8pHmlKcZOIMW4pFHFWGEE+FpqLPUALTTn/7h54VZY0c7pZMuDe
         NyjUW7ZpKibJGnV0mOBbb3mYt8k0XCm+L60hQJGWG2ByvtuwO7G/FntlkzN/UiRiyH
         33jHWuqZmVLYZAe3BXe2twM5hWHPF36KPlcy8nJhCIH1QWDuTCYJuMoNxPovCEUxEI
         ORmlmintKCJhfNwAToWPEYdVEIzrI/JO5QuP8CZ9Tn5gpLXvE25BoKgw3Np9spCOF2
         SYRuEBTzjRULmDfq7stjDkoD+w2lQSCg4VcVRZ3+cv3rAfr+r83m4SRTyTGetMqfMS
         pixs3LZfSGuhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B9EBFD99FF;
        Fri, 17 Jun 2022 19:22:21 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-67f78725-bcd9-4c12-920d-2377a998b9f0@palmer-mbp2014>
References: <mhng-67f78725-bcd9-4c12-920d-2377a998b9f0@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-67f78725-bcd9-4c12-920d-2377a998b9f0@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc3
X-PR-Tracked-Commit-Id: c836d9d17a7d102ded1ba4dbd4ee0bc42ba26211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f10516322ddab90e2d9b21990d8c8787c2236b26
Message-Id: <165549374163.16480.17138300142059650834.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 19:22:21 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 07:28:41 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f10516322ddab90e2d9b21990d8c8787c2236b26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
