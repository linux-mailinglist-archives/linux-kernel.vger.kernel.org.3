Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD658DCB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiHIRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbiHIRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:02:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A619582
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33592B811DA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCD89C433D6;
        Tue,  9 Aug 2022 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064563;
        bh=/512svhgKTdLLOSr9CFSA0bm3Hsc2r0iXZUqFwKMSno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xfn6GDIeY0oqv5HRPFbdO7TdZJMkKz8SbE6KiXNfdybknb5X+YK/wKKZaaga1pPdE
         r2Fpq0NivIPuJqTL9Boq+FZfmApfGonL9WeF+iHWKv3gGOJ4WlbH+EDZjOONBb6O2v
         7xBnkmJbI8Amo03F9QAIbFf1pPpjNVjYq1zurhwFeEMGVmpxWXkePzW3ggEgGcMi3c
         8c5Q6+cOpRRDdhWXp5JJRu6veVQ9CpYXiY7gbnrnhZ8Eaxn1ZEzcwL7duBLTf5t/0q
         StWIZgQZPVeEj0jVdTde12z5uAxpQuAqa5HHCTPdHG1WzS057rxn1uETp4gtJmGwyo
         k7ajJQXzug6KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9E40C43142;
        Tue,  9 Aug 2022 17:02:43 +0000 (UTC)
Subject: Re: [GIT PULL] memblock updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvIL0wn1WTDxjFVr@kernel.org>
References: <YvIL0wn1WTDxjFVr@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvIL0wn1WTDxjFVr@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.20-rc1
X-PR-Tracked-Commit-Id: 04d9490986d1e04a38db88276115e6b3c9ec3faa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8dcef877ab5f2637fccd3efb6fe169c8211961a
Message-Id: <166006456382.27167.9618272076837407152.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:02:43 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jinyu Tang <tjytimi@163.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Ma Wupeng <mawupeng1@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Aug 2022 10:25:07 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8dcef877ab5f2637fccd3efb6fe169c8211961a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
