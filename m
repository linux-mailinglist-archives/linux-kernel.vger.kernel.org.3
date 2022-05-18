Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA252B1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiERFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiERFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:20:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCEBAE7C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1F9CB81E87
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99320C385A9;
        Wed, 18 May 2022 05:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652851212;
        bh=kiCvi3Y9Ruk6NeR5nmbUThhYrDaGmZQ0zGHEkPrP7hk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VcEQFdZ4Gfu2ZYOMzrv+U/PbOJdX3S4kDh9BBdHa4oPgwzwT+8r1TuMi45zYVgZSY
         X1aJBkGt9HL28d6iyCDUaJIx7GHz7p76eDmES5zZsw6gdITQjgQ5K6fLShKRqrfP5L
         994NywM0QMg4RNVaxw36qnKL3zHvP4k2Ryn0DRchv/+tDyyW6lgcLbbdy2nTpa/+nW
         Ei4E0cEs1LRIKkEfiW2a7upvXX43KClff0uOXoh3OY0R+X4/JH/5TdqRT6iS8CBa9K
         c52zR9XW9UhAGx/XUhlhJ/0UDrmgIl/khWsdh50uZ+O4d5WIqI8Rub6vRdHYV85Php
         v5Z0I4YIpM9ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E413F03939;
        Wed, 18 May 2022 05:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/7] platform/chrome: get rid of BUG_ON()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165285121251.18618.3566824062986806050.git-patchwork-notify@kernel.org>
Date:   Wed, 18 May 2022 05:20:12 +0000
References: <20220513044143.1045728-1-tzungbi@kernel.org>
In-Reply-To: <20220513044143.1045728-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 13 May 2022 12:41:36 +0800 you wrote:
> The series gets rid of BUG_ON()s in drivers/platform/chrome/.  Most of them
> can be replaced by returning proper return code.
> 
> The 2nd patch makes callers of cros_ec_prepare_tx() to take care of the
> return code.
> 
> The 3rd patch turns cros_ec_prepare_tx() to return error code if any.
> 
> [...]

Here is the summary with links:
  - [v2,1/7] platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in prepare_packet()
    https://git.kernel.org/chrome-platform/c/42701e7c0cd2
  - [v2,2/7] platform/chrome: correct cros_ec_prepare_tx() usage
    https://git.kernel.org/chrome-platform/c/71d3ae7fb640
  - [v2,3/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/c2dcb1b06053
  - [v2,4/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_get_host_event()
    https://git.kernel.org/chrome-platform/c/20a264c97bc8
  - [v2,5/7] platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
    https://git.kernel.org/chrome-platform/c/8bff946c4199
  - [v2,6/7] platform/chrome: cros_ec_spi: drop unneeded BUG_ON()
    https://git.kernel.org/chrome-platform/c/ddec8e9e90ce
  - [v2,7/7] platform/chrome: cros_ec_spi: drop BUG_ON() if `din` isn't large enough
    https://git.kernel.org/chrome-platform/c/bbd43a37ec7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


