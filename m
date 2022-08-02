Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0A5883C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiHBVsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiHBVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21125C79
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F7DB819F1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D24E4C433B5;
        Tue,  2 Aug 2022 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476905;
        bh=iRMGQ5OtlzsybhLXVlgYZ6PYgb4fewEviJj1wqSmKGI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VMcK0JUpzZ69bmTN/xlKmoHw14N3ye6rk7d2hsTVv/nyShKOij288omqs6DF/dwk0
         RkRpMvxiPM+uDKkLEFhOa5pnY7MNcVTOVDObMJENWlYwqIZtRUY8yKtPWQS5NiyQX8
         0gIClp09RT/hriPHFOMI8Etki3dX3dGCIa3GesfafYv8MT/HMDzHy8uWNVfywNdgFe
         q/1A/kEOnowd3zyzZPe7y4xbimGpp0wbJLOoyEZ4QGY0ujb9GkWWGhbGbovmxR/fBN
         Or3sT1FjjeNhFvhts+q/7VqAEvmCXIce/In5ghr4mvBljNiX+QJgqdyeTNSzcIKcKK
         +hy3XFZU5bmeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB9A6C43140;
        Tue,  2 Aug 2022 21:48:25 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp update for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208011033.344AB17@keescook>
References: <202208011033.344AB17@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208011033.344AB17@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.20-rc1
X-PR-Tracked-Commit-Id: 3ce4b78f73e8e00fb86bad67ee7f6fe12019707e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a8ac9ee07d445d81963756f0b18af4f06692258
Message-Id: <165947690576.15647.14699678956538513610.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:48:25 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        YiFei Zhu <zhuyifei@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 10:34:16 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a8ac9ee07d445d81963756f0b18af4f06692258

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
