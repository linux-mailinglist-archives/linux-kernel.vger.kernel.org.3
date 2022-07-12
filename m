Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128B572277
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiGLSWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A13D087C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 141DA61AAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55023C341C0;
        Tue, 12 Jul 2022 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657650152;
        bh=C2rhacqCp1pKnkgrfxEegnBu5iOnykXAIF50U1eA8Hw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HchhSp5useKHMKkM9XPqSOOip9mwqfM9Ws4NK9H9PSwE9PE3dpST00Efj2fPuRMJn
         ALtnnRuBIAibwm5+m2CNp2zwAEcB9HAWmxi583ShrC3MD1zEvD/GhWKXSVymf2yeht
         MA51TfKVPgwHxtP75hEFTtFQ3HMfn5Ac05fafKOwi2fSYLltcxRO/sHILMMefJSbfc
         x+wnb/4koMZ2S6DNHa8d3e8iWw0+lfUouuHU2MYQrhx9Z+4ZHbhlKSzm4b+sWxIkeG
         Bp5Ps6rqh3Y6Xo+oS/ferBSDydo+xVpby0srENR6getmBUKi3kvr2RfzH+9JbIoPkD
         X2aqzHeuMC8xw==
From:   Mark Brown <broonie@kernel.org>
To:     daniel.baluta@oss.nxp.com, alsa-devel@alsa-project.org
Cc:     yc.hung@mediatek.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com
In-Reply-To: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
References: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/4] Extend ipc stream parameters sent to DSP
Message-Id: <165765015006.502248.16563043573406286114.b4-ty@kernel.org>
Date:   Tue, 12 Jul 2022 19:22:30 +0100
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

On Tue, 12 Jul 2022 17:15:27 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> We need a way to send extra parameters to DSP firmware. In order to do
> this, we introduce ext_data array at the end of ipc_stream_params.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: compress: Dynamically allocate pcm params struct
      commit: d5770daef62d2e4d33015089bab392ef867fd35a
[2/4] ASoC: SOF: Copy compress parameters into extended data
      commit: 3f70c360d484466da7420f395d4675ca02436e32
[3/4] ASoC: SOF: compress: Prevent current kernel running with older FW
      commit: 246b135fcdba57a4e77a702580391ae1942c1e3b
[4/4] uapi: sof: abi: Bump SOF ABI for ext_data_length
      commit: 75b5b7a1ccf606281c4afe365a57ccca486641a2

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
