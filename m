Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA2A4B936B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiBPWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:00:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABA298AC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23CBB61B32
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BF17C340E8;
        Wed, 16 Feb 2022 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645048810;
        bh=JmEd61PatmTK6FoGOB53UnpcFH/CLQQNB3/wIQwZChM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lQlu/v1Xp+qZwb8OIPLRNkbNdEk1x/JRbsRgQ8SPThA0MquXaGLcnJniV+9B1Rgd4
         lLx16OwLMDrSBVnrHxAR4N04bwqS/HsatbChbAccHQ8Q9rc/jjACtNqf7Asow6mcTi
         yiydwOYqNAOkKaqBXdT1dTRmdz1j0ZujWyX7bmB5j+/6i6nq2VX889POyrrDG708eJ
         EunJyJFcTcQPDxTFuUEO54/xCFCM0tx6hCsgrao/Ad+TYiFmfiKbztNR2Ni8SaKueo
         uNGjV5ODejH8Fx3oJPTNTPNXlyYNJBjn7I56aAhShbvGHh3j25ZO6jDsluNEJg/bSU
         fJZkCxHFuUelQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70249E7BB04;
        Wed, 16 Feb 2022 22:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] platform/chrome: cros_ec_typec: Reorganize mux
 configuration
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <164504881045.7567.2664390271218928551.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Feb 2022 22:00:10 +0000
References: <20220208184721.1697194-1-pmalani@chromium.org>
In-Reply-To: <20220208184721.1697194-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        chrome-platform@lists.linux.dev, groeck@chromium.org
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

This series was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Tue,  8 Feb 2022 18:47:16 +0000 you wrote:
> This is a short series that reorganizes when mux configuration occurs
> during Type C port updates. The first 2 patches are minor refactors
> which move some of the mux update logic to within
> cros_typec_configure_mux(). The third patch moves
> cros_typec_configure_mux() itself to be earlier in
> cros_typec_port_update().
> 
> [...]

Here is the summary with links:
  - [v2,1/4] platform/chrome: cros_ec_typec: Move mux flag checks
    https://git.kernel.org/chrome-platform/c/53a0023c6450
  - [v2,2/4] platform/chrome: cros_ec_typec: Get mux state inside configure_mux
    https://git.kernel.org/chrome-platform/c/0d8495dc0321
  - [v2,3/4] platform/chrome: cros_ec_typec: Configure muxes at start of port update
    https://git.kernel.org/chrome-platform/c/af34f115b3b7
  - [v2,4/4] platform/chrome: cros_ec_typec: Update mux flags during partner removal
    https://git.kernel.org/chrome-platform/c/b579f139e470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


