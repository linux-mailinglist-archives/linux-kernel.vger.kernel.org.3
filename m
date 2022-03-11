Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD34D69A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiCKUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCKUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:45:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23B1EC26C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B1A161F72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC52C340E9;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647031482;
        bh=wcT5VChcLpkgrO2/xrZjU90vmYEXiIG/4aduJ2D2F+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R8yZf202nfB+xasoDGAKryJRUJn0KvDcu+GWDzwyP6JgJn0UooZvJBR+TnWmpLL2N
         ht+WYyfQMlZz/R0TfnjIKNoDAlxfw0u4SVbutGTIcdG9kLtCrMSMtZudHG/Y5WzCA0
         XlMdQYnTeD3bTQxACjbe4uDRmXkOpi9/4hnwMxXetW7RDTmDAt8JiT3I+Uvx9vIKYu
         EP8S9j+xVNTeqy6TZIVmytTgPJuOjzZEqmJzirUB74MGe1oeOk1AJP14tObmGRUUL0
         nK/Np+x/bPjFl2Te5NKNMSxiTByNZ/qxBH1Oq1qqtsp9z7DlvbTNO3MsF2eEKPlIuP
         ukFlsG4ToOt8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C940E6D3DD;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874k45m3fg.fsf@mpe.ellerman.id.au>
References: <874k45m3fg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874k45m3fg.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-6
X-PR-Tracked-Commit-Id: 48015b632f770c401f3816f144499a39f2884677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 878409ecde7c89c9f3db76ff1ef9486c6ceed02c
Message-Id: <164703148250.12993.11243673651989579046.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 20:44:42 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Mar 2022 17:03:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/878409ecde7c89c9f3db76ff1ef9486c6ceed02c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
