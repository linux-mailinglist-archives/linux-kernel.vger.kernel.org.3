Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AEC5104F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353903AbiDZRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353911AbiDZRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688D340E4;
        Tue, 26 Apr 2022 10:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3869F615C4;
        Tue, 26 Apr 2022 17:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EAC385A4;
        Tue, 26 Apr 2022 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650992881;
        bh=t+NgkpJB3vxQf6yAgzdBpY45jLxBhqyRF9ybIDrNW+U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dprNeE3Gcz7UyJ56wAKgas6P4y19joJeUg1d4xyaKsYa4+7R4Cm6bsqgiITv+X8fK
         WYpgoGnQkJlMTCYuGURqgUtcZ1LVypg8UmBkfyHoKvuAvuA7b6V7VEhvChuD6QadKb
         aIukV+kkagv+uwXN7yJdF7DTErhc38CIGndmrWvPeDSYiCFzGdK18PsQ9bMHKXhrpr
         WCabTaXTdSCQin1TNYWqb2xN2LMrY5+OdQYLX1qNSqEknibbBKYPtR4hjYBsTdUkGI
         4XM6CABR1M0vW6SWHPR5tEZVeaveZ6Y9XcdO5MclzLEcmvB+4x5U/lIIsvi/GH5G8/
         Ujt94HRPiAlaQ==
From:   Mark Brown <broonie@kernel.org>
To:     stephan@gerhold.net, devicetree@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        lukas.bulwahn@gmail.com, pbrobinson@gmail.com, krzk+dt@kernel.org,
        cy_huang@richtek.com, ryan.lee.analog@gmail.com,
        pierre-louis.bossart@linux.intel.com,
        srinivas.kandagatla@linaro.org, hdegoede@redhat.com,
        drhodes@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, ryans.lee@analog.com,
        Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
        alsa-devel@alsa-project.org
Cc:     lkp@intel.com
In-Reply-To: <20220423021558.1773598-1-ryan.lee.analog@gmail.com>
References: <20220423021558.1773598-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH V3 2/2] ASoC: max98396: add amplifier driver
Message-Id: <165099287726.2323572.10174502705514813349.b4-ty@kernel.org>
Date:   Tue, 26 Apr 2022 18:07:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 19:15:58 -0700, Ryan Lee wrote:
> This series of patches adds support for Analog Devices MAX98396
> mono amplifier with IV sense. The device provides a PCM interface
> for audio data and a standard I2C interface for control data
> communication. This driver also supports MAX98397 which is
> a variant of MAX98396 with wide input supply range.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: max98396: add amplifier driver
      commit: b58581136770569d2ee4300b10c7c0d76bb86250

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
