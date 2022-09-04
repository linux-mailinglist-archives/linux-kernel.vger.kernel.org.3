Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53D5AC5EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiIDSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiIDSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 14:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA80A2CCA8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 11:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BCCD60F63
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 18:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08FCC433D7;
        Sun,  4 Sep 2022 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662317592;
        bh=XGVBCpcbQjTXsoctbuqnBV80HjB8HC6Kskm3XYk0lT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ua7IDjsVfWbcR++r813DDaCyCUlnL7BSGr6Llx0ZRvNXvi2BlqrCfSWXjNPtLl1yo
         dzshRWe2jCRoB676hO3zi3YXuA8ZQYxo9WXOCWn6so/+lyEt4KQWvBONimwrk7qcel
         YPFEuxdbWRAD1Nw+znftkC9+fJnG7SkDPe89AYktmhC4u39zbReiYXxKkg/y4aRMB2
         /1Q2Sdk9hK3FpgFaBPq5i/5BG+s5H/wrm2AESK4viBFOzebT/42Q3MGLcAijXfgXKp
         N0gjrCsrm/J1DbiDhOO4q+Iu8HGktS+rA/merbN2Ced6sB7vu45HsDsvy5wadxWw7L
         hXQif5qKtzW2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9D75C59A4C;
        Sun,  4 Sep 2022 18:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsh7tiy8.fsf@mpe.ellerman.id.au>
References: <87fsh7tiy8.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsh7tiy8.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-4
X-PR-Tracked-Commit-Id: 6cf07810e9ef8535d60160d13bf0fd05f2af38e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5995497296ade7716c8e70899e02235f2b6d9f5d
Message-Id: <166231759182.23278.6365801431590762876.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Sep 2022 18:53:11 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        masahiroy@kernel.org, nathan@kernel.org, pali@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 04 Sep 2022 22:36:31 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5995497296ade7716c8e70899e02235f2b6d9f5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
