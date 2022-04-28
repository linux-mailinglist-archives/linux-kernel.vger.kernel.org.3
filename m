Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB52513B49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350848AbiD1STm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350825AbiD1STi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D583CA58
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1814C60DE9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 781D9C385AA;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651169781;
        bh=yoAfc2Asrh4/KFjmJ2zFB9lpgOROLJsqE5cVjkAiT8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K4bRDiz0j66Pu5IyEMl2xuAX4qyP4n1Sm4yaUm/KJvgP+fiGvY4OBPKncoi20FnnP
         aZdVVk+QlO0PS2jxJ2D4VdE+nnMkmgouiUI0kSsa/1szOQD3PAsVcwYWqjzaNdFBRZ
         DtxA2tbkd+FKoLSZwrrC0054NeDHGQNISKBWEb5bdUbjSRzpV8SOfUVJHPf7Vc7hDu
         AiQq0HMf6YMcdndBSf2955r0FUk3sI9J4qz/5VhmC0hwNTb0CKP2XQhCGHipVcVfQD
         nF+TTBRpNgBXr8ycq5jPtQH2r+6nI4UTBzvAtLGozfDGba7QV4C7XLn1VLdSKiEZB/
         7so36NN+YIpeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6257AF03840;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220428111842.99194C385A9@smtp.kernel.org>
References: <20220428111842.99194C385A9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220428111842.99194C385A9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc4
X-PR-Tracked-Commit-Id: dfd2b37edf7ef469574ef7f36e3a1905ac9ead62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd5a4c7d26fa49d0468459b9c453841ff59dc322
Message-Id: <165116978139.27414.3654077953330619177.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 18:16:21 +0000
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

The pull request you sent on Thu, 28 Apr 2022 12:18:30 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd5a4c7d26fa49d0468459b9c453841ff59dc322

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
