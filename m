Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2392508485
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377010AbiDTJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352601AbiDTJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:12:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927615A00
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A10ADB81DB7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F9D0C385A8;
        Wed, 20 Apr 2022 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650445811;
        bh=11pfjz1i2MS42xR7uvvDnDe7JxVoRfoPmLnKDExZ3Dc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ckTqUZryaTng3rCKHFe97gt9yNXMk3QrKYyKS1V0Qcx/fpvCTgI0wesrhA9G2y3om
         +AtmyJAcPmTqAhvMY6j3OAqzDkOZ/5QCHns/1iZC0YJb3dq6jv3SIIbsB1tQ/ceWyX
         0slT9md2Ri+CG+LBl+OC3YgSDuOkoPj4b+6t3NfD5lu81OQ0lmwl/9inhsdRCsF3Sq
         Yr4B4V4nCB+HK5ZowIeMxp5jy737BqaV0JxfwODGiBtGYY8oP0dq+SX2MoopSBUr5Q
         tEecNlxwdrS0utn5sop+wH+5Pijv5HpIGrhsK50OnKnmv3xettCtmudySrHRt+Q/g+
         QnjO74qT4JaLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 244A9E8DD85;
        Wed, 20 Apr 2022 09:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and use it
 for ioctls
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165044581114.11968.7352761617264023399.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Apr 2022 09:10:11 +0000
References: <20220318165422.686848-1-linux@roeck-us.net>
In-Reply-To: <20220318165422.686848-1-linux@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     bleung@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, dnojiri@chromium.org,
        robbarnes@google.com, rajatja@google.com, briannorris@chromium.org,
        parthmalkan@google.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 18 Mar 2022 09:54:22 -0700 you wrote:
> Commit 413dda8f2c6f ("platform/chrome: cros_ec_chardev: Use
> cros_ec_cmd_xfer_status helper") inadvertendly changed the userspace ABI.
> Previously, cros_ec ioctls would only report errors if the EC communication
> failed, and otherwise return success and the result of the EC
> communication. An EC command execution failure was reported in the EC
> response field. The above mentioned commit changed this behavior, and the
> ioctl itself would fail. This breaks userspace commands trying to analyze
> the EC command execution error since the actual EC command response is no
> longer reported to userspace.
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: Re-introduce cros_ec_cmd_xfer and use it for ioctls
    https://git.kernel.org/chrome-platform/c/57b888ca2541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


