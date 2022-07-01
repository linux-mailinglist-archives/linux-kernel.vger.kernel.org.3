Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059F563919
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiGASPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGASPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108614082;
        Fri,  1 Jul 2022 11:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BFEE615DD;
        Fri,  1 Jul 2022 18:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BCDC3411E;
        Fri,  1 Jul 2022 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656699338;
        bh=Nju7zjHnfCLH8yIlClZmv1TDjoL1YNaLpI10xuOI2o0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YnhOlAlZ9/7osScfHvTComGZDLtUs7kKsSg4sCgF+IL6QGOLXMSUKZ/QYnCnPHVcA
         gEvXn+TqcB6It7aQ2wGizRVD+wg5jDeI42Ee6m5ZCRYJmPLlneTO7aaNlFShTJaYiR
         pKk5Jf5FSpHtU4H7CGIQslWjgdA8N10kw/wJURqHqCv5mI1bh6shWxRPh4M8+Jbpy4
         AAfiE+zZ5FTYre+G6JuqqMWjnxuDoub7CL3awIIXQ2b47iyp1tnrDdC5JAVYRtWM/m
         bFiT30SKsNZNGH3wOsa8qhtb/X/tT8h9BbI++SSvccul6lW8mz1ywMumvCDYa0GuFv
         YVQIrbQNbiRrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51EC9E49BB8;
        Fri,  1 Jul 2022 18:15:38 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220701150409.9288-1-idryomov@gmail.com>
References: <20220701150409.9288-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220701150409.9288-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc5
X-PR-Tracked-Commit-Id: 8692969e9164c15474b356b9898e5b9b21a85643
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f8693ea2bfe8c10a859841b907bc7c8f41dbd55
Message-Id: <165669933832.22761.275788513355221693.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:15:38 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Jul 2022 17:04:09 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f8693ea2bfe8c10a859841b907bc7c8f41dbd55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
