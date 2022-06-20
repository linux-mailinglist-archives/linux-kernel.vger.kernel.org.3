Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC6551FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiFTPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiFTPLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:11:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4811E3DA;
        Mon, 20 Jun 2022 08:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 719F2B811D3;
        Mon, 20 Jun 2022 15:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B076C3411B;
        Mon, 20 Jun 2022 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655737209;
        bh=MPprBc0KIdBLLISM5SV2I5a6+uF+y4iS4o9gw6IVI6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rx3Q3oKb1r/kNagRc+G2kmiIm4pGM31yog/FPXftiTMpAXnXRGpGZQVhzsKQ60I8j
         bIvLqKFrYAYvzIPyWflZoBdmSvdjz4OEk1uU8WANreMYGlfwGxkov6la4JJroh9FWP
         YxTK2ti7RXV/xWUmEgxSFRnkYxPSli1Sum0PpEElSHuKQy7ZUkhFqDfeltvHLKwrHE
         MtEY2z0OJ/HBXwwnckh24Uk9Pc6SdySiaMhgkhare29IrHefYVDeq0EjPPcqOgVHv2
         8hmPzMfGb1zo1FZ50W3DM7yG1GlTgN/2xx+c5v7Aw1dneyQ69c9Ouwg2K+LqPFM3xC
         QfUyurk1AJquQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FFB3E737F0;
        Mon, 20 Jun 2022 15:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <151c2749ac4ca8ca853d36f0f6899b009c1db518.camel@HansenPartnership.com>
References: <151c2749ac4ca8ca853d36f0f6899b009c1db518.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <151c2749ac4ca8ca853d36f0f6899b009c1db518.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: aeaadcde1a60138bceb65de3cdaeec78170b4459
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78ca55889a549a9a194c6ec666836329b774ab6d
Message-Id: <165573720901.24603.17602886570659534559.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Jun 2022 15:00:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Jun 2022 10:24:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78ca55889a549a9a194c6ec666836329b774ab6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
