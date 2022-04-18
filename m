Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B063504D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiDRHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiDRHwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255612F3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6077B80D86
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60399C385A8;
        Mon, 18 Apr 2022 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650268212;
        bh=ga7xLfokYNMZba70us1wB2gwefrjq7mHcQBLqW5ODXE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fanSXq80gZHqV1YtSrMEDsbt9bOBiEiAPREtuGFITjLvsr91hHwDnf85uRjlYICsA
         4A+eCKB+F6vME5OJP92bbbtXQaO6mxfwMP28DZfkFDg6MgxcIxLLdW4j02Lh7YFNVM
         Ggkm5fcVsc7n/X8aXR9EE+XZsvdZyb90XIlLvPmmNApCEJa5fZj/xqE15LNuJ6Pk+D
         Ry3B48D5JOzvGYKwc+KI0D/Iop4lgX/0Go8vDueUKWvjoPyEYcX9Oyb/vLSOF7Dmt3
         6b0FIr4cChnNbtfnNJo6ATMwcPPIB/apKZL/lg4VYrSDTdee5wusCAvtPYvIllFwNM
         s7EaVUTF4GKfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4427CE8DD61;
        Mon, 18 Apr 2022 07:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/5] platform/chrome: cros_ec: miscellaneous cleanups
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165026821227.18816.2084357824072322300.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Apr 2022 07:50:12 +0000
References: <20220216080306.3864163-1-tzungbi@google.com>
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
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

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 16 Feb 2022 16:03:01 +0800 you wrote:
> The 1st patch fixes unhandled undos in error handling path.
> 
> The rest of patches cleans drivers/platform/chrome/cros_ec.c.
> 
> Changes from v4:
> (https://patchwork.kernel.org/project/chrome-platform/cover/20220216043639.3839185-1-tzungbi@google.com/)
> - Rollback the 3rd patch to older version.
> 
> [...]

Here is the summary with links:
  - [v5,1/5] platform/chrome: cros_ec: fix error handling in cros_ec_register()
    https://git.kernel.org/chrome-platform/c/2cd01bd6b117
  - [v5,2/5] platform/chrome: cros_ec: remove unused variable `was_wake_device`
    https://git.kernel.org/chrome-platform/c/f47a6113f4e8
  - [v5,3/5] platform/chrome: cros_ec: determine `wake_enabled` in cros_ec_suspend()
    https://git.kernel.org/chrome-platform/c/9fbe967d4e6e
  - [v5,4/5] platform/chrome: cros_ec: sort header inclusion alphabetically
    https://git.kernel.org/chrome-platform/c/5781a33098c6
  - [v5,5/5] platform/chrome: cros_ec: append newline to all logs
    https://git.kernel.org/chrome-platform/c/8d4668064cce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


