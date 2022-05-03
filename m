Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34365518907
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiECPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiECPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:54:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6918B14
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCDD3B81F03
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A47C385AF;
        Tue,  3 May 2022 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593071;
        bh=bD6QU9rCe6V6XALAihvd/Mf6rbM3Lnv2v7TM9EY5xpI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fB1O+qgSLQbT9N6IglY4eS2nus83dqyj1Z7fJluzo2W5n3q4AW1N45PHXpdZlpn9s
         eGEyLsGtGM1uy8XZZG9zEEKocFhqKD4mmUegdKy/SfYAgTe9lVcWsOiiuuSI9xXelw
         VHst9iiBGboyY5HmI4AD2/RG4xnCJFZN5oqsE1uQNKjeh5pBp25vz2cWpSikkELlfN
         OV+RhCjbbfAAMIRpX3xBcdksKKRmru2sFX0wh5mHVle4IlKQXHpT6XVLr0XMU94bU2
         vC6avsdu0oMBUrhTB2tdunfs7qMI/6SqoKWdgRgUyUjVx8SmOakCIetRRAPPzkC4t2
         AbDWyCP0Utz7w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        rickaran@axis.com
Cc:     rickard314.andersson@gmail.com, perdo@axis.com
In-Reply-To: <20220429072211.24957-1-rickaran@axis.com>
References: <20220429072211.24957-1-rickaran@axis.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: regulator: Add property for I2C level shifter
Message-Id: <165159306949.184265.18297673482925857388.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:09 +0100
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

On Fri, 29 Apr 2022 09:22:07 +0200, Rickard Andersson wrote:
> From: Per-Daniel Olsson <perdo@axis.com>
> 
> By setting nxp,i2c-lt-enable the I2C level translator is
> enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] dt-bindings: regulator: Add property for I2C level shifter
      commit: e721b161399b30e085faa2f4b930ebeb15df36a7
[2/5] regulator: pca9450: Make I2C Level Translator configurable
      commit: 62139f52b7e588d565aa9df81ea0a0548a68b823
[3/5] dt-bindings: regulator: Add property for WDOG_B warm reset
      commit: bd2f5e71454bc84427c4fd67c5ea4881f155ac6e
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
