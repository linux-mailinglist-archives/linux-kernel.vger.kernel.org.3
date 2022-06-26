Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4F55B42D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiFZV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiFZV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847EFF8;
        Sun, 26 Jun 2022 14:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF649B80DFE;
        Sun, 26 Jun 2022 21:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BC5C34114;
        Sun, 26 Jun 2022 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656278947;
        bh=Gy1FHWKJcr/uiy0E93qZmK94fcCSp1tK0BNRwyJwRMs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QNNGz5eL579fZ7fgI0iJZGxoLw8zMEAD2OZU+bCERn4nTG2JPE8tsftsS+KxY8E57
         za2xEw2rrVXXbrsePk6G2ABC8ULEipLyMbLs8UJaBTKTaFeh1lUDbuQDqtGSO4axi6
         iOW90Sh79twNYaDjSUBvZf+/JLHD9gKqzuYjvkA7f26hct1cXZ3YXeVEcaU2iEhw1C
         aiXQii0kYqfusLPb0UOsVLTNWTA39sHdzmO7xaHeVmpdzNmnubXUcvE2Q+2zBHvHgA
         7P1sU8twZgNIXIYeas4+X0AQievZCKtOCzDW4ywdAcDGxsknVC5vf2uHOjNgrqt7f4
         xMUuAqkyjckAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69119E73875;
        Sun, 26 Jun 2022 21:29:07 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 5.19-rcX
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220626125310.83a3f4bb1b38bf9408d7c42c@linux-foundation.org>
References: <20220626125310.83a3f4bb1b38bf9408d7c42c@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220626125310.83a3f4bb1b38bf9408d7c42c@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-26
X-PR-Tracked-Commit-Id: e67679cc4264cf9b318af4e8616eaa2a7565db1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 413c1f14919b3efee05eb79d2e913663e964abda
Message-Id: <165627894740.16687.9869113937593924797.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 21:29:07 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 12:53:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/413c1f14919b3efee05eb79d2e913663e964abda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
