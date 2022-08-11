Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FC59081B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiHKVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiHKVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36B9C514;
        Thu, 11 Aug 2022 14:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45C57B822A0;
        Thu, 11 Aug 2022 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B280C433B5;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253534;
        bh=sJWOVCUYCRrbmbxBk4hE/IjjXByvFg6OZUvMLfmHC6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2Rs2yJnwDjLJzXedBpDz4R+w/H70v+C2xzS19jTCixe/3SvK/h9mw3GMlhDl97M7
         eB9+dKH+k3G28dp1Ss84AXNcj9lxCt8qiwfZkbsZuwVtOMPG/N4wSYdjn5PbRLNGQA
         FqsVmyc2PoFq4Y1IJdhTYQ8NRWbfeVX17Ouf+GYqscCARgD2N9PLgaRzOoHTmRjzsD
         RjrnpJC7DxCVNvk/v8xC2uOfXAWCKocSjSJNQOmIQLDdrIdTNiCBudNjP58qbhO0d+
         XDHE2WbTwGHbPAeDknBwxstx24BvohrWC802ykRnQaCSWEc1DV2rAr9UtdQ8/yxA+L
         9hlMmti8GFnfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDC2CC43141;
        Thu, 11 Aug 2022 21:32:13 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220811152446.281723-1-idryomov@gmail.com>
References: <20220811152446.281723-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220811152446.281723-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.20-rc1
X-PR-Tracked-Commit-Id: a8af0d682ae0c9cf62dd0ad6afdb1480951d6a10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 786da5da5671c2d4cf812fe1ccc980bdde30c69e
Message-Id: <166025353397.15191.3484507526418225479.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Aug 2022 21:32:13 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Aug 2022 17:24:46 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/786da5da5671c2d4cf812fe1ccc980bdde30c69e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
