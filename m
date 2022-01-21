Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C68495AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379058AbiAUHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379037AbiAUHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:38:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F476C061574;
        Thu, 20 Jan 2022 23:38:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2623BB81EAC;
        Fri, 21 Jan 2022 07:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD4A3C340E1;
        Fri, 21 Jan 2022 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642750691;
        bh=Bby0Lf8FpZWnZ8SeUIyo+dyyamsTbnsAGYL5cMw89WE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hRsb5Exsy80EeP4N40d5xDxeyDQa/kk2hXoOCpMJ17/sniZzCWyKpGI/wiH0vVYac
         p/oe+oXmsm8f48L+YVr8C02VzfIqLqDQmbeIcLsKGOmk3hrboOIsALzay6182D8ypG
         U6g7p7EuMURVk5nu9yagVupvlYm+JsMNKdOTYaiIJMADyoTL4x0MFZiaRUTZGftuTU
         aqHZ6jZymCxRJdF+j3PpUlvRhsg961O0PVS+Ww9Aew8KDf56hC9qLhSdI9nnMSKqlY
         rSTtlBaWEsOh2o0k9fcSqGY9R8u7e94LA0/nCwG2ZGa59lFoKTbyGo+bSS7fIGAQ2n
         1+vpFH91zLEnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD122F6079A;
        Fri, 21 Jan 2022 07:38:11 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 5.17 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YemwXCXL/21UedM6@osiris>
References: <YemwXCXL/21UedM6@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YemwXCXL/21UedM6@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-2
X-PR-Tracked-Commit-Id: 5754f9084f261f6fbfdcc6e57dae97c86a6ff688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85e67d56ebdecd8601d62e3aadcd2927845c97b9
Message-Id: <164275069183.15932.10282060775573633032.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 07:38:11 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 19:56:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85e67d56ebdecd8601d62e3aadcd2927845c97b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
