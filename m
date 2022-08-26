Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB745A3222
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbiHZWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344946AbiHZWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84215808
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B12961AB8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC45EC433C1;
        Fri, 26 Aug 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661553615;
        bh=8qhlcejn9EkCwBg4cwv2NBebEf7tfaNgsEUj0bxo7/c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OrGlOpVFA40c5PwBDVv3HQg745zjzxq2gCj+Txu3KrfzDyaKs37C/nuMUUumwQ8e/
         1zXGx/43TlkCgQjvCwuQLBlmWhqYONJS7FxgHVpLDZCnED1TQWXWpMjngb+b85tRzL
         NLP3ac5sGG5wQaOtc7Z8n9B+nIoYds3ZCCM6xUO4DKX+oAcQmtqkv5VBE0M0Wy8FmM
         t0o65jA20ULjn/O4oNlEc/bi6D6BMdXTV8z36IN73lt24Mf2Bjims6fguI/+EWgwZF
         CIQtSMBGjICuVHZE1ABmZUkfxCM+R38FO9Q7HqGlraILAICwGwLl1B1kyA5MOTujNZ
         dmTBfQw95TK7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 913D6E2A03B;
        Fri, 26 Aug 2022 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_typec: Altmode fixes
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166155361559.15250.6333484675187018145.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Aug 2022 22:40:15 +0000
References: <20220819190807.1275937-1-pmalani@chromium.org>
In-Reply-To: <20220819190807.1275937-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com
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

This series was applied to chrome-platform/linux.git (for-kernelci)
by Prashant Malani <pmalani@chromium.org>:

On Fri, 19 Aug 2022 19:08:01 +0000 you wrote:
> This is a short series of minor fixes and changes to prepare the
> ChromeOS Type-C driver to better support alternate mode drivers.
> 
> Prashant Malani (4):
>   platform/chrome: cros_ec_typec: Add bit offset for DP VDO
>   platform/chrome: cros_ec_typec: Correct alt mode index
>   platform/chrome: cros_ec_typec: Stash port driver info
>   platform/chrome: cros_ec_typec: Use Type-C driver data
> 
> [...]

Here is the summary with links:
  - [1/4] platform/chrome: cros_ec_typec: Add bit offset for DP VDO
    https://git.kernel.org/chrome-platform/c/1903adae0464
  - [2/4] platform/chrome: cros_ec_typec: Correct alt mode index
    https://git.kernel.org/chrome-platform/c/4e477663e396
  - [3/4] platform/chrome: cros_ec_typec: Stash port driver info
    (no matching commit)
  - [4/4] platform/chrome: cros_ec_typec: Use Type-C driver data
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


