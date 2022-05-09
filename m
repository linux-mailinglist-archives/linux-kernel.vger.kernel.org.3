Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83752042A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiEISJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiEISJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:09:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDEA28C9CE;
        Mon,  9 May 2022 11:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA5A2B818E2;
        Mon,  9 May 2022 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E22C385B4;
        Mon,  9 May 2022 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652119534;
        bh=XBXSA2sw3mrQpJSKqJ9XNceqpmgmJxCHCn28EwPITvI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jGoRYK2JvJ8X7muMC5jItXhoU6lXKZc2ndqY5ze6I2AUV810lSi0ScNauAktbK0AE
         hrAS006L6ivVdl4ri9RDFGHklW4X6zeHCZSO4Hp/Oq1XZ+KkfCxZ2FUIx2OW39obKe
         7Pl3k05uEWjiMI/V9DJuML4MLfor0cVZC5gd807yWKw0RcchtH3h9WLLkX3gJNkUNb
         FtQ5XGBNpT+HxtdpqQsp3TWMpeWH5Ch1H5EdJ0C1yJh4yQP6nfz8bXK/TxvJxyjYVk
         o/MLEIfAJxiBWp2l2iC5fgENoaqA9coSftUXu75MprcHZjmev1EuqJuRoKBittjbf1
         uaBUnKTtW3Nhw==
From:   Mark Brown <broonie@kernel.org>
To:     lukma@denx.de, Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220509121313.31216-1-lukma@denx.de>
References: <20220509121313.31216-1-lukma@denx.de>
Subject: Re: [PATCH 2/2] doc: dts: Add device tree information regarding wm8940 codec
Message-Id: <165211953261.1181242.4154346698218256883.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 19:05:32 +0100
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

On Mon, 9 May 2022 14:13:13 +0200, Lukasz Majewski wrote:
> This commit provides documentation entry for wm8940 codec.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] doc: dts: Add device tree information regarding wm8940 codec
      commit: 29e87c4f62e2e688c1c91da9f8d54d0f042cb75e

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
