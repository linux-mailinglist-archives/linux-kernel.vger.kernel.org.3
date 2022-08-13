Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259F59183E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiHMBpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 21:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiHMBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 21:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30AAA4FC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 18:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DC4618F5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7271C433D6;
        Sat, 13 Aug 2022 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660355096;
        bh=YkOWYg9z91JRVVZTsna0k28551z0dkkdRpmWVXzlNPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TlXXdiNwt0xYktkrqVpYznm7mlt/jiqWTHuZNNvSlLKzyN/3hOL2w8il10n9Jrrc6
         P8DkXdZdOSuezBEVNZp4hvgnU/obMbb1rDXNbhx97N/6sB6VvkXvpW+ugfAfsDRE0W
         29PrNWrsc32HktlW7TY3gKedFOU+CmPGbd7yIATP4MKn1fUH6Rle3TUJ7hGcBTDOGD
         Terya/fBBrebJOS0xtItz0wqiN7nTt2zSYGnQ9VgGRhrztqfEjTNBaqCeGhftVLHGw
         i7f/tk6zV4sHxC05oh/uObnzc4ID29IywPV8MkNqRYUrwvcpd4YYf6lmL+7QeD3HFB
         ih6VjKCBMlZ4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B68F5C43141;
        Sat, 13 Aug 2022 01:44:56 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.20 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-563e7d68-e504-4e0a-b666-f7c2fbab62db@palmer-ri-x1c9>
References: <mhng-563e7d68-e504-4e0a-b666-f7c2fbab62db@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-563e7d68-e504-4e0a-b666-f7c2fbab62db@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw2
X-PR-Tracked-Commit-Id: 5cef38dd03f33ef206eb792df0fb3b200d762546
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69dac8e431af26173ca0a1ebc87054e01c585bcc
Message-Id: <166035509674.20476.2939118231201405076.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 01:44:56 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 17:37:06 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69dac8e431af26173ca0a1ebc87054e01c585bcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
