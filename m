Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53E5A4D06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiH2NHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiH2NHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:07:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC275CE2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67E96B80EE6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCF0C433C1;
        Mon, 29 Aug 2022 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661778088;
        bh=CZ+Ha6ACDYZ31GGjbUkwMq3dGzF9Rq7X/FgF0YKPPT0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=mjzOvsFeA4TTRMdz/sONIrEzkVLX1gWGXAGuQ4t+90agKVX7cK1Xmi7hSYaqUjg1n
         /Ke0l88pXFMnOjpophH04Y2ZA82Ohv/irKoDOGuSOSiTXzhnektJvEsAKAEdI5Lav+
         LNiGdzKginS5GFrrDj/F8XtjIHsf8rA+zPcHNuxd0cq6pjrBoelG+oKVi/ix0DqnCk
         u9rl8VpZCmmf1dGgnlicRVNcNP8ho7jZKLLIUgw2SEqteVVntQinPwvLQbbcv1tV70
         5LQDJLW2pyWLSLHMXw0KhGh6IrHteBC5r6yAE94wKNpJm6jqdSa3pkUahJIj7r1/JQ
         IsrCXDLmqaYUw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, krzysztof.kozlowski@linaro.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
References: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Message-Id: <166177808650.741330.2635943625001283244.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 14:01:26 +0100
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

On Fri, 26 Aug 2022 12:36:59 +0300, Krzysztof Kozlowski wrote:
> Motorola CPCAP, Lochnagar Sound, Rockchip RK817 and Qualcomm
> WCD9340/WCD9341 do not depend on parent MFD driver in build time and can
> be compile tested without respective MFD part for increased build
> coverage.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: allow compile testing without MFD drivers
      commit: 5b7f4e5de61ba8c44317718936864da29eeba62a

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
