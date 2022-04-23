Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A950CD79
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiDWVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiDWVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8B11C12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0EA8B80D6D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DDE8C385A0;
        Sat, 23 Apr 2022 21:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650747634;
        bh=RzYZ8CVv9KyE6w4BSTCQ7iFCqpRihYLBT92FFn5f1+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bww765jZMMB8Rgrvn+scGPWxo8/sLdHM76w7xAJMiiM8UJ5UUUj3x5aQa9w1rqmO1
         EppOZCNKyxvnIrteeEEEw/nuOPd5N2w0WiIDNJSJm8fWORljrehe1AzE/bktCsrjo0
         3lkZjwQXNDr07zVAlMV/ZolAFadDT65OFroefsXoz+IMoGWygT/AXPK95gyjCd1Wj3
         Eg6sxs5fn30nX+UMDAwzluRcgm+LuvXlMKibVSuwnJJJqHRtVytxkPWA4m31yZkDIH
         IP6DWT9AzGvkN9Mk595jWKXCSQGue0+6r75kxAcjXqREV9pegjVi92doi5UhrRa0Z9
         NJiQfKHDkaF/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6ABE9E8DBD4;
        Sat, 23 Apr 2022 21:00:34 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220423130806.15699-1-jgross@suse.com>
References: <20220423130806.15699-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220423130806.15699-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc4-tag
X-PR-Tracked-Commit-Id: 533bec143a4c32f7b2014a159d0f5376226e5b4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b51bd23c614bc5a8a905d258133246e78d611df1
Message-Id: <165074763443.21099.15482523060926556291.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 21:00:34 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 15:08:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b51bd23c614bc5a8a905d258133246e78d611df1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
