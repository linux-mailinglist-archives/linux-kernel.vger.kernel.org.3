Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA25358D039
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbiHHWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbiHHWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64D8FC6;
        Mon,  8 Aug 2022 15:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537D460BCB;
        Mon,  8 Aug 2022 22:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B640BC433C1;
        Mon,  8 Aug 2022 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998229;
        bh=ZmNHPMhdJEUMHcd4zG4REwxvtBhkoR3gNfiwRF1XsKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AQdNzXCINfK0iTK3CsLibv8yUT5A0bqh5g/dc6kUmq0OhR3IKhaCDlOyY9jir2C5k
         +TmqgejYlTuTfW6+EDDFt1qFyMnhbf52qhDiDDIbT6VsbthKEgBe5l4wZRoWNLPUz7
         5OOf1xoGagSC0PCWD6KqiE1lzcYU5AJM1y8UmyTejCtgCgRGY+2e3KwAsyebjuG3bh
         z9j9aD1GxZO4h9WdN8e/3xNWsrG2tYgUD04siAKws60PPmZ1wk81oPF5PtsUW+Xm+8
         0X4zq9SD7bI/sPNWnKGgQ8sywEbjQ9wULyZUTbp5QYYu+A28CuUL7ojmKozF+8JEze
         5Th53Yp172y4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A41BCC43142;
        Mon,  8 Aug 2022 22:37:09 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220808190039.2106786-1-bjorn.andersson@linaro.org>
References: <20220808190039.2106786-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220808190039.2106786-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.20
X-PR-Tracked-Commit-Id: 8447d0e75099eb54eea9306c2d43ecfc956d09ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d5d353bed32dc3ea52e2619e0d1c60b17133b91
Message-Id: <165999822966.1400.16617128497130036065.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:09 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, keliu <liuke94@huawei.com>,
        ran jianping <ran.jianping@zte.com.cn>,
        wangjianli <wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Aug 2022 14:00:39 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d5d353bed32dc3ea52e2619e0d1c60b17133b91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
