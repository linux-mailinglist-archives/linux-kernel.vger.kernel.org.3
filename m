Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5CA518906
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiECPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiECPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32131DF3
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A806162D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA087C385A4;
        Tue,  3 May 2022 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593069;
        bh=hztVzgl0RhlzuB0nsEE7M9/RuUZtHtcGI388BwJTSq0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IkS38Vnw6SNWl+lkD8Yj56fr8pECWGp3iDQzS6bXWIX/0J8SQ43B0Gu1G/LwzKnpn
         xC7ZeNH/dKBee/IOqBTaVsX0Cg1wdwQ0adtBkN8GFTIFwZ25lPjbiUbiUuxBdI4kBI
         uGSG1m3ric6XS0c2XZr8Sy6/qE+F8zGxWqj6EyzVHfl1O08MZn+0TeCYFCtoFCSe0C
         8TQuw2WMby8U2f1BdG9R7Npne/lMR+Q+Z3bi7EcIlYr/nPWS7u+to+gzP0KlFFR6lG
         +ORJmTravMSOhPjue57COPrNxeWPkAskyCPQqYimj4qWVx4F0y3NcvhYVwBhgoNixh
         Ti1pJaXbBfczg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, yibin.gong@nxp.com,
        linux-kernel@vger.kernel.org, rickaran@axis.com
Cc:     rickard314.andersson@gmail.com, perdo@axis.com
In-Reply-To: <20220428140139.7349-1-rickaran@axis.com>
References: <20220428140139.7349-1-rickaran@axis.com>
Subject: Re: (subset) [PATCH 1/5] dt-bindings: regulator: Add property for I2C level shifter
Message-Id: <165159306760.184265.11006664770632810136.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 16:01:35 +0200, Rickard Andersson wrote:
> From: Per-Daniel Olsson <perdo@axis.com>
> 
> By setting nxp,i2c-lt-enable the I2C level translator is
> enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/5] dt-bindings: regulator: Add property for WDOG_B warm reset
      (no commit info)
[4/5] regulator: pca9450: Make warm reset on WDOG_B assertion
      commit: 2364a64d0673f5044e6a52cb17d6d60c6f1f8329
[5/5] regulator: pca9450: Enable DVS control via PMIC_STBY_REQ
      commit: 20078e3bbe6e5adb1a88f03f9609d532d99c690c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
