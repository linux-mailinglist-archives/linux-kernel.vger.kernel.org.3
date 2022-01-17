Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C149022B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiAQGzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiAQGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:55:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA9CFB80DEF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE7F9C36AE3;
        Mon, 17 Jan 2022 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402502;
        bh=lkh3Fnsw4wKfRz3AhfD4IVu6rnyPCcubPmb7fEfuoTM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p6ENgGOEOFaoh233yOR6ayBrxOjmaqvVRbvvTiNu7b0AgcGPooes05Cm4oKYEjT+1
         CmYpT19pRdaXOsJz8fZbryKZMe515d9jbNDokPG4PgTvWwvI86ssKtjvMxj4/z6gi6
         F3iLmtoQWJ3IAwV3PWi7Vv1YFstUUrHvkiHgOQSrSMHguS8zX0kIbJA0VeWyvXcWAa
         YrJcnauQz/tHk34ECwM0rxPl08Rz598PljtR2yT/g8xnfjKaDFZsm/zJDMYVx6+2qb
         ELKuYiA60N/5OHpFUlC25FydHkqHGvhkq8nYCATDoUNN/LZ3LH3G9Gny1Km2/DCKJr
         m5EubtWfu1s+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE149F60799;
        Mon, 17 Jan 2022 06:55:02 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for vv5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeQ4Uz9mNkff+ypm@n00b.kudzu.us>
References: <YeQ4Uz9mNkff+ypm@n00b.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeQ4Uz9mNkff+ypm@n00b.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.17
X-PR-Tracked-Commit-Id: 8cd778650ae223cd306588042b55d0290ef81037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96000bc956628dc0cc608696d5385ffc19e65a76
Message-Id: <164240250270.26213.90124789896210026.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 06:55:02 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 10:22:59 -0500:

> git://github.com/jonmason/ntb tags/ntb-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96000bc956628dc0cc608696d5385ffc19e65a76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
