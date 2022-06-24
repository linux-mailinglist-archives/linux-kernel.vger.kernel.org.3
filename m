Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B042B55A34F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiFXVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFXVIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6CBE026
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D34062375
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19AFC341CD;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104886;
        bh=llZ2VCW+2sruD/6aU0+/X1fWcg8ZIspAnBLoOm1uqoA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MF4x+1ajzfr9AZ9rlxFwZlRe27tJ3VQUe+jkEqMWfjJuV/KzpifAd+FyxeOXZW38l
         RUKfMxZJKVSG/bFpQbTkeHXZr/+VbjXECgh2glNC3sM5AOeh5U78Wbr8U/ExGCSMPJ
         Y4XL7O32t/0ULPLe9q6blCVwZcuGxP33gx9aVYegyPbRayYt9p5A4OVls4suKPqcX8
         RZFrh+J1IbXIeyiUMLLDMi7B7mHBlU+fNggkI7vSfoH0yWBm2XhRYIm25TOJSJuWUO
         JyfTzs69CRiCEdUsP6pTiuXgWYkvO1PR/DIouYmtZjYCz3Yk5tWW0DQxacnfc8Pr00
         e1bYjfVJY3chA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEA15E737F0;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624205656.63c4e2b1@xps-13>
References: <20220624205656.63c4e2b1@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624205656.63c4e2b1@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-rc4
X-PR-Tracked-Commit-Id: 06781a5026350cde699d2d10c9914a25c1524f45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a0a17e6c6d1091ada18d43afd87fb26a82a9823
Message-Id: <165610488684.13803.12278023381332866576.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 21:08:06 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 20:56:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a0a17e6c6d1091ada18d43afd87fb26a82a9823

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
