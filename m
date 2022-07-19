Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E957A95E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiGSVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiGSVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1893C35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7739361AC8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4F18C341CB;
        Tue, 19 Jul 2022 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658267412;
        bh=9N/uw2FfZ/j6JoZ6/VgZzlAlsjt+LvpaNu+me+/t1ms=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Va6L/2VxHObhlw8fSfLZMdpkQkfXJ4ZpZtrWwznNCRfeZfRfCqqFcM+PorCAP4Pk7
         JuzzeDhyjNoqLM4NyduidCNj+FO1V1YKuY/ENS2upGwF3MiSugTNWDcqo+qhSwY36P
         Pwxx53mb5OVjNQ65MzHbdk2jZYq2QDp65zGaa+9I/khEZIEd6nuTY705CBNIluodjU
         v2JXRnp2Kv+w5rxdeGTYSAr1zo3vPK7f8qAn1j5G8R+18AnHRoSXylDiwmTEVKA6aj
         7mESHTnPO/1W6q9YMpMRan7yfABJbZX7iUhBZmArBmFcg27GfUNC6guOR0p/3nB+B/
         U01aarFJU2CHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BABE2E451B3;
        Tue, 19 Jul 2022 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Rename port altmode array
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165826741276.12799.8151541966918774688.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 21:50:12 +0000
References: <20220712210318.2671292-1-pmalani@chromium.org>
In-Reply-To: <20220712210318.2671292-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        groeck@chromium.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Tue, 12 Jul 2022 21:03:17 +0000 you wrote:
> Rename "p_altmode" to "port_altmode" which is a less ambiguous name for
> the port_altmode struct array.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [1/2] platform/chrome: cros_ec_typec: Rename port altmode array
    https://git.kernel.org/chrome-platform/c/a47bc5a0c4c0
  - [2/2] platform/chrome: cros_ec_typec: Register port altmodes
    https://git.kernel.org/chrome-platform/c/1ff5d97f070c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


