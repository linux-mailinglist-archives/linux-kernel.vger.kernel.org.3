Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC85A2E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbiHZSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiHZSKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAAAA0314;
        Fri, 26 Aug 2022 11:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFBFDB8321A;
        Fri, 26 Aug 2022 18:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B593EC433C1;
        Fri, 26 Aug 2022 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661537420;
        bh=c5vJoE0xSMqYM8RxNqyCF9VlFiarluY8kv3XnK1Ruaw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ffW6wodEJkf+5ZW/guePjq+EJ5MazTyjqObNqr266EMFos/BYZ8FG0QcnzLmMg8Yu
         mui2I8VB38EC9oJ9sFPVwgJTM0v0rB0Zhv4g+7ckUpe1kYatg8jkEWrfqfCx4k6Mml
         vg7EqQJdPEsM16n6pag+cai+NOHf+YR2k1e/U6lO4YfvznI+XxwnbjF1m4NTjPKs32
         cu7xcfcZyqCbWuXoO7cnDPzjWNl3wwhMkgd4pqbgQwUE5e0dUC1LtOXokq8/AHFSY0
         gSzzSWi8ORVoz94pv00KFhjAdbzfLTT4OCrIutKohR68Eqev3BO6a8FS89qFSVf8Er
         YM59t5CIGkTyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A38D1E2A03B;
        Fri, 26 Aug 2022 18:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
References: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <042650172f59fca9836fe523ce14a07daccc4f2d.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 785538bfdd682c8e962341d585f9b88262a0475e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5373081b99ed3c8e6e3866c366bf43fd8b03013a
Message-Id: <166153742066.10059.3511695068065758056.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 18:10:20 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 08:39:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5373081b99ed3c8e6e3866c366bf43fd8b03013a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
