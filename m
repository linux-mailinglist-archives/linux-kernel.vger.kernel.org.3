Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703B34B3765
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiBLScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:32:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiBLScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:32:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF06007E;
        Sat, 12 Feb 2022 10:32:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78C73B8015B;
        Sat, 12 Feb 2022 18:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D66CC340E7;
        Sat, 12 Feb 2022 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644690730;
        bh=lElWEkK9KVUA3sXaWnjeqA2oDIkSNbK9F3C4lGVBpQg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WkrxD9SRCwG682rEr8fQHzUbX7oaDjRMjz16x73idgfle65+bMrq0m9SNu/BX7Mg+
         QsE+7XWGTTyPYrGaSbTNDtRA7b/gbJ4kvXPQYMesQE8gjK8pMnJcvDHayAwH+qqCEH
         ho8t3GcFdl1uyrYnq5nzwpDc1kTL0MUqn99VJFZD6+sHmBCe/kg3nlaSpESgw9Plu2
         +7SYSMcWQ4oxnXZkCT9dG57skoOw8Wr5NgnVD0gkIYX9LHS/RARgwJRsPwR7GaU1ZI
         btKN00yyiV3KDTInd5ZqzRwUWG4tKMLKdjIU6J6N97Q/kQ6B2yEpIXLNUvDlh5LR8G
         SDPYhH28oQsaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C57DE5D07D;
        Sat, 12 Feb 2022 18:32:10 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0da592e3664041ce007c287391cdb40fda2d535e.camel@HansenPartnership.com>
References: <0da592e3664041ce007c287391cdb40fda2d535e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <0da592e3664041ce007c287391cdb40fda2d535e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 5852ed2a6a39c862c8a3fdf646e1f4e01b91d710
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b81b1829e7e39f6cebdf6e4d5484eacbceda8554
Message-Id: <164469073010.20832.7596619303007411769.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 18:32:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:41:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b81b1829e7e39f6cebdf6e4d5484eacbceda8554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
