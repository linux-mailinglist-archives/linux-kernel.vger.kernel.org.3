Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA251890F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiECPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiECPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:54:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90753B01B;
        Tue,  3 May 2022 08:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53E18B81F30;
        Tue,  3 May 2022 15:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012CEC385A4;
        Tue,  3 May 2022 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593076;
        bh=1MQKMXKM6m6N7ENrzmFtWOnFCNAixZZ29Xy7sbT9f6k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=u/5G8RDJMMa9Zb/IkRaFZ2m1g6mVbsitHVzQuVm8qqwXip0I0ehrHHy549N7SM0s/
         K3afGKvVzYHIlZPg/s6TLcmCkgT25AE5fKEbHeZQiCuw7oagOhziZ8/XgxWo/FJDCy
         6k+OOehP3TFx2IHhcdPAbFY7wl3gzhpkv/YqjFYEH6fZbBhEwbT2MuEuVdbuSWkc4u
         kQu6T0XBwA7KyCfAbQffQcu6w8ArI6p8cXpoRwuj8km1ggx0d6/q3qxjxSBdJivjsN
         MWo2s6AQpduc80PfrSn5H0TYP/yJNd0k6EdRyxyD1fTL6CAAysMQytVWI0VuL2E+sQ
         HEYx4IDW0EaAA==
From:   Mark Brown <broonie@kernel.org>
To:     abbotti@mev.co.uk, linux-spi@vger.kernel.org
Cc:     p.yadav@ti.com, dinguyen@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220427153446.10113-1-abbotti@mev.co.uk>
References: <20220427153446.10113-1-abbotti@mev.co.uk>
Subject: Re: [PATCH] spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
Message-Id: <165159307472.184303.9043361573440279705.b4-ty@kernel.org>
Date:   Tue, 03 May 2022 16:51:14 +0100
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

On Wed, 27 Apr 2022 16:34:46 +0100, Ian Abbott wrote:
> The Cadence QSPI compatible string required for the SoCFPGA platform
> changed from the default "cdns,qspi-nor" to "intel,socfpga-qspi" with
> the introduction of an additional quirk in
> commit 98d948eb8331 ("spi: cadence-quadspi: fix write completion support").
> However, that change did not preserve the previously used
> quirk for this platform.  Reinstate the `CQSPI_DISABLE_DAC_MODE` quirk
> for the SoCFPGA platform.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
      commit: f724c296f2f2cc3f9342b0fc26239635cbed856e

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
