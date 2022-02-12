Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF14B373F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiBLSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiBLSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E07606F3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FA1EB80814
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 18:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB86BC340EE;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644690195;
        bh=aclq4BigH/5SnTkWtvIFs9ppgvX17gruplULvi9rNuU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cGYwzKf6BHl0KYgAEKw8RCKqI0VUOpXdlUNOep+EExpp2NwxyXXczz3pAJsj0kPJq
         8wVRAYqA8KmGMS37523wRPA8y5nEtw8ddz2Rm/B3gYNGD3fNiT18XfMY2Zv7IuIbuO
         0G6pTFt4Dq6Z/yy5kmg8pCiPGyCWFiv0sO1I5Yvyq51aI0FYKmxfQ1phDVb9LjVP5c
         Kwq/ynSKcBMw2beGCh62gYVkWD7WO09VidmgdjoJvZqKjPkCET1gTxWDl40RTWyGvf
         7wPzQP3IE79A88ffND8mtDmSEjE5BjGFKXyXqfCfW2ULoT07L9KEXmo87+cJo7c0lu
         L09BYMFDB/Fzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B96EFE5CF96;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgeMgTqMg82ZC7hA@kroah.com>
References: <YgeMgTqMg82ZC7hA@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgeMgTqMg82ZC7hA@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc4
X-PR-Tracked-Commit-Id: 426aca16e903b387a0b0001d62207a745c67cfd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcd72f54665717f9d610ea101336d42b7a80704b
Message-Id: <164469019575.16091.1381341887522721401.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 18:23:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:31:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcd72f54665717f9d610ea101336d42b7a80704b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
