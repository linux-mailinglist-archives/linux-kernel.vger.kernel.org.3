Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721845090FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381966AbiDTUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381882AbiDTUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:03:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237513D481
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B31FAB8216C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 577DCC385A1;
        Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650484820;
        bh=QqV87m7fP2qffAEvZHncjqlUzSmtRv+pIC3XzpEiCFc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iF8Mq2n/imsVVePqo0SXyakpy5l2x5rPjeiJXT/6ldj0laSqB8mLKWwDcEN00Wmcc
         HYZQME20e3Supvi9QThvMwBPMVadW4tAEiz5eqmgif9mzZFMkkphR8vNYpWbOq+K3d
         pWw0ScVj1t+L1EOEqYGULLIrps90LX3eFDGoHvGVmfLgEqbFfE75KZ35APLiS/+nD6
         6rP7/sfklZc0LvhkLP6a/qqvsb/0hpK8RtdhbQWGZq9/SwS5CPL8U/JgcbtHqzoEsF
         46tV7XysExt+fGmt+/y9oZAiQ6JCJsDer/GBM2HjVu6vL1iFE6U1CfwTiuVX2fSw7C
         VS2Mq5pIumaZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A022E85D90;
        Wed, 20 Apr 2022 20:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yl2VJEuDCWT4lycg@debian>
References: <Yl2VJEuDCWT4lycg@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yl2VJEuDCWT4lycg@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc4-fixes
X-PR-Tracked-Commit-Id: 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10c5f102e2be6d816938b168104e8dacdd5bace7
Message-Id: <165048482022.8655.12098974779681773850.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Apr 2022 20:00:20 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
        Hans de Goede <hdegoede@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Apr 2022 00:43:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10c5f102e2be6d816938b168104e8dacdd5bace7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
