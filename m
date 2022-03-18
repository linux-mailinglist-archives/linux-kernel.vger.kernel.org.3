Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC30C4DE305
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiCRU7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiCRU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA763886
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC8C60C77
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ECCC340E8;
        Fri, 18 Mar 2022 20:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647637071;
        bh=vndqZJnf+mtttA1cvC9HqQR34L16G84VxSZTW5w9S10=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bUZMmmfHO2JFdxdEIjBGar/c5/UNtTtrztdOstAqdd/YFERWhO3QA3fUJUBA/zgfY
         uRTxYIKUoF+z1k2fFN9GIS9GD/mujbQseJDmjdcwtWZevmwgYasPmR2udlSUDAr1AG
         SuQm8RdYOxRLKpRkQVc10tuns82muVThSF2XIpCNDe9xiay11WZmwZmyEzl4g7x/Im
         TrR69xiR9sgCyPY6K5BzFMoW85GIuuiLjhWsVTNvOUQEZUCq+wtnE8lhat8x4Y6jvk
         6n+bYav1ERkskJb9Z4Y4qXkVGcKmsPTNnS/tM2H4ELPjVJXQg3cCAyKHQDJGCut1F3
         TM3AWL8R9XPrA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220318092609.130901-1-codrin.ciubotariu@microchip.com>
References: <20220318092609.130901-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: print the correct property name
Message-Id: <164763707026.2336370.9467659339240399342.b4-ty@kernel.org>
Date:   Fri, 18 Mar 2022 20:57:50 +0000
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

On Fri, 18 Mar 2022 11:26:09 +0200, Codrin Ciubotariu wrote:
> The correct property is 'microchip,mic-pos', not 'mchp,mic-pos', so
> replace all occurences of 'mchp,mic-pos' with 'microchip,mic-pos'.
> Fix a multi-line comment format while we are at it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: print the correct property name
      commit: c639e85e93aa10ea0512ee416eead60da466e161

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
