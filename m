Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819B34E460A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiCVSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbiCVSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D248CDBB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C64861583
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE76EC340EC;
        Tue, 22 Mar 2022 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973911;
        bh=XQFBCQ2mnxzKUADqqIpqYqyNn1PFGesqW02zRxcoVBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QwN68IJ8N1JOJ48gkPiDzEtlfcP4IRQxrAgDoUB0cXT9kc6VBSpOviDJQcTr8EudS
         kGsmEv8DJEUpd1h2D0hOkR1FfLcA1T6dEihmp0P214YFSY/QsdoSON/i+i3vFCJw53
         ZohNNjTJhZ1VDnVQq2ALvDY43AU+KnC9JQZTNERk9uJe72PTr70zR+N7G3iLakLicf
         P4a+UFs3IfI4ZmHjHvsxaazRDNbKhsPAErcE+Pd0rJvq9MI5d48lma2DKBK51rRqqA
         uoi4+rKvA1ue+K1NNAZZ8K+xujIs0wdIHxZ1xzt5WYwxIrkDVQ4HkkkWmdA+g9oaqY
         RAv99w0blAHsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C8A6E6D402;
        Tue, 22 Mar 2022 18:31:51 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjgtIqJK0Io+zYeI@debian>
References: <YjgtIqJK0Io+zYeI@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YjgtIqJK0Io+zYeI@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc1
X-PR-Tracked-Commit-Id: a1108dcd9373a98f7018aa4310076260b8ecfc0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aab4ed5816acc0af8cce2680880419cd64982b1d
Message-Id: <164797391163.17704.7734840067307301191.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:31:51 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        lihongnan <hongnan.lhn@alibaba-inc.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 15:45:38 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aab4ed5816acc0af8cce2680880419cd64982b1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
