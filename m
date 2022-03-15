Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BAF4D9C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiCONmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiCONmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308F952E51
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E9F61646
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DFBC340E8;
        Tue, 15 Mar 2022 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647351646;
        bh=C/o2T8nJgf3Rnc5Q9iT/wcGUFU5ZGrsNC2dWsPGR7K4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UdxrzCsPqbbxkCeIoUMtBeHpiBEolJbIaeipPFlL47wev0K70DexdCnkIuF4RIYED
         P6JsarA9Y7uFVzxlfarDe13HEMkrJ0dG3HVsJedmeXvC4tyJ3DWVW/l9snGwaa3ktC
         4EUawKIxAx5mQSFUSSVBpRWzaKMer/D99cJBLFlvMYSrLK35EvNsufJyciBqQQ4sgY
         ybzOkbnBgYqobzfW/itPPMSi9JTc1uFTl8qOqe06RjpNsm2yCQFk7sTtNaTNdywEXJ
         gvcZNw4oZDJ9p1JdkaeLI8SWZ88zfbgHOHKG1CL4unO4jaNgZpA1cmLTuMq20yxz3V
         U/FGgcngwQfuw==
From:   Mark Brown <broonie@kernel.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nugraha <richiisei@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>,
        kbuild-all@lists.01.org, Nathan Chancellor <nathan@kernel.org>,
        llvm@lists.linux.dev,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
In-Reply-To: <20220315001848.3763534-1-alviro.iskandar@gnuweeb.org>
References: <20220315001848.3763534-1-alviro.iskandar@gnuweeb.org>
Subject: Re: [PATCH for-5.18 v2] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion` warning
Message-Id: <164735164416.3687290.11047333931734060111.b4-ty@kernel.org>
Date:   Tue, 15 Mar 2022 13:40:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 00:18:48 +0000, Alviro Iskandar Setiawan wrote:
> In function mchp_pdmc_af_put(), Intel's kernel test robot reports the
> following warning:
> 
>   sound/soc/atmel/mchp-pdmc.c:186:34: warning: address of array \
>   'uvalue->value.integer.value' will always evaluate to 'true' \
>   [-Wpointer-bool-conversion]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion` warning
      commit: a8ae15ead9c9d10671c3f76cb0749dec6e571ce7

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
