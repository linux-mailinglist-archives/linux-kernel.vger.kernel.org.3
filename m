Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6664FE929
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiDLT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiDLT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:57:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6956353F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D8D2CE1E37
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBFC385A6;
        Tue, 12 Apr 2022 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649793030;
        bh=aBRM9sG0Z1BLiszeFEO4ei/zQqmpiKFPvY0NHwUIN+c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=blgB7BvqvEnC87M+Fs1165CJSFVuZayx+JdjdPn20o5vOfGgfDCF3kmR3Ldr26gVm
         +YfHynIspRgj9LS/t1IsaJIX8E5JB9bgINEjfLE0HFjOgekwCt6DFBCQvJzZyDJUcg
         UAlz6508+yLZpmSAKKLowVjeH5HPCTfko5SbCwfFrItbQdl9Q1W5Pcyu9+nmS717S0
         mNygbCXNHfc02tnYQh9z2TMhLIsU1Tw+Exv6OFci/xD+gpsBmfCUtzSKncxCFcH9Jg
         sjcITaBrMrpRhRa3uBPh37w919hSHO98WA8RgngC6w6GIAjPCdB2PKcV+YZ+f1KmUD
         P/L5fKAXOpeOw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, shengjiu.wang@gmail.com
Cc:     nicoleotsuka@gmail.com, zealci@zte.com.cn, chi.minghao@zte.com.cn,
        lgirdwood@gmail.com, Xiubo.Lee@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com
In-Reply-To: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
References: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: fsl: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <164979302826.449327.17327555437837608042.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 20:50:28 +0100
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

On Tue, 12 Apr 2022 08:30:00 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: c721905c54d913db0102973dbcdfb48d91146a2d

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
