Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAFD4E3738
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiCVDIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCVDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3248286EB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86B90B81B3E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4759EC340E8;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918398;
        bh=OKg/tcp4OoerAw+Pc7mkIEj5kZDLSisBauGNZfvccdQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BDiga0u6KE8rWYSy/pOk9jdyH+Qyq+xRRdXFY6ngjFMQIK6/HvBgamnp9USS3QBOR
         EBw4tIkiGmpMfRs93vFlkySooK0v75X1y9z4J4m55po+OMeBvSQkBUlHT4RH0/3L5T
         1gnCwlvMWBd8udupdv7+Vm7eefMHOAhT1NMp3QZQ+ZBCV752gWmds7JDy8Pw5Vtx7V
         7pEhfIbnrGPV4koEeBSZnAFFnGTQnxl+pvj4+fmNiQqfM4HcYw2LDGvICzqHyHoNLF
         iSQmRPVW4xgwa5SzKsnxWApOw4Ap2bOIbp0WWH+5tG2jjmGmYdEPg/P+Zk2s2sdJ5x
         O8q+pcDDW7pjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31CF0E6D44B;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210740.98EB66F8@keescook>
References: <202203210740.98EB66F8@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210740.98EB66F8@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.18-rc1
X-PR-Tracked-Commit-Id: dd664099002db909912a23215f8775c97f7f4f10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7a801f3956f0c1409d0ece07feb9a2ff78cd15b
Message-Id: <164791839819.13286.3351748526524982692.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Akira Kawata <akirakawata1@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Bill Messmer <wmessmer@microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        David Gow <davidgow@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 07:44:54 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7a801f3956f0c1409d0ece07feb9a2ff78cd15b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
