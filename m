Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08F536719
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbiE0StL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354454AbiE0StD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4690633A29;
        Fri, 27 May 2022 11:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFA59B82636;
        Fri, 27 May 2022 18:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8511C34118;
        Fri, 27 May 2022 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653677339;
        bh=SbQk50Q7Finyci9EDngIQJNc8si7TqVP2/ey5DlIWHI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cubr/OVPL2ITKZ8Z1w9vYmK+jyDkxHOn+0nVnZfki2q88UPpeZd1pJiDe20JNb0Hv
         +7Z7MURA4bQl71fGdOjgNPB8Yo39G18XjKYlsHUJwkQ9iVVOLI8EUFURXhoOTxFRCJ
         hF+tjffjDhwyawFtBFTrKT7wmAjrSA7lYlC28NVuQcWxvRwEkWzpuO7sH2r+wShG88
         oAVAhfRcuILQf8EFwpLFRovo1DSLFh1TRQnw3lPp5XD3TvFU9MQwy0CAoFwgAm5Pkw
         4XiMyTLW5Lgdjk4u5W9yB4SMU0MY/uVq0+lsSW3jDKRhn3dU8ULe0UgMusWO8ozVp4
         uSRXIfWMH+xoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A34C2F03944;
        Fri, 27 May 2022 18:48:59 +0000 (UTC)
Subject: Re: [GIT PULL] additional MM updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
References: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220527103014.517818624f9f6d4f0ba0b523@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-05-27
X-PR-Tracked-Commit-Id: fa020a2b87d24016723fff4a4237deb612478a32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8291eaafed36f575f23951f3ce18407f480e9ecf
Message-Id: <165367733966.12450.3553347697030042023.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 18:48:59 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 10:30:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-05-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8291eaafed36f575f23951f3ce18407f480e9ecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
