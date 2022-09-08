Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120EB5B1164
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIHAkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIHAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39A92F033
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F05561B1D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89902C433D7;
        Thu,  8 Sep 2022 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662597617;
        bh=0Pf6q/fyxL6TJrj515eWTO9KreL5UCAVLSKnmrj0WSw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mWkNV0AaDMEGK36fK7Sd6wtqW6leJm3PAW9762kdQVjRHqTewyQm3YeCcPeM2J0+5
         XhW2RvTRq1R7PQtia3MPiY/w76MvLicxELdYYfT8cEPXqA6SKdxxiSe6Wwdiui3RPA
         kfHWAP0uMMVKhxQk3DDAAXRESut/7GtxqwaeTXSh2bSckjRA2OU6v8K652p5Jnpm6N
         xCwq6BxfSoLI72Yp93rXf84UpVxER5SWz3vN+aY57ry+TbdpYRylX61DnXzKtwlB7M
         Y7xV2oo7o3yf8HgEC0Bk7EOtpsIsfhpsQxakN97ATkjfDI3xqSUNH7ide9Rfu+XChX
         5XeJTMm9ddbug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67B70E1CABD;
        Thu,  8 Sep 2022 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_typec: Altmode fixes
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166259761742.4687.8678554201426962952.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Sep 2022 00:40:17 +0000
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

This series was applied to chrome-platform/linux.git (for-next)
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


