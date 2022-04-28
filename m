Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B4513B42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350832AbiD1STj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiD1STh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB163C4AA;
        Thu, 28 Apr 2022 11:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0817660F66;
        Thu, 28 Apr 2022 18:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 600B2C385A0;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651169781;
        bh=qPdfhy27XT2yJCnYHpoLRsrZH9zttwQKzj7Jcr56RUY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f8I1H3wVH7ZCDZRoRGDFzdQLK9BocgRGfcnN7q6bU7EHQIlFYINtpoZzjcPDuquF6
         yaS3Joszgbof1k0hWF2NkGCVfFSdPqr+ujd6ABFo2TSkDtoyJFX52dhy5hq5ae25dd
         Me4P90Is4y8KdYozxV3fe7WvO1vPimD8S0ZE8TrlZvBhl6PWkV8mc6HGsv1RPuBzWm
         2xC7iumcgHFL65kWe41O4mUgV3jlJIP6I2vDDO1Oa/jC52QBHdscG8eCm9wXk72fqy
         n+xJn957OGtuZRTgdupskJla6akwT3r7CRxjcu78GSeB12DdtkmJXvHYUgCBOGcljg
         Lz3FQt4aB+pIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E495E85D90;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220428061921.GS1098723@dread.disaster.area>
References: <20220428061921.GS1098723@dread.disaster.area>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220428061921.GS1098723@dread.disaster.area>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-fixes-1
X-PR-Tracked-Commit-Id: 9a5280b312e2e7898b6397b2ca3cfd03f67d7be1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8061e16e203f36e7a5990535760ecb2e60a365f9
Message-Id: <165116978131.27414.10717205621915392616.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 18:16:21 +0000
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, djwong@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 16:19:21 +1000:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8061e16e203f36e7a5990535760ecb2e60a365f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
