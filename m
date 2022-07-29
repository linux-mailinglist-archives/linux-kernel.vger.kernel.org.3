Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AF5848E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiG2AKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiG2AKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DDBB86D;
        Thu, 28 Jul 2022 17:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6060561D09;
        Fri, 29 Jul 2022 00:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB6C3C433D7;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659053414;
        bh=VQFeoKnk/a/g5X0qE7WXqg4KJHj+79PlNWob3t5Lres=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l6GOagcPyKqjRIJXeHkvM6JXC794dTubGe1ch10CaYRePkVHwxbtuiHXk5s+tifdO
         8nwJue9oXTD/4pz+c3eHGq43dUSa73O4wAXLfIGwTMCnLGeNfhWU4Mi8haW5PZxn7r
         tiG3zGLwkoL/JVCdg3QT6ZHh7XZHErTT78gfl6hYCYXiaQA/8ksljtm+HbKVx7LJqq
         80FpyD/U/VsfTct/Y6+tDOBvz0NQW9yAyNvWm64Rr27N4b6H66T883Bl6VOxTQJudf
         1QXX5VnJCOlZDFoXdESoP4PgDrRXcBRY4r8J8PUTKY+/wnjdlcEFEdTbFajIGoIR2z
         XbrLqRjI2Czvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3736C43142;
        Fri, 29 Jul 2022 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165905341466.26440.11072022692863950015.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jul 2022 00:10:14 +0000
References: <20220720011002.5221-1-faenkhauser@gmail.com>
In-Reply-To: <20220720011002.5221-1-faenkhauser@gmail.com>
To:     Fae <faenkhauser@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Jul 2022 20:10:02 -0500 you wrote:
> Fixes bluetooth on HP Envy ey0xxx
> 
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a50481b4de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


