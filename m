Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF94E7D78
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiCYTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiCYTyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830E2DC03A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425D761AFE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75F6C36AE3;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228683;
        bh=xWndAjtzXElfKh1kSJGSvkeiA9j0twuZ4q7vaiTDrFk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HfPCOf3ALZUz5c5GetfKhVgEtr3bKU8NMOTDKnsS9BmVal4r8cGg7lrCSJ2ACEtY9
         iVelFc1IkbdLaJ0DvguJPxAGlEEuVf2OY4smOKYUzcM5BOob2WmcoMVBLQVIEOCKgi
         ZgZb4ul9HcVfDayZ05vABksVxyor60Mbs4VZapdmkEhU+2eJOQ5omCdHRPl5tkJIIT
         CQKrPzDUiReHXmKBx7e1Yl6jsusmCNjD4XWV/aJ2HEC5ZcW2JGdUGOsZIh9Kh4Kdaq
         gqGWfKlEpt0osSdzEQ2TO5KvRmXd64gg/VtYpveaTIAVnVghvNdknMRodz51Kg3QRO
         yv1z7wbQSaEdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9404FE6BBCA;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
Subject: Re: [PULL 00/18] xtensa updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220325154848.107863-1-jcmvbkbc@gmail.com>
References: <20220325154848.107863-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220325154848.107863-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git@github.com:jcmvbkbc/linux-xtensa.git tags/xtensa-20220325
X-PR-Tracked-Commit-Id: 1c4664faa38923330d478f046dc743a00c1e2dec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 744465da705f7d8cd893e97738a47b91f3321ce2
Message-Id: <164822868360.13188.13159486129428363014.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 17:18:03 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 08:48:48 -0700:

> git@github.com:jcmvbkbc/linux-xtensa.git tags/xtensa-20220325

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/744465da705f7d8cd893e97738a47b91f3321ce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
