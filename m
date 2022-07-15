Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9066E576653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGORqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGORpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86C2F648;
        Fri, 15 Jul 2022 10:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF62622D7;
        Fri, 15 Jul 2022 17:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81284C341C6;
        Fri, 15 Jul 2022 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907132;
        bh=FyPG+4RcSMR/dedX+rYqABXXPto7sVlruQczqb3797k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RYXs0G5qZrqHFdIQjgqjPIfw5hZMhy37Aw1o+D2kNvmDk5e61gWqS4H3fhDVj22nf
         fiTO9ITwsTflZpxDCdz5YzgzlZRBH5luWtpau7eCRzGtgQMJcn3xTd4ZFecHr6QQki
         PAFWuV2O44Tf2Pl9o0Gr2dNxoTuS7DJz2ss8TvHChxVBcPUHiU2rY02ofKdWFEkraI
         RDnOwsnWdeZyLPNywUbWc9xhPaxI9qlXidTL3SCIM6sPhlczpXPVjoobDAGJGwXvvi
         HwHs84RZgs2LERgzpzOVyCNIKcrn0nUTW1ISvrr8qdusifou9tFhnvVFbmLjWNPjrJ
         Vu2+VTyWmDSMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F79FE4521F;
        Fri, 15 Jul 2022 17:45:32 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220715163845.14481-1-idryomov@gmail.com>
References: <20220715163845.14481-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220715163845.14481-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc7
X-PR-Tracked-Commit-Id: fac47b43c760ea90e64b895dba60df0327be7775
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ce9d792e8ef286ed03b151b9bdfcd921e04a988
Message-Id: <165790713245.27298.4072793540229036138.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:32 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 18:38:45 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ce9d792e8ef286ed03b151b9bdfcd921e04a988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
