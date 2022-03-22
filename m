Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73884E37C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiCVD6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiCVD6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912A1F615
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99003B81B67
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47080C340ED;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647921392;
        bh=2qUbJwNjlCO1pM5wXpavarNoYKLfBM0UzMRh3Zuh7qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W/6ZGdTQ6iW/BWKTY3q9uEuRZnkI8K+rHIKOEAh4VYzyADimho4/YdwrR/j3XRVR3
         O4kM3WWcFV8SCjB2oXhxwtaiH+Fc4GasfmxCjrAVs9Mxo4Q7gDmGRGntUkp5fZcZps
         fezshUV2LlH+EJub7MfPfgH8/y6AGrqJIi2QcIApL2lRzOcmGPjxBDwYgm10DlzsQE
         t1vVScX6f09BAH19Ve1CcSNaKTzsEL0heu7aDbFuMZx9H6Pg38Hxr6RqxqCWCWOFdQ
         uG8LP/dabHHGHihFJb+Q6x9mDpklPz3vu2YPbxrUoaAr9u9RhNR5J17wVIawxE6K0Y
         X2Y4v0GxBJ2PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33F64E6D406;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
Subject: Re: [GIT PULL] Audit patches for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTdj=86GwGpv5bgwVrQp0v1o-a=YKKDw-vC_Er8uKBizA@mail.gmail.com>
References: <CAHC9VhTdj=86GwGpv5bgwVrQp0v1o-a=YKKDw-vC_Er8uKBizA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTdj=86GwGpv5bgwVrQp0v1o-a=YKKDw-vC_Er8uKBizA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220321
X-PR-Tracked-Commit-Id: 272ceeaea355214b301530e262a0df8600bfca95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
Message-Id: <164792139220.6005.16216709310945162956.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:56:32 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 18:21:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220321

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
