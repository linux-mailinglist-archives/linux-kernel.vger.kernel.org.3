Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA35B0C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiIGSK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIGSKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858978048C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297E161A21
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A934C43144;
        Wed,  7 Sep 2022 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662574217;
        bh=QHFXYSBSw9fDU9liY5JpQcci/5Vkzbj6MR/EfAFv3SU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SihZoTm8IvmJEIuLvhDKXMBTLL+G5hoh8ZD0Lt6TzFwisBULFqkpyIgqOlT3VifO+
         6z1d81GOT4UdPX1Qzsd7l/1k2bifloHkM7/YgTx2BhSWdocaheuK0OeqHdcLUG0O+i
         MulZk4ox9rDNmd7yKir2qqLG94EUB6aYlPbWyiXTS/qMaipvlqRxCwsDzfYwl1ixF6
         5ubI9CiIUYfZO8B0ypehRTDkIYRPEdxSfvg0lQsaXcFSN07nXmyLVYNtLiimNMwzeG
         hptjSeMMVCG3QE8Tdp/evqAzknaz8Iff3pe3plQ0A+nJttWZt8fMxT8jSQVUgAJM58
         Iowk400CjHBGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73EFEE1CABE;
        Wed,  7 Sep 2022 18:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Register partner PDOs
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166257421747.4794.4976597240362712070.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Sep 2022 18:10:17 +0000
References: <20220830202018.1884851-1-pmalani@chromium.org>
In-Reply-To: <20220830202018.1884851-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        groeck@chromium.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 30 Aug 2022 20:20:18 +0000 you wrote:
> The ChromeOS EC exports partner source/sink cap PDOs (Power Data
> Objects) to the application processor (AP). Use this information
> to register USB PD (Power Delivery) capabilities with the
> USB Type-C Power Delivery device class.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_typec: Register partner PDOs
    https://git.kernel.org/chrome-platform/c/348a2e8c93d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


