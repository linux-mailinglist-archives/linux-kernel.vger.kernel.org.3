Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B34DEA68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiCSTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiCSTa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:30:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5719A54C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC539B80DB9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 19:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A483FC340EC;
        Sat, 19 Mar 2022 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647718143;
        bh=GE++7QmK3yqknOXKEqIvu7n1y/5EjiY/HTluYzb5l7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M/8JXL70SGnewtUyTiX0tX5qkF4hxyqqoOD3ohn+wp/oPxvcDgIgXAy7+Kq4EUWcs
         S7U4S8yCg2NwCWZjS7fYVg5zCApavhX4nBXVjZ2XCtAh5S6gW2R3NfOx2rIIsVJzSp
         NVTxwhCWR0eu3wMvRVK0U/fObYz0VFoIFZKVtxYQVHP5hOzXCrSsTFfHKL+20XTebg
         HE7rstxK2WHyDYRYMTjh84y7IYnRClu6vlRMFv0e36eImOOtSb127R6gL89ey3Vu0Q
         /Ex+XynMA7N9ewesErjgml1HdEhge6ZrEXj0z2PB5gDW4oRd7ttzFMzJEeCDamBPBB
         1A6sOlFQ0Z/Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A2EE6D3DD;
        Sat, 19 Mar 2022 19:29:03 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 5.17-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjWT8WkVKO9ykfey@kroah.com>
References: <YjWT8WkVKO9ykfey@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjWT8WkVKO9ykfey@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-final
X-PR-Tracked-Commit-Id: 01b44ef2bf6bc83df8a4703029fd611fbfc31c60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba6354f61472c5bc910c34ea1b368f62c3706692
Message-Id: <164771814359.23927.7592262365943386713.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Mar 2022 19:29:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Mar 2022 09:27:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba6354f61472c5bc910c34ea1b368f62c3706692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
