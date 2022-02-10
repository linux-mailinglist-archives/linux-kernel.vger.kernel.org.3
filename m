Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352D4B1516
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiBJSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:17:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiBJSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:17:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C90F1169
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:17:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEC261E5A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC03C004E1;
        Thu, 10 Feb 2022 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644517030;
        bh=y9KoYEHTuytQnzjdUCEQMgDLFL2j5uawuME74AvZBFw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ix/mZN/5UW7pmVM3vYhS7NC+PUaymZ+trN2vNmdR2x1+Jhg/EyMXtP6O/J0KCQZa8
         f3kpnqnwUAbrZwkQU9XW2d54BbskBx7K1C/sYEXQP8zZ7m0vxz8QyehqFEQX958Iz3
         qIq2HOuR9XJknJcVm3IwN5Oc8bVwyfusA+NvaTH4tBF8OIAhugHP5gn5/nrGQX+otk
         J0fy+g/JbeBvQ2/BHpQd5M7exuntEgKQWxDSSov9qCLwZgMMvQbIKxYAcEIk4nmGTf
         UYonPN9jiuDyUeX+rBH/UklWubkXd0VQ2SDdNFaQGrI3PN+IXIisAVMqDBDR2tGWi2
         gtzLpSDPoH5lA==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        fred.oh@linux.intel.com, linux-kernel@vger.kernel.org,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com
In-Reply-To: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/9] ASoC: SOF: IPC client infrastructure
Message-Id: <164451702780.82170.4074299845971307664.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 18:17:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 12:55:10 +0200, Peter Ujfalusi wrote:
> The Linux SOF implementation is historically monolithic in a sense that all
> features accessible in the firmware can be used via the snd_sof_dev struct in
> one way or another.
> 
> Support for features can not be added or removed runtime and with the current
> way of things it is hard if not impossible to implement support for dynamic
> feature support when based on the firmware manifest we can easily enable/access
> independent modules with the SOF.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: SOF: Drop unused DSP power states: D3_HOT and D3_COLD
      commit: 2439a35508277922ea116c99ff4d4a32c607464c
[2/9] ASoC: SOF: Move the definition of enum sof_dsp_power_states to global header
      commit: 5fdc1242453e2ae88b2cdb607e4eda6b687f084c
[3/9] ASoC: SOF: ipc: Read and pass the whole message to handlers for IPC events
      commit: ab3a2189a3744527f54ace1be19eb13e6c3d24df
[4/9] ASoC: SOF: Split up utils.c into sof-utils and iomem-utils
      commit: ee8443050b2bf06d80fdd2c78cc25cae2abdedcd
[5/9] ASoC: SOF: Introduce IPC SOF client support
      commit: 6955d9512d0ea814f1c2761bef7ad7b3cedf4d68
[6/9] ASoC: SOF: sof-client: Add support for clients not managed by pm framework
      commit: 1069967afe1e6b728061682ff99ec534a55a5613
[7/9] ASoC: SOF: Convert the generic IPC flood test into SOF client
      commit: 6e9548cdb30e5d6724236dd7b89a79a270751485
[8/9] ASoC: SOF: Convert the generic IPC message injector into SOF client
      commit: cac0b0887e5304bddfda91a4a7106f9328c31318
[9/9] ASoC: SOF: Convert the generic probe support to SOF client
      commit: 3dc0d709177828a22dfc9d0072e3ac937ef90d06

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
