Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013553AC42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356518AbiFAR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356456AbiFAR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524D95492;
        Wed,  1 Jun 2022 10:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515946165D;
        Wed,  1 Jun 2022 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B673AC341CA;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654106160;
        bh=Xfn2HFEnZSxcXFkR8Prh9VtOycLBNOIm3UVfs78ul6I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EGFE48ZWfltGiZrI8TPycUBapJQP8LZb/kYKLFB8EkggUlqO5wh/gqZlKCZaAAwjX
         gFFnmWiQTSBpO7S/WG24yg0S1NnyEJwJZIrHRyjpdHVa+errjd3tK7cPRd+EB68613
         ekvMT+rwsDeRJ9OdEUHyhiLMc9VR63rlgzs1xahIAwlSSVNVvdEsZ63G/ZCp7lAJ4C
         2e7mFoeh0uxJTQ/tQhrH1Hh00cURDNHt2+pxTMDJemb5ydaX23S8MoMer1BrGb7XqA
         tFkvRyaILdtD18mXYOMNKjctmc1P25AlfzE+VEI+FHCqEHtZrC8bQIZPYB7vsHHbcc
         rc3/ePGrnja0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A31FCF03944;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601122332.536516-1-bjorn.andersson@linaro.org>
References: <20220601122332.536516-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601122332.536516-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.19
X-PR-Tracked-Commit-Id: 59d6f72f6f9c92fec8757d9e29527da828e9281f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68e6134bb70ab20e9f7c36c1ae7dc96b8ed778ae
Message-Id: <165410616065.7706.9186739503957755762.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 17:56:00 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  1 Jun 2022 07:23:32 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68e6134bb70ab20e9f7c36c1ae7dc96b8ed778ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
