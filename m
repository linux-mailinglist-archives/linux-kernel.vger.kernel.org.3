Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D44570CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiGKVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiGKVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF7365578
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424B86009B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A56BBC34115;
        Mon, 11 Jul 2022 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657575893;
        bh=Fh7w5hl6K6geS32VSDhH9j2yCb8ro0hPlaW+be/Srmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tW8XJtQC73me6mvROAjhtM5yvGeEGaBi25pHXU6nrvdQb7t4UGUNueQ1tRETBLVne
         YQoeYMLTJDOLkQk3G651y4UccGpDW9r2rzEI+ejp7begP4ifV68LsreiIH5YLCg3Bu
         Pn4e7qchem15LaadYdPeeq+IaDWix/eNPWfLYabKcVzfFxaNR15+bLXOBMsHYKIRqS
         +oEzR/EGBpzIGxTVdwlmn0wIkocQfhEmL7r/2oZro40RbhS7eto17VBjpo7HfSyzTu
         6n3J8F9z7jVfzhQRG1RfLy2gwO6ZcsnZbhtf0n84NFpOYfV/YPP6s7kpWmOYPznvrw
         etK7GVa1mvHug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A46E4521F;
        Mon, 11 Jul 2022 21:44:53 +0000 (UTC)
Subject: Re: [GIT PULL] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilo3ctcr.fsf@email.froward.int.ebiederm.org>
References: <87ilo3ctcr.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ilo3ctcr.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_unfreeze_fix-for-v5.19
X-PR-Tracked-Commit-Id: 3418357a32db6c8ce5e4417964bac1edcc3f281a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23458ac91dc8e9a30c95b4208727f7e053eb5ff8
Message-Id: <165757589359.9905.17940865194395463097.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Jul 2022 21:44:53 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Jul 2022 15:00:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_unfreeze_fix-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23458ac91dc8e9a30c95b4208727f7e053eb5ff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
