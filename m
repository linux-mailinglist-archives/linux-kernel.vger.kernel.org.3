Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34355269B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383476AbiEMS6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383465AbiEMS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BA6B7E3;
        Fri, 13 May 2022 11:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 369B0621F8;
        Fri, 13 May 2022 18:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BD68C34100;
        Fri, 13 May 2022 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652468276;
        bh=FPskEXttR3ec43c/xCCvh7yxyDl/xn0EKGRdDUlTovI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m84+wNTe0wN19qZWmcvLLy/4gCcJXmzvjpeiiXhFyHS+Imoa0GQ1aP2N5BpybAIbq
         N7M2ZHHTdlQ68wJaBRg9gVa7vIb9SmeXXV5fj0JRx6AL+H/ent5WKv4gUGITOLW/YH
         ijIMZfjo5pDtXIElSb3txnyrHSqnM4RjdarNd+eAvk5ED53P+M8HkdYv3wrpeyGtso
         Xmr5UuGI+znV1KUKrEkfw2ZED4CmNkAMV+JoHOeg3zlpMxFGw3zJw0UEE5X5bWuzXP
         ci3uqruZDq8ShwuxW2vklcWlaCwasJlOq/L7qRJFTjdddYqdS/Cc7kTZ93ELR5Dz42
         TlXegu6HHY+aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8700EF03934;
        Fri, 13 May 2022 18:57:56 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220513171259.30821-1-idryomov@gmail.com>
References: <20220513171259.30821-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220513171259.30821-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc7
X-PR-Tracked-Commit-Id: 642d51fb0775a41dd6bb3d99b5a40c24df131c20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3f5e692bfccd87ff80a582c298e8ee64b188100
Message-Id: <165246827654.27296.9713449969705357835.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 18:57:56 +0000
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

The pull request you sent on Fri, 13 May 2022 19:12:59 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3f5e692bfccd87ff80a582c298e8ee64b188100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
