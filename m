Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA35104E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353958AbiDZRLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiDZRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:11:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2A33A34;
        Tue, 26 Apr 2022 10:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF3BB8210C;
        Tue, 26 Apr 2022 17:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6AC385AA;
        Tue, 26 Apr 2022 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650992877;
        bh=z8XjpnqOvJUbja+qK9jiBSvWbNGD8GrNw7y0G33iHfU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=MwKZLLU4pGdM68uuQVPsV8JrCw8WG/PWkfeqfkCgzdGQVUO1puSRaa7fB5xuk9wDw
         JhxdAAM0CFsfR2MySPyYz9Q1Tr8pY6q+dx5DsHSTdDtjuOze3TTrOjL7wUNx4hAV3V
         sK9mu/saDwpFXJ80r787Hc1TsGt6fnw4u87fUvkr8nC/Dd2l0OffAMTwz6MvThRE6e
         PrIroClFFi2gg8CRXVZU2U+Zq1/9OHyHDKDkLgC4Rtcs08NjcNM2KB7Aws7NxArZJu
         VXWGMETP+Kj8LjcNivkdk/ou05iyqamCmCWRcRR2bKiyq9qXfoa6GHW+33XRnmubs2
         y1mO8Z7kDt+9Q==
From:   Mark Brown <broonie@kernel.org>
To:     stephan@gerhold.net, devicetree@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        pbrobinson@gmail.com, lukas.bulwahn@gmail.com, krzk+dt@kernel.org,
        cy_huang@richtek.com, ryan.lee.analog@gmail.com,
        pierre-louis.bossart@linux.intel.com,
        srinivas.kandagatla@linaro.org, hdegoede@redhat.com,
        drhodes@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, ryans.lee@analog.com,
        Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220425173715.1827706-1-ryan.lee.analog@gmail.com>
References: <20220425173715.1827706-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Message-Id: <165099287287.2323572.11051414352040587552.b4-ty@kernel.org>
Date:   Tue, 26 Apr 2022 18:07:52 +0100
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

On Mon, 25 Apr 2022 10:37:15 -0700, Ryan Lee wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> This patch adds dt-bindings information for Analog Devices MAX98396
> and MAX98397 Smart Amplifier.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: max98396: add amplifier driver
      commit: 3a2c9a553f4785555408b32d59ebfe125d8b9f09

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
