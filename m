Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663C653E022
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiFFDeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiFFDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750637A8F;
        Sun,  5 Jun 2022 20:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66436B80E5D;
        Mon,  6 Jun 2022 03:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0013C34119;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654486430;
        bh=/D6r6eFQWaD3GHW97LkfW9aZgvs8+Kd3rwRNonwC4fQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=APog56fByH20BF5ETxDCvtvc98kmki8O/2BYAAA8nrPs6BENtxw+4jFY3X7zEzD45
         q4DbIwUlALUvb8wpG2IY2scv4G8MjCrezrFqBI5QtviBYgo6KKlOB4slbHfvf581SU
         Zvp2AZw0Np6buiZcOsTL6lo+fXfFBjYP1dclowVpZrL+D+jebHHLEMIeDOfzyetqfs
         TPVtUFWwy4taP+7uY551/RtItcvkIAifYq8iKlcwh82wE1H8IZNtUhxiXTfDZmVxnk
         e91E1wCGwvgBexkxfA36EvRrd1jxlr80W3uCgGzfebWC7wqaf8YDdZZqrD4m4qY6a7
         1U0IPfNxTCySQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE19CE737EF;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/3] dt-bindings: cros-ec: Update for fingerprint devices
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448642983.20111.12412315955580522831.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 03:33:49 +0000
References: <20220512013921.164637-1-swboyd@chromium.org>
In-Reply-To: <20220512013921.164637-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chrome-platform@lists.linux.dev,
        groeck@chromium.org, dianders@chromium.org, hesling@chromium.org,
        tomhughes@chromium.org, amstan@chromium.org, tzungbi@kernel.org,
        mka@chromium.org, bleung@chromium.org, lee.jones@linaro.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Lee Jones <lee.jones@linaro.org>:

On Wed, 11 May 2022 18:39:18 -0700 you wrote:
> This patch series introduces a DT binding for chromeos fingerprint
> devices. The first two patches tighten up the existing binding and the
> final patch introduces the fingerprint binding. As there aren't any
> driver patches this can probably go directly through the DT binding tree
> if Lee can ack the patches. Or go through mfd tree if DT maintainers
> ack/review.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] dt-bindings: cros-ec: Fix a typo in description
    https://git.kernel.org/chrome-platform/c/f93afd8e7567
  - [v5,2/3] dt-bindings: cros-ec: Reorganize property availability
    (no matching commit)
  - [v5,3/3] dt-bindings: cros-ec: Add ChromeOS fingerprint binding
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


