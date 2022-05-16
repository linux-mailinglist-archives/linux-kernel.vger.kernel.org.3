Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E853527BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiEPCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiEPCKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE871F62C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CEC7B80E84
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3D13C34115;
        Mon, 16 May 2022 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652667015;
        bh=swuw51O1x2bA/U6rRhQ7wcVLkX/uGaV02Fh03ESd894=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=it6SWEOPCPW8jz2QgX6KPm0O6AQhVDStdonay1ZslnodTkL1/zXiJPXJZsX6V2Sfm
         qcZGjP1Uqkwl09oxeA0qCBEP3LlD8/t2JZkPz+W13axwt9Jshkz2HFDKppZxBNQEVT
         Fw6Jp8Ttu85viKJL8wnPPg0BXB9XpHYwNWTJ5+ksfuofvsplEZq9jZn/6B5roTgF+F
         Ajw7Wuw4mmL807pEPmngb01ulrgA09zdIQtGq9Piv+Iaue1cJScVipO6uKsoE/Kd14
         /xS6q3SbB9V5bCXtevFfjRX710QdJbxdWLwxDdgb+yjPJs8nbuSEhSwAiaDIoKirR3
         A4NxYfiRblA+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5504F03939;
        Mon, 16 May 2022 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/7] platform/chrome: get rid of BUG_ON()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165266701479.14602.4419757446992775203.git-patchwork-notify@kernel.org>
Date:   Mon, 16 May 2022 02:10:14 +0000
References: <20220513044143.1045728-1-tzungbi@kernel.org>
In-Reply-To: <20220513044143.1045728-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Fri, 13 May 2022 12:41:36 +0800 you wrote:
> The series gets rid of BUG_ON()s in drivers/platform/chrome/.  Most of them
> can be replaced by returning proper return code.
> 
> The 2nd patch makes callers of cros_ec_prepare_tx() to take care of the
> return code.
> 
> The 3rd patch turns cros_ec_prepare_tx() to return error code if any.
> 
> [...]

Here is the summary with links:
  - [v2,1/7] platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in prepare_packet()
    https://git.kernel.org/chrome-platform/c/42701e7c0cd2
  - [v2,2/7] platform/chrome: correct cros_ec_prepare_tx() usage
    https://git.kernel.org/chrome-platform/c/71d3ae7fb640
  - [v2,3/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/c2dcb1b06053
  - [v2,4/7] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_get_host_event()
    https://git.kernel.org/chrome-platform/c/20a264c97bc8
  - [v2,5/7] platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
    https://git.kernel.org/chrome-platform/c/8bff946c4199
  - [v2,6/7] platform/chrome: cros_ec_spi: drop unneeded BUG_ON()
    https://git.kernel.org/chrome-platform/c/ddec8e9e90ce
  - [v2,7/7] platform/chrome: cros_ec_spi: drop BUG_ON() if `din` isn't large enough
    https://git.kernel.org/chrome-platform/c/bbd43a37ec7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


