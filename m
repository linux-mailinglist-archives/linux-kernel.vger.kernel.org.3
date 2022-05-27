Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201253691D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355136AbiE0XJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355062AbiE0XI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:08:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA76A07A;
        Fri, 27 May 2022 16:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB5AB8264F;
        Fri, 27 May 2022 23:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DAE7C34114;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653692933;
        bh=EtPTSh3oaegFChQ1weAGQht1EtGk14M2E3fMoJaisEk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dcmLRA3um54GU2T/PxqEXp7RD5htysryM/jLmq+WE9aPLhbhpLQ0RfL126Z9qLWa6
         niqsCJ7Gkhyw+5ZiXrvVPJ5NgQZM+cp3rjPBnSTCFyELL2Nxm7/GKCBOD5VN5JErNx
         OnyE3hCihOgpvaeGcQ4BGQgdD+jKecTurxSLCXuPUmNNwpsdEFh2Bf7PaDIzRBCDSQ
         ERwOdvehp/bepyjIa5d97FfCbkgthWplRCiErsurxAc7UWEdtZp/4Uf4ADR3Ur3HI1
         XOZdfwXefkCfy9ud0yF2xqtehSOK41ztY36ef/QX2wB/rZFMhigDQMKVbrE3RdKXR7
         RlHpqodb24+iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C8CE8DBDA;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 Client fixes (updated)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv11JkF3ShrMLQ_PQHGSTysqF=gR9MSZsZHgR-mb-JH4g@mail.gmail.com>
References: <CAH2r5mv11JkF3ShrMLQ_PQHGSTysqF=gR9MSZsZHgR-mb-JH4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv11JkF3ShrMLQ_PQHGSTysqF=gR9MSZsZHgR-mb-JH4g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-updated
X-PR-Tracked-Commit-Id: 44a48081fc03187d3c047077f3ad3eb3a3eaf8fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf272460d744112bacd4c4d562592decbf0edf64
Message-Id: <165369293356.12283.5115097287727338406.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 23:08:53 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 12:12:20 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc-smb3-client-fixes-updated

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf272460d744112bacd4c4d562592decbf0edf64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
