Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74558592851
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiHODzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiHODzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BF627A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AF04B80D20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5646C433B5;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660535728;
        bh=9cStDL6VDIu1GtVJwkvwpUgJHRXcmBxfDKU5KW3InG8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HDJq+qF9bgTQIP6ZWDldAAV8hgsu5Kes38TB8Ljy4PnUISUwgnWs8J42GNlXeRrKa
         LlGHqjPdLo9zLXO0hdt8aofmwXKC0jZ2JYK1XMn8lBZ8/ZpkSY+saoxn6l622p9rhA
         kQbX0OKL0EqddrWPuIkWQo0s+Gkj3ZH/dnZEGD8XyNB3gA7bpBCdfuzTyYOyT8Lvsg
         g8iEnKGnkGNF5FXkgMpji2ML/3Pzrxmkyj69rcETUc9mSFk/RRs2brEVm1sVSMPq+Q
         2kqkmrC7OYD0XYXOuGcH9xMb1/0kY4PmuA+VzRWg3H1O2cvSts8XMxPuWx8KniFonc
         IMlSZCL1dJNXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86D72E2A04E;
        Mon, 15 Aug 2022 03:55:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166053572854.30867.16514927913447252293.git-patchwork-notify@kernel.org>
Date:   Mon, 15 Aug 2022 03:55:28 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


