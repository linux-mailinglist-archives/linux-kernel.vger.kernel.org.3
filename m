Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FA4F9BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiDHRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiDHRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:48:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FCBF947
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3517B82C8B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A4C4C385A6;
        Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439981;
        bh=iiyfl2Yysk4HWBoxes4BD4K9Uh4RXDRGVdi1hqgLl5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cxzXpW1KPgbZCW/OXB9o0eMbry/F/5z72xmFF4QhGbHjidKwckGFNr+23FgkVNamj
         eU9PRQmeg+m1ytm8j5WRoUGj9RVoOtgzRHCaXFKVwDsJauP5v85yXBjdVVEWrGy2mi
         MmicS/Vi8PTr/OX9GJ66MgvrjwfjK+kBgXYxH00+V3W/Idy6ThzVl8DN720k48+dlK
         jn40jVioR4HG3zasXzX39IFzMZeWx9pZ9qqn8bwu6iFYlRMwGu/vpsi957IECmJ/3g
         G5xfIodw+PPlQvUzU2b8tQknB5otuwIfDgC90m9p4+L0SzTKy5oAFQZykN4m0/Bhzr
         Ts3yDmYtBfD5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 888AAE85BCB;
        Fri,  8 Apr 2022 17:46:21 +0000 (UTC)
Subject: Re: [GIT PULL] Folio fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlBYcG5bm03dhqHI@casper.infradead.org>
References: <YlBYcG5bm03dhqHI@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YlBYcG5bm03dhqHI@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18e
X-PR-Tracked-Commit-Id: 98ea02597b9967c0817d29fee2f96d21b9e59ca5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d66b6985b164b368657333c4a700bf4108893612
Message-Id: <164943998155.23047.8859359528773664297.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 17:46:21 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Apr 2022 16:44:48 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18e

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d66b6985b164b368657333c4a700bf4108893612

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
