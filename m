Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D6509233
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiDTVnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382586AbiDTVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794838DA7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C928B821AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C055AC385A1;
        Wed, 20 Apr 2022 21:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650490854;
        bh=7QRfVrCEKqRJBhIOT39b+us9XDpvDmsvc9P5y3uEIgQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dw4PX0/QOfCA9Axml6+wtRwf0dWzIhjobeBWuNexSWb2iCB43+dVAzPmkLJzmQ9N9
         2V+iDC2pfywqVMyhv607Obsj4sjZYJE9AeVyZIOMZ2R8ESmL+90w+kYqV8ZSvfs38l
         uymh9PFzC/Kdtmg581d2skPwxUu8Ui8oLhLTsazTxRw3pNFIlCNmkGkno9Ite8YNJQ
         QkjSVHofmBRP58Y/eEAoReOzW/fRBH/+2mxzqItUijuU68A5hOYyhYKlzpDOEPXVPp
         ftoyuq9Ii2ZNJPOs0zo5lF2oITuiNPbXAh23tQNDVfZiF5v+3eHr7Yc9ElOOMecSgM
         Xn35nEO9gdzmA==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
        lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220407153813.1231866-1-rf@opensource.cirrus.com>
References: <20220407153813.1231866-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SOF: Kconfig: Make SND_SOC_SOF_HDA_PROBES tristate
Message-Id: <165049085249.138067.17008390714250645371.b4-ty@kernel.org>
Date:   Wed, 20 Apr 2022 22:40:52 +0100
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

On Thu, 7 Apr 2022 16:38:13 +0100, Richard Fitzgerald wrote:
> SND_SOC_SOF_HDA_PROBES must be tristate because the code it builds
> depends on code that is tristate.
> 
> If SND_SOC_SOF_HDA_PROBES is bool it leads to the following build
> inconsistency:
> 
> SND_SOC_SOF_HDA_COMMON=m
>   which selects SND_SOC_SOF_HDA_PROBES
>     but since this is a bool SND_SOC_SOF_HDA_PROBES=y
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Kconfig: Make SND_SOC_SOF_HDA_PROBES tristate
      commit: e18610eaa66a1849aaa00ca43d605fb1a6fed800

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
