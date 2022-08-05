Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5358AB80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiHENVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiHENUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:20:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09AE002;
        Fri,  5 Aug 2022 06:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83F3B828CC;
        Fri,  5 Aug 2022 13:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8660DC433B5;
        Fri,  5 Aug 2022 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659705649;
        bh=QbDEzNgc+tnc/EiRK7ewfx5pdjf8B3pqEY2X5VmRCA0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G2CQRtkcZxgj4cRCaza74SDg0mC8LLXsZdycE3/7iVxfEWWKalDr8XrP2YOVTdedS
         2ZnrXa8kP+epGICHHPE0b6TI1gu5OaIlzazaPhZ1QY6tdiDdm6s2S92S39Ek3Pl1vA
         9VQT5OfFGdzSgPdw1fGL3yK6fr1w6Lzzx9k8f3JUxd07tHc59gIezXNhgaZiWA2B/V
         ovKulmCUIxEieDaSLX+vokVq9usYn1/Fc9QS4H4zr7Il7s7lR15BTCMIGwYDRmdF1T
         rCyPq/QiR+1tijG0GgR+Vua0wWoPPAGbvGAgqOUVFxrsj4brZIVZCraJG+WnrO4vr6
         B6B67N951K18w==
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20220805084458.1602277-1-david@protonic.nl>
References: <20220805084458.1602277-1-david@protonic.nl>
Subject: Re: [PATCH] spi: spi.c: Add missing __percpu annotations in users of spi_statistics
Message-Id: <165970564827.1040888.14839667895342115884.b4-ty@kernel.org>
Date:   Fri, 05 Aug 2022 14:20:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 10:44:58 +0200, David Jander wrote:
> Fixes sparse warnings of this kind:
> drivers/spi/spi.c:117:16: sparse:     expected struct spi_statistics *
> drivers/spi/spi.c:117:16: sparse:     got struct spi_statistics [noderef]
>  __percpu *[assigned] pcpu_stats
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi.c: Add missing __percpu annotations in users of spi_statistics
      commit: d501cc4cfc6be1ab9aef3ff0fa3b2afc52a1af23

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
