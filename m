Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FC4B5925
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357272AbiBNRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:54:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbiBNRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:54:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD852AD2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9544B80B67
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F0CC340E9;
        Mon, 14 Feb 2022 17:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644861266;
        bh=OciRMCTtL3UsqnDQFMtRD0hYNmRN/uIBlyaLlLrJdG0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jOEdufvLpmyQOFm6RzywJbp8Cf6RiBS40c9cL7QmXfx9WKht97b1AKw7D5gkJ1CNl
         EkhpNblR4woHueqm/n3VfWZAt9x04I15xqUxPTiYePVR3M4uan59RmaLR+llGDje06
         6C3GpKpQCstk8XBU41vaRP0xNEKXpskI1mIJ6I5O39b2JDimIT1q822kTV0WuzQsbM
         6vXvXELzJGwBkkscShZ91Fx8wN/wOdoJ2In+AvJH4lV1t38qewqa0IUoVWdDVpSjFo
         HJCF7O0/oO8qrDLMJAo+KghBsN3Sb4rdjIhEpoBMRpSr7JDJ+7hakJ5T+ht46eR5Ky
         60q3uG3wq7N3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 750F7E6D447;
        Mon, 14 Feb 2022 17:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220214163149.D1275C340E9@smtp.kernel.org>
References: <20220214163149.D1275C340E9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220214163149.D1275C340E9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc4
X-PR-Tracked-Commit-Id: 4e2a354e3775870ca823f1fb29bbbffbe11059a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d567f5db412ed52de0b3b3efca4a451263de6108
Message-Id: <164486126647.4613.17053988035870830551.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Feb 2022 17:54:26 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Feb 2022 16:31:42 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d567f5db412ed52de0b3b3efca4a451263de6108

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
