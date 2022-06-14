Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027C354B78D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbiFNRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbiFNRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:21:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C232EEE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C346B81A2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6009C3411E;
        Tue, 14 Jun 2022 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655227258;
        bh=p/VKG1rDAA+aAWsG57lOpE/6sIdp+ee6SPXOLgjcCUU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lrQ86pa3xiFVyV9AuQEPora8zm++cxrClQhhAq7t/tY06j9ZOo3C7aFwmcEW5iz+C
         GtXZ5wKLTwZdlW7PpYCGhPg0uwO2peiRMBCV499REps2z8wkXHOeZwA7ddfz+C7X2l
         QCX2mUEo3XYsOWXuVYy3QnG7zleva052v3ugr7OZjNBZtrFOSgTVAUz+xgh/0CET6D
         3mg8tdBTUMInBT8YB/bCq8DF2YkVx4TR/oSk6SV/1IPNfjgAw6HA1CfB0yqIdu13Q4
         fKjYyUEXjn4zeAbZl4bwyC+6saq33q2QH2V3t5OG2ldAaX34Ged3TjVtb4RtrSbYv/
         B5n4KqwsEVoLg==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, patches@opensource.cirrus.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com
In-Reply-To: <20220614131022.778057-1-ckeepax@opensource.cirrus.com>
References: <20220614131022.778057-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l45: Add endianness flag in snd_soc_component_driver
Message-Id: <165522725660.2442209.5932511980580944240.b4-ty@kernel.org>
Date:   Tue, 14 Jun 2022 18:20:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 14:10:22 +0100, Charles Keepax wrote:
> The endianness flag is used on the CODEC side to specify an
> ambivalence to endian, typically because it is lost over the hardware
> link. This device receives audio over an I2S DAI and as such should
> have endianness applied.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l45: Add endianness flag in snd_soc_component_driver
      commit: d919630fe77904931277e663c902582ea6f4e4cf

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
