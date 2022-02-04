Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E14AA13E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiBDUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiBDUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90AC06173E;
        Fri,  4 Feb 2022 12:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CED0614D8;
        Fri,  4 Feb 2022 20:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93290C36AE3;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006879;
        bh=Hvi3p7poLiA0PCPBJIJe3kwuLQLu3+RcXVsKrkBVzPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EuNUh5AB0dpNR1NQFC/C8KDNugsHSUQC7/gOTEORQ+VeTPMdoMdHVvCjuMFaNxmZ9
         BeOdSHUHewN+7nqXzdpwa2F9FYBoCML7YW5vRN1rfqoiagGvN2RgWQr1QzxGCHcVnc
         rvj2JHs+oKeLOmWMf/ClC/SFSX+XsAAW6R1AOi0M78tlsjxDdJOPWQUPbViYRnWIXv
         SjfORbDNBCvtUgH52P8VGMy387ukDexRw+BKIvjfb3D1YGPaEkd5ffQNL5cD8VMuwf
         166+bnFYZdMNy8iNeqeJNOij1RxqVFVCLJW7Xa0qiv7tynW2lCI2yPdQF+3ukN2zEI
         okNApRVfJ4ncA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82ED3E6D3DE;
        Fri,  4 Feb 2022 20:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h9f770hRMXazt4jk=9E01hMjQ41pZ5+Ym-4p0dCrhwmw@mail.gmail.com>
References: <CAJZ5v0h9f770hRMXazt4jk=9E01hMjQ41pZ5+Ym-4p0dCrhwmw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h9f770hRMXazt4jk=9E01hMjQ41pZ5+Ym-4p0dCrhwmw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc3
X-PR-Tracked-Commit-Id: 04662bac0067e2fd7f243d6abaa4d779bce14114
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddb16b08316bc4d57b9a46f4a470fd331815fb4a
Message-Id: <164400687953.31755.5137174729277983785.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:39 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 17:46:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddb16b08316bc4d57b9a46f4a470fd331815fb4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
