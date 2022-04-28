Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67E551324D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbiD1LWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiD1LV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40A5A94E7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E7A161F43
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99194C385A9;
        Thu, 28 Apr 2022 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651144723;
        bh=4FwS8ZqLFX/b+oKN3PZi77Ssb4xeXteo8CbKvZJr8WM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ds9YGxLJYfrtkbmsKcIBH/U4e7GVVfk0APPIAYM58tm3mNmYOMH0SNMZk3Xuq7fUI
         cRztPP5RC7GyKrQndlKjWc+vuVo7hsmB0JuqnmgTEzMHoVQjXAI1RtX24NX7rO7lt+
         9g8aR+d4E8Y/LgNG+JsmL+d0+Eu6MxrSi1neB8Hz5VETYInhAy9cEZCXSfgijbo4Mv
         x0BJgjSDLo3bx/iRk03Y4GW4nWygvodXnmwAziaepqP9E6sLTJjvSEW9yL/Q/jVi0M
         ujz8wcxLnLFmUfagMztXd0slpWPOH3Dxn9XVJaObeGXoefHVn567lZFBqlVyyfa6E2
         Tq3pDGuIRpmtg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.18-rc4
Date:   Thu, 28 Apr 2022 12:18:30 +0100
Message-Id: <20220428111842.99194C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 908b768f9a8ffca2ef69f3145e23a6a259f99ac3:

  MAINTAINERS: Fix reviewer info for a few ROHM ICs (2022-04-08 12:09:45 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18-rc4

for you to fetch changes up to dfd2b37edf7ef469574ef7f36e3a1905ac9ead62:

  regulator: dt-bindings: Revise the rt5190a buck/ldo description (2022-04-22 12:37:22 +0100)

----------------------------------------------------------------
regulator: Fix for v5.18

A minor fix for the DT binding documentation of the rt5190a driver.

----------------------------------------------------------------
ChiYuan Huang (1):
      regulator: dt-bindings: Revise the rt5190a buck/ldo description

 .../devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
