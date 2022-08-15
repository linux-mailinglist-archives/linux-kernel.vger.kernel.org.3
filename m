Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2B592843
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiHODpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiHODo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71511451
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD136B80D00
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A197C433C1;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535094;
        bh=jW+0ZFohx2G586FV048mUqyxvKukDHT+COl6WSW5u2g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AmWbLoYajg1BtgWy++EwInARncRgc23j1/64xYxL4RT8hru2LEODd5/VzoBOiZitg
         DR1Ux87TcerfBOY/0E0dEIVeQ4F3Z1oJy1QHpUa0Sl2xGXhffriYRddE43tThqG9QG
         cNAMzeRzbSun9Dfxn+zwSv8LVq8msJtdvHdhO160Emcfam0O2kacT2V7yGCGvd0Gd1
         443sx2chPFAu4e05JpHHuExuk29BS1q0VF9y35Y+IWzIsGl/0OXfSVD77Z+kv9Ux/T
         bDqrFmhUHeVJvkxa9rkI0anMJKP4lZCKBdxWSkCXZ+rUadocipnrWKNi9qjfClf7Oz
         ZRO0wLyZE5iiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D196E2A04D;
        Mon, 15 Aug 2022 03:44:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053509430.30867.12752434668482638475.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:44:54 +0000
References: <20220802154128.21175-1-pdk@semihalf.com>
In-Reply-To: <20220802154128.21175-1-pdk@semihalf.com>
To:     Patryk Duda <pdk@semihalf.com>
Cc:     bleung@chromium.org, groeck@chromium.org, gwendal@google.com,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
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
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  2 Aug 2022 17:41:28 +0200 you wrote:
> Some EC based devices (e.g. Fingerpint MCU) can jump to RO part of the
> firmware (intentionally or due to device reboot). The RO part doesn't
> change during the device lifecycle, so it won't support newer version
> of EC_CMD_GET_NEXT_EVENT command.
> 
> Function cros_ec_query_all() is responsible for finding maximum
> supported MKBP event version. It's usually called when the device is
> running RW part of the firmware, so the command version can be
> potentially higher than version supported by the RO.
> 
> [...]

Here is the summary with links:
  - [v1] platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure
    https://git.kernel.org/chrome-platform/c/f74c7557ed0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


