Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6C4E5964
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbiCWTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbiCWTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE08B6FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04EE56160B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63144C340E8;
        Wed, 23 Mar 2022 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648065053;
        bh=rbzDM0v2Uyogd6lc9doWubvCyYchFpf1ZMn2FXT/ieA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TpU4EmO9nQzSnGY/uJcroFMQzYs0Hf7fltKJodFu/SKy7aWSpfOnZlvKLCRWOIpXf
         2aRVrL2IlBtmy569rn3AHXn0CbsfCXJRTfX6USiYTalBo1UJpRZ0092yT5WXeq3+rv
         FvRUOm311UcHSVNSy5arTiygoRjyeOBOopG0e5hNDzgIpwCDZqoYCG6WFQ7fbJgpMz
         QmPYVFCnLSME8IlhYMR6lXjNSaIGoVbiu8REDbH9J6yWiJlSTdktXyTlODH0hpmlw6
         1ee7BQAqMrf4fM0LC6WHdsmB7fTPrxooda7bJ/nddOEsAeFUpPuxo+UkHbCLfwH8CH
         dnu3WwFLXTBMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FAB3E6D402;
        Wed, 23 Mar 2022 19:50:53 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yjjb/qouuLRtV2XW@slm.duckdns.org>
References: <Yjjb/qouuLRtV2XW@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yjjb/qouuLRtV2XW@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.18
X-PR-Tracked-Commit-Id: bc35f7ef96284b8c963991357a9278a6beafca54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78383162605e22a2aad88e417bb8fcaf808f147a
Message-Id: <164806505332.21505.7817738186661995698.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:50:53 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:11:42 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78383162605e22a2aad88e417bb8fcaf808f147a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
