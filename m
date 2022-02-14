Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA24B53D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355449AbiBNO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:56:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355442AbiBNO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A321DA6A;
        Mon, 14 Feb 2022 06:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42269B810DC;
        Mon, 14 Feb 2022 14:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69990C340E9;
        Mon, 14 Feb 2022 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644850571;
        bh=HDzAeVeVY85K0LMVCeSlV+SnO4ytuAAxmsUQatzA2gM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EXxyEUByrN/vI73VH445hyN0FDxd6tzdB9XIbE8YZmTeb1KxFIWi5Gw4k5nEVePRj
         IgNjuPU7YhcsywkHJlg3JRrBPONUsCX6ip0ztZTWJLz5ds4TkurFDEPRXmNG0ujWSe
         3rubrFMR0N0EiaJknC24EuFZGUEEOsCOYWkFVr8hYwA40SWUD5T7rlEXksWOfX5sjw
         Pvlt/Hzhc1F9zG68VhLI0r+/YdcfTHolmbdGtsDAYt23tC6e60A9Z1sJxdU0nO8rzc
         6XM+TP0mxXgREIbGbZ/wnnbsjldoJ+NFSkNIhxofpmvAHQDvriwiJ0Tn8kYqi5nFWw
         QD08MqTVA0Fbg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        lgirdwood@gmail.com
Cc:     kernel@axis.com, robh+dt@kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220211132449.2899924-1-vincent.whitchurch@axis.com>
References: <20220211132449.2899924-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] regulator: tps62864: Fix bindings for SW property
Message-Id: <164485057012.398102.344971709564057905.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 14:56:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 14:24:49 +0100, Vincent Whitchurch wrote:
> The property is not a pattern, so it should use 'properties' instead of
> 'patternProperties'.  Also, unevaluatedProperties should be set to false
> like in the other regulator bindings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps62864: Fix bindings for SW property
      commit: a94e5cd8457fb46866459562ef6c53f9dcc375f7

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
