Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9B4B9472
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiBPXX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:23:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiBPXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:23:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429822AAB34;
        Wed, 16 Feb 2022 15:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B4761BCB;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E52C004E1;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645053822;
        bh=XExZdz5pl9QjWMM9CBl3plsUR1PcI7ogKu+Fs3YgVi0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jP3uNtddpIHSAi4yg3RDZgNBzXigJoVhBkUtbAXkBmCpXiuqxNe/q/s01UfBa7LMn
         svpD4Q3NabPWCywpNEJJjWxgGAaYkcAWQyY2j0YkNv8jXi0t+QB96+/cNPOtUSGL1g
         Xm3q/V5h7geaNuEkPlO09ZhxPsxnc86k6o4qVSkXydbrY0A4oArOvc4irAYEe0DA2m
         f+wGzSgVaJr3kI4T1KuQV0VRpnnK3ytVYQgcE04EqQvpA1wdIb0EYB5sE2GJ5eex/j
         A9bKln9tpVBF5Wvq/P8h2PS5opTlZZUy1K1y50kW0amYrYxlqzSBEBm3IyiuKeluFW
         o/yROEfgo8yIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36A83E5D07D;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220216101733.193534-1-ulf.hansson@linaro.org>
References: <20220216101733.193534-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220216101733.193534-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1-2
X-PR-Tracked-Commit-Id: 54309fde1a352ad2674ebba004a79f7d20b9f037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
Message-Id: <164505382221.13100.12638078753532183842.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Feb 2022 23:23:42 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Feb 2022 11:17:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
