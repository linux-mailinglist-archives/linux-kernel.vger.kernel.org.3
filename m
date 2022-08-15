Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F152B592850
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiHODzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHODzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33962CF;
        Sun, 14 Aug 2022 20:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12534B80D21;
        Mon, 15 Aug 2022 03:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C25DEC4347C;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535728;
        bh=Dj4C9v9BiKHIFxUBo5AnrjZ/fOkwzcoGV1W1NQa2mpw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=StJMPwdrLweLB8Zzvew3UyzzleVv4o2CoGHk0OuTpChFdihKaK7Bq3rl1DeLANxNE
         T8flEcheTdrInAgqW8C4DxrViS8zefYQTugoDtW+BLI8i9iQXvi1qibP5lKCjw9iQO
         NXxKxvy02x3x9IXdAwmAzgHM/ajOIj3qmYSjPMEGkte5chX8dP+72jsEGlK/KIkgh5
         m7qsIKg47smO+h/GIdIFDxpIURgDWZBdosbDqVWexXtwgrZ6IWiKQS6vNi2YbO9yge
         n+jC+1LPVQd/1GfHdO9uuuf0RSkyYOLE/jxG7iXw/LVVNHRzcKFXSBWnvW8UG2TR/Z
         rT9JGFoywvpWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A22E5E2A051;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: cros_typec_switch: Add ACPI Kconfig dep
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053572866.30867.5546564903380814690.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:55:28 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


