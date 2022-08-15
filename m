Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4C592842
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHODpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiHODo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F413F20;
        Sun, 14 Aug 2022 20:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAD2EB80CF1;
        Mon, 15 Aug 2022 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C1FBC43140;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535094;
        bh=AEEr5CXyP/v/XoMiUSx/wTeBSZ97rwz/CGh0DLmMG2M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZhM/QWjby2KXTwr8HzOxgJtOxcgaBn+FhpQCs6yKUmy+ll5aoL+fXuwvh7U7qcHbe
         H0K7O4/06yViMcg625l4IArcFkMC3Qg/Q9NCIntC4v3xP+BQksiozDL0mg3DAi7lr/
         5mR3AuGyysjAtJpUCCAxjnOIGqHhx4szFVMoC1JCYd1wQWoZ1Bot2kPPEN9EyVp0jT
         1ymxy9di/a34SGNagWstv70mEZaMbi2D7J3sEgi4twoCs31vh64vxBArdqx8U68DdC
         gyqbbIeA8oqEwooT/YurGmPjmvnsvdayGLEr8bT6gomGm341yGi946YmHTvBKADGaR
         NSnZirT/DXnqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67620E2A050;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: cros_typec_switch: Add ACPI Kconfig dep
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053509442.30867.11814396259669096665.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:44:54 +0000
References: <20220718212754.1129257-1-pmalani@chromium.org>
In-Reply-To: <20220718212754.1129257-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        gregkh@linuxfoundation.org, lkp@intel.com
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Mon, 18 Jul 2022 21:27:55 +0000 you wrote:
> Add the ACPI Kconfig dependency that was missed during the initial
> driver submission. Fixes the following compiler errors:
> 
> drivers/platform/chrome/cros_typec_switch.c:93:9: error: call to
> undeclared function 'acpi_evaluate_integer'; ISO C99 and later do not
> support implicit function declarations
>  [-Wimplicit-function-declaration]
>    ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: cros_typec_switch: Add ACPI Kconfig dep
    https://git.kernel.org/chrome-platform/c/88a15fbb47db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


