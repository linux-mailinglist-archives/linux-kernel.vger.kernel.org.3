Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D734BBE92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiBRRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiBRRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486EE888E3;
        Fri, 18 Feb 2022 09:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9483B826B1;
        Fri, 18 Feb 2022 17:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF0FC340E9;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645205999;
        bh=SXr/bFDFwYAWUDgZ69MAEXJTNk1k6ybdXzqBZLk68c8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sQ4P/AJHzz5cil2t/Q0JM92zidBn1pO87yybtY1TCBBr1vmF/kxLiNA28oSkSxjcY
         zGAq2kY0AJqztBcZtWOMQyWqbHxoQbzJkPoJcjHvlLptMAommQMgx3Zg17qYq0y/H9
         Zrrj2QDjrXpPY8tJCDnChIb8VPascAlLFqMlibR5TKk6dAupNhZgTAcP3UuoA4dDt0
         xmdubaIaVyBCZ8dRawC+9TIEWbopGn6fW+abzuPQkSZwm0shhdm6SGZClSitm+TYMN
         XptZapC5WoO909Y92Rmf1u4DlBGfiZ/HFb1gcvN7vVVFrU+iN0zeArI8UICpVbdG9h
         ibLO5SK3fUPZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89F3FE6BBD2;
        Fri, 18 Feb 2022 17:39:59 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mukF1Af7TyrQPbvqQ1bpV67+btHiFstJLUh0RpJHeTmSg@mail.gmail.com>
References: <CAH2r5mukF1Af7TyrQPbvqQ1bpV67+btHiFstJLUh0RpJHeTmSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mukF1Af7TyrQPbvqQ1bpV67+btHiFstJLUh0RpJHeTmSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc5-smb3-fixes
X-PR-Tracked-Commit-Id: 53923e0fe2098f90f339510aeaa0e1413ae99a16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7476b043b1914413f75b7e99040969734ae1fab6
Message-Id: <164520599954.19024.10147255572362358663.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:39:59 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Feb 2022 18:26:04 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc5-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7476b043b1914413f75b7e99040969734ae1fab6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
