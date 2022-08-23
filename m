Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A308B59ECB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiHWTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiHWTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB7D11D6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A3CB8206A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE5BC433D6;
        Tue, 23 Aug 2022 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280597;
        bh=v2a8Ab0aNwJGMtkb8CZSGaqdXiDRPqmdyQ81ECzRFqI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XxThZNV7CNxQQ4gy14LjOHq7t/s/iALnFiqL9xctkg98k2uPtKgE7Bkz2spzwGOfq
         S19z/tm3liyJ9yhuGi2av3SccJ72F64Kch/fH12LmS1YKB2tkjZ/6bDJsWFL7OOqU8
         5eu9ToycKziVe08GHd5bI305SVDUte5nuvtmIWAuMG4j1LRXfag5vstTspsbIY2rxi
         KhaXhNKTPOie0omIGFDtDPx+y/M9WwUcd9EH0y/uoYJFYkcWqpTVKHlhkf5t4+aVC9
         QVu/9D1GR9yLqblpBXq+rX9hODHQMLLWvNltXbOKRjnVU8xZpxG/WFPIu9bPcbZux6
         QVjyvdoHQ5AxQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
        festevam@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1660555546-24223-1-git-send-email-shengjiu.wang@nxp.com>
References: <1660555546-24223-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add support multi fifo sdma script
Message-Id: <166128059487.1031684.18152206941376913913.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:49:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 17:25:46 +0800, Shengjiu Wang wrote:
> With disabling combine mode, the multiple successive
> FIFO registers or non successive FIFO registers of SAI module
> can work with the sdma multi fifo script.
> 
> This patch is to configure the necessary information to
> the SDMA engine driver for support multi fifo script.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add support multi fifo sdma script
      commit: 88630575406fdf2a7853545a884484bd55dab8a0

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
