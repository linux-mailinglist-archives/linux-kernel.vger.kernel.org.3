Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B454EFC52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiDAVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbiDAVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:46:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79F10E06D;
        Fri,  1 Apr 2022 14:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 828BDB8267E;
        Fri,  1 Apr 2022 21:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0A6C2BBE4;
        Fri,  1 Apr 2022 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849503;
        bh=GMRm4Q5uJlyh+H7BFg/EbCOG7w4sobOV6O3PjNSVxQQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QDBUkJArkVVGBx2a5VIpgJbJk2N7QwH17sSSMTZM5mOWn+9wa+ZX9lRXK4X2kGH5K
         c2A3I571PusvVH5JvQuL9JcwubkUeJ0gHI/Mu86DovsBcyiKRrLWkKIn9JJbrIMDjm
         Z+RiMdkqJZtNTdk4yy6NwgCe6FcJg0AM+FFKBEdv5mVsXyULDOxpxlV40DOcZQDimV
         blO5fHyVGpUJJYRYKcZu10tJhYHsHNVL30Nv26l7rxxjkcC+1QtDI9gPu3OnmVastJ
         XI+miCiUI4jbHCgA/JbS7T6LocgcaCGaBql5J8IRmpCzUtWBbMrJOsDlEvgtpFAQuV
         nuF8mLkVLbgQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17E14EAC09C;
        Fri,  1 Apr 2022 21:45:03 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.18 merge window #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01648819760-ext-9805@work.hours>
References: <your-ad-here.call-01648819760-ext-9805@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01648819760-ext-9805@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-2
X-PR-Tracked-Commit-Id: faf79934e65aff90284725518a5ec3c2241c65ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ae24d5aa001622035270de8f46c0634e6c6d55a
Message-Id: <164884950308.9554.10067085025705046541.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:03 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 15:29:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ae24d5aa001622035270de8f46c0634e6c6d55a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
