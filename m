Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6353AC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356512AbiFAR4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356511AbiFAR4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2595492;
        Wed,  1 Jun 2022 10:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0DA4B81C11;
        Wed,  1 Jun 2022 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7462DC385A5;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654106160;
        bh=YMeUQMmnC68iJNXcfrjE4FSqyJObsm7WRbRBQEZhd6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JPEhq3tByDgGu0Y/0krp2Lsu9k6XdUOjkbNv88SxX9AGZI5WrgwdM+x+Hv2aGUuCF
         t52ywhbuBq9hXaLrRLlMscK34+Qded9AHNLjtwOrASr0NStfpK0X9DkxG6SdPEfkrX
         pMT9F17/pNDSJrzPwinzHk/yUl7MXcPJWwUcGcV7cjH72CgwPTuxpe6Ej9LvJMbUAB
         VMPrkyHLKM1h3bo1Rm4hZ4J4cg4mQNFCOAIYhTtFon27NjfAjB6rZlTV5Fy+HxlLtq
         JWDBuAsqx93UY1WT7yhPwx14mbXrlzo+bMk9tEbVpIPd5z5ahgFyqE7o6BQahKsJbP
         lNi6FKBvGAAXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E8A0F03944;
        Wed,  1 Jun 2022 17:56:00 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601121809.536000-1-bjorn.andersson@linaro.org>
References: <20220601121809.536000-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601121809.536000-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.19
X-PR-Tracked-Commit-Id: bb489b96406104070c1fbe364c441cffae8a2ae4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f634b63d43e1ef4ccd68017687a8437d3c416918
Message-Id: <165410616037.7706.11658448569013406869.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 17:56:00 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  1 Jun 2022 07:18:09 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f634b63d43e1ef4ccd68017687a8437d3c416918

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
