Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C644A2F89
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbiA2Mvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:51:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59424 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348930AbiA2Mvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBFD3B82699;
        Sat, 29 Jan 2022 12:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EE8CC340E5;
        Sat, 29 Jan 2022 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643460706;
        bh=slYslZQ45GIYTMB0PcandywQ7BLx8c7CxlZa45Dwh8Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HCMXBYUyW1225Akr1+uX231qDLNnRkMDBP1b68Xn3ypNzlSpzGNSLu5ZoVnf4D0hF
         ldrECHeMk2dRs1q5AGz7raRpldR6cE21F0NgQu7RxKiqIKkrgrbNstcDbcQjBU30GK
         1XUlcee0nAg0btAfIamJ/Yv/m6AVl4ey80uNLCC5RbRn5dadq0SRkAr/WrtnGKhiAh
         7wKPYBoBKSX3eE9HLOGAOvoJDh/6cfuInDf6IcBY3BeMOPmorLwT/5j2H5UkXhiuXz
         HisD2bj7sHcOWJTmgoo2Pa0714X3vqRu8Y+njLLXb1pQBp+WllW8+TfqeOaWoB3mpi
         SQnugeKeMAArw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DE2AE5D084;
        Sat, 29 Jan 2022 12:51:46 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkzvojdu.fsf@meer.lwn.net>
References: <87bkzvojdu.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bkzvojdu.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.17-3
X-PR-Tracked-Commit-Id: 854d0982eef0e424e8108d09d9275aaf445b1597
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 246e179d637ef8432fb223e4a7ddced740a32350
Message-Id: <164346070650.2828.3181406710785593786.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 12:51:46 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 10:33:17 -0700:

> git://git.lwn.net/linux.git tags/docs-5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/246e179d637ef8432fb223e4a7ddced740a32350

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
