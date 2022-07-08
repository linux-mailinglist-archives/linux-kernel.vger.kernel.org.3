Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD956C3FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiGHUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiGHUrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:47:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BD9FE3B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33525B82979
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD31C341D7;
        Fri,  8 Jul 2022 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657313258;
        bh=TNQrS3tTDqR7lZD0smrYAAnJl8bC+8AwfRdQfUueIUg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rHo7a7eKOPAYFDn5NwlXAF+xTLj7RDD75eU0RO7O5LEKqUnvhGYBffZoVeUjJQppw
         IImj6qRIRByh4UXZhZUz1j+iX5zBjGyUdrQu++DfXwBSRMpeqAHH4dUmE2Hma55YmC
         cF5rhU/u682smQGoRu9cy4cpvPrfgYUgnh/3ACcyzox2Gwg35VvrtkGqBPL3hNdUlI
         yJ2BmpolZKJ8izPOQt2P+gKfvobctPlIPkdT+yq9/xre/GTuytahOTs2Q1QcLbFnVV
         bdT8KfZo6FvLdLF3D02IySldGWNw/LAW82BtK2Q4Pre5NmYMlBOzoEoeQMelVuP0sM
         g9JWD8oLX0XPQ==
From:   Mark Brown <broonie@kernel.org>
To:     brent.lu@intel.com, alsa-devel@alsa-project.org
Cc:     ranjani.sridharan@linux.intel.com, mac.chiang@intel.com,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org,
        libin.yang@intel.com, peter.ujfalusi@linux.intel.com,
        perex@perex.cz, ajye_huang@compal.corp-partner.google.com,
        gongjun.song@intel.com, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, akihiko.odaki@gmail.com,
        cezary.rojewski@intel.com, rander.wang@intel.com,
        CTLIN0@nuvoton.com, liam.r.girdwood@linux.intel.com,
        yung-chuan.liao@linux.intel.com, muralidhar.reddy@intel.com
In-Reply-To: <20220708110030.658468-1-brent.lu@intel.com>
References: <20220708110030.658468-1-brent.lu@intel.com>
Subject: Re: [PATCH v8 0/2] ASoC: Intel: sof_cs42l42: adding support for ADL configuration and BT offload
Message-Id: <165731325483.2467307.752813461864251608.b4-ty@kernel.org>
Date:   Fri, 08 Jul 2022 21:47:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 19:00:28 +0800, Brent Lu wrote:
> 1. Add BT offload fetch to cs42l42 machine driver
> 2. Support cs42l42+max98360a on ADL platform
> 
> V8 Changes:
> - split the V7 patch into two patches; one for BT offload feature, the other for new board config
> - change topology name to sof-adl-max98360a-cs42l42.tplg
> - remove useless variable 'ret' in create_bt_offload_dai_links
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: sof_cs42l42: support BT offload audio
      commit: 1460b85daa0af45c1cd2c5e20133ce413184e3d6
[2/2] ASoC: Intel: sof_cs42l42: add adl_mx98360a_cs4242 board config
      commit: cd486d37493357369ec1d8f130d93806418def84

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
