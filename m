Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD315454DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiFITWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiFITWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03B1F1BFB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 020C061E1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 19:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A28C3411B;
        Thu,  9 Jun 2022 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654802561;
        bh=Jbbvb8OWsUcza1qgucy+DX4D2nGpl40v+UfV1Tc7nJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iAnSLwNxA0lOJ0Zoqr8OElJZ1k0wrNsUE7cvQTRro8HD9GbZ+l/XtbDSLNkpoZ8Wt
         vKGOgI9BBvovZL2akW9rNEiLKjohdAJHYTcYLcO/KaB61Bc/S7OhSYgumDRUwSs/X8
         kBuoogIR0UNyLRLEZ+yapDz0/YYD8SFPMa/evyypBOZKxsFVyo5x7qRoidB8hp9tub
         b5QuHCHnbOouf3KCMLt1HrDY5SrX0hKDI/+4SlIaw70bF6q69MHaOeeDdRCgvcwPTI
         JvXu9KxPyORQd64d9sDxP0S8e4rx4npx3YKtr5ESJGrsSxy05BJEt5NGCmxeiOho54
         EeyFCFxXLtlpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 408D9E737E8;
        Thu,  9 Jun 2022 19:22:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87k09pdgri.fsf@mpe.ellerman.id.au>
References: <87k09pdgri.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87k09pdgri.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-2
X-PR-Tracked-Commit-Id: 8e1278444446fc97778a5e5c99bca1ce0bbc5ec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95fc76c81b9270a9ab38f4947fe5cb786c8c79cc
Message-Id: <165480256126.32717.14540296133538426706.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jun 2022 19:22:41 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        heying24@huawei.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, masahiroy@kernel.org,
        oss@buserror.net, paulus@ozlabs.org, vaibhav@linux.ibm.com,
        ariel.miculas@belden.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 00:59:45 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95fc76c81b9270a9ab38f4947fe5cb786c8c79cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
