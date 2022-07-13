Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6A573C00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiGMRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiGMRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06E26AD8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A9EDB8210C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E78A5C341C0;
        Wed, 13 Jul 2022 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657733413;
        bh=O9PFQadpnjt4CEk6FN9tMP2YlxgB0u2EXdMzzVHtZ3k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DXZ6osl+YGEITDrYfFg1tESLj1zsh6YSYQziQZ6J9+FS+jVIqSIXfppYVo2v/T2pF
         lqJ+8MX6JXoRz5SdsUl5yhuR6bUhLB/U8l7S4fQ90k4d3G3iJdba5aplWlDuvz14H/
         Y65Fj6y27/bGNwKQBARfB789rU02+2ri0C/nh8MpRkWX8XZhe+Rog+zpBzFSW5IasC
         W6a94B/fTDHZ8iN0aUOSlORQYz6ZE4wvS2E3YagEh9y7X9M6/uFSrPvhVWgXohYgwn
         O8uUcVOpMHNDmw1PsD7StQBWA0pTGjP/jta9nd55m07IjgdV53YMzpRo83IAlxFxBz
         gcsemPvxglAjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF5CEE4522E;
        Wed, 13 Jul 2022 17:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Use dev_err_probe on port
 register fail
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165773341384.28136.7833622622098644174.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Jul 2022 17:30:13 +0000
References: <20220712214554.545035-1-nfraprado@collabora.com>
In-Reply-To: <20220712214554.545035-1-nfraprado@collabora.com>
To:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado_=3Cnfraprado=40collabora=2Ecom?=@ci.codeaurora.org,
        =?utf-8?q?=3E?=@ci.codeaurora.org
Cc:     pmalani@chromium.org, angelogioacchino.delregno@collabora.com,
        kernel@collabora.com, bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Prashant Malani <pmalani@chromium.org>:

On Tue, 12 Jul 2022 17:45:54 -0400 you wrote:
> The typec_register_port() can fail with EPROBE_DEFER if the endpoint
> node hasn't probed yet. In order to avoid spamming the log with errors
> in that case, log using dev_err_probe().
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_typec: Use dev_err_probe on port register fail
    https://git.kernel.org/chrome-platform/c/ce838f7dc795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


