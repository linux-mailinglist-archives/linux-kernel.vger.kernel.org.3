Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6658819C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiHBSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiHBSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD2188
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F4FB612AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B32E4C43140;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659463365;
        bh=vvvfpo3ubxILvRv8bxl697O/zCOJLTOKPkCxd2akuxY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kyfdizAv9pyq842GK51lsqTDZ1pbVA8n1GWOu32mm3loLGLQAIHhUVijQN6L50iJC
         LSXEq4UPhV7/7W2n9B6G+s1VBayXcu0IIMEa9y/0blyntAotCW7I08+vPnW4+i0p90
         7xq6kuTX5Ap8tP1KfkfBy+cjOt+2Tv3mawRI5IRElwp+vybsZfuyjVl2AIgojXMUb0
         e2HUFs1ulmuTnt+UED7ZJj2DAwhlCohr6ucix5tFaRGCu4w4f5+PxZIrf26hHWFpLU
         K2AyPsx7ABbO2xdlIgjyZAxDE8FCtbE71FU2u1ZPdm1hf5RdNPukNXIIzt/npTMvOA
         SdJfSE+xYhMDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1D1AC43140;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801123816.8404FC433D6@smtp.kernel.org>
References: <20220801123816.8404FC433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801123816.8404FC433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.20
X-PR-Tracked-Commit-Id: efc93392960cb9c3534e7aed15481ca7bcfdf15c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 416e05e5b7ce63402a2c342472799d340559f10e
Message-Id: <165946336565.14716.10946779444448561294.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:02:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 01 Aug 2022 13:38:03 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/416e05e5b7ce63402a2c342472799d340559f10e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
