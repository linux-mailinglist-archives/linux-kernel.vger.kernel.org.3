Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFA59A79C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352265AbiHSVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351733AbiHSVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32FD8B16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E79861740
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F51CC43470;
        Fri, 19 Aug 2022 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943682;
        bh=bVyygMJqXjHZs/ubCvyvtCbIxf4bZUWXWI07tyDdv6s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HAHhIvQhGkvvCEYeyGTxFtpwqJqurhw+nq8qicxP0s8RLINn/KpOeCLlHMi/b0Bwf
         O/LYvAeceBcH7ip7IZCWs2uMPj3Ni+Vy/QIGSv+ielFWc2TsmZORwAWaDXIcMFllda
         fMLCm2jDbk4MHeKixs76KoDP3E3c6cnlZCb6Wl0nNPdcN3diKtjIBv9EJH/JbPxFLq
         istuOkj20hY8dk8/u5dlNd7aFB45/gGqPAkUyXl6Xm7DqCSEzO2frkgLO/SNOV99Lo
         rKIDhxstIs5lA4V9gvNIkTIvBIz07oZEFfkIuCZPZr8I54E9mrqeKyqMJ+HpDowLnX
         BTYrXJNAO8SDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F179CC43142;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] execve fix for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208191202.5F5A43A0@keescook>
References: <202208191202.5F5A43A0@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208191202.5F5A43A0@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc2
X-PR-Tracked-Commit-Id: 3a608cfee97e99b3fff9ffe62246a098042e725d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50cd95ac46548429e5bba7ca75cc97d11a697947
Message-Id: <166094368198.15089.14893789497374628649.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 21:14:41 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 12:04:07 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50cd95ac46548429e5bba7ca75cc97d11a697947

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
