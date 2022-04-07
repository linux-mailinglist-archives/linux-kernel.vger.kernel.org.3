Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2D4F7BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiDGJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiDGJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7091A5904
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B3161ACE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF752C385A6;
        Thu,  7 Apr 2022 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324298;
        bh=DBVPDeXzBmVGG7sCJooAh/+/TXjuIyVnZzS709sXv0k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FC8EznJV7DIJKY83ZM9tbkumPwbYbTlynB0GwArqrleGuh+m/lerRYg1N8NhKVClG
         Pb0JWJFdQ+R2ak82F2gAvUqUoKGSui66C98vofau+fhHyA33s/A0YmvyvuaO4liTKj
         u/w7L080zELv3f/4A0/7FCRpSf64HXByC3X49PbrpNy2h0ktMcXXl41hR7Y5kSG9lW
         6uf6kjyfvEcoJpoJJ0mphVQ/R/UKjydf0aK7yd3yeGzLCu4ggO4ssc06IPUqLbJNKP
         Vl8YErfjIvl/bcrYua0iYPpP7Sy0kDxRcO61+z6gse5BuF4mmyAsrA2klIyyzVIXo/
         CyDVx8C8ZmeQA==
From:   Mark Brown <broonie@kernel.org>
To:     ajye.huang@gmail.com, linux-kernel@vger.kernel.org
Cc:     mac.chiang@intel.com, vamshi.krishna.gopal@intel.com,
        daniel.baluta@nxp.com, Jaroslav Kysela <perex@perex.cz>,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, yang.jie@linux.intel.com,
        yong.zhi@intel.com, liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        brent.lu@intel.com, ajye_huang@compal.corp-partner.google.com,
        cezary.rojewski@intel.com
In-Reply-To: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
References: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp on SSP2
Message-Id: <164932429462.3844153.4809967512345990079.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:14 +0100
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

On Thu, 24 Mar 2022 16:47:08 +0800, Ajye Huang wrote:
> Follow Intel's design to replace max98360a amp SSP2 reather than SSP1
> by judging DMI_OEM_STRING in sof_rt5682_quirk_table struct.
> And reusing max98357's topology since DAI setting could be leveraged.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp on SSP2
      commit: fcd1e39cca6e3a262f2badfcd5edd76c910ad3bc

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
