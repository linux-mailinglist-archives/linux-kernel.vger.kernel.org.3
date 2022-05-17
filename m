Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E552A77F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbiEQP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350714AbiEQP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCF4C7B4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A496061236
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B8DC385B8;
        Tue, 17 May 2022 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803173;
        bh=OlVi754PWvWretVqYxq67E2aohcBH4s2889TUQW3KBc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SRokXpDeyHlG4seZRgvsGnwQlKy8eOt11cPXln8wZv2UIaGJgcR6ekll9EQstUEeb
         aLxDEjnAqmAQ1iAx2ouiihP3HYyaiZ7ETAlgNC7LopQXApYa6J1ImPQlUDYRnA+Zy9
         hT2r6uicnQT374PyC9MgNNjkq0J6Gv8VfithKaRVpycV2N/U6Gyjgao80quytTSkyB
         firecNHb1hRY4rWS35hbkrkwtitEtUAUKm7zi77MqRXqPruM7yEgKSdrqV7yFyE3Ab
         bvM9YAYIna3x/CtjtlC+thpagYCsT00omA1/PLZ3bIKLNaCVozZCPaMYW8mwbm18aV
         nOq6f0IoGLX9Q==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, shengjiu.wang@nxp.com,
        Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, shengjiu.wang@gmail.com, perex@perex.cz,
        nicoleotsuka@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
References: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP
Message-Id: <165280317067.1635268.8779077482848386414.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:30 +0100
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

On Mon, 16 May 2022 16:06:09 +0800, Shengjiu Wang wrote:
> ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP platforms
> 
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add support for i.MX8MM
>   ASoC: fsl_sai: Add support for i.MX8M Plus
>   ASoC: fsl_sai: Add support for i.MX8ULP
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Add support for i.MX8MM
      commit: 9e71bc33ae0d402b1579dc7a7afb3916dd35cb17
[2/3] ASoC: fsl_sai: Add support for i.MX8M Plus
      commit: 2530c5e875eab853125265b4f24a69e042d9580b
[3/3] ASoC: fsl_sai: Add support for i.MX8ULP
      commit: af0bd3c0ffae8c11790ab0108787c03767869a9a

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
