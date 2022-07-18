Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DC578A91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiGRTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiGRTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B42ED64
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF018B81744
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 849A1C341CA;
        Mon, 18 Jul 2022 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658172013;
        bh=q31es4yug37a1oj6y8ZOIwKqb46nw98BTRqL2/enzA8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X/eJgIHDH/YY8epXs2SsMRU0BcNnbO9am5EI3IngEoy2y1e3AT7MuTYw6fNK9cMbr
         z1Goy7ClGvfcff1+0hkVWOawGuraFVPAUUMMkHTD4aGBXEhRJn63OeOzLAybqsZp9n
         lWOTTF/5yuhduPD1TShRee7bIdgSmLKznD+ngdYCbgtydMjPhP0kQIz1QB7ViE3vbY
         yq0L2Kqs5I3ZkwmLwFH0HHIC1cboLjGs6vTT4whIQiWeWOrvuSQ8Oidxgx5nvknED0
         ZMdC/XFd/P7LnfeEQI2BPuFgLUj38mvaHab0hRHuAuWD/6d9Ubjwa+DhKnr/o5Gyua
         y12Q0AV+Kyuaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67A80E451AD;
        Mon, 18 Jul 2022 19:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Rename port altmode array
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165817201341.12485.17039097052041184784.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Jul 2022 19:20:13 +0000
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

This series was applied to chrome-platform/linux.git (for-kernelci)
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


