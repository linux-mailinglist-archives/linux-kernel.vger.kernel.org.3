Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698464F7BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiDGJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiDGJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF5E615E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BA9FB826EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D826BC385A9;
        Thu,  7 Apr 2022 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324290;
        bh=OuR9ggltHzBXrSCtj6xo2RmiNgyO747UsXn97OvMqMc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gn/mW+uxD/riL8E1pdFjiJjifEF8B1Bf6vBuWpabS64iN+B1gQ7QLtaEFoyb+0wXz
         KbSZGf4i6ptdtJrBr3YKFsLbXcs+lylvxnyOwVVl7nW8tiypsQGuseOT/FoO8TXOnl
         nO3ppOkqsdhsJX6Mb+BGQJSqsPhTUY2p+U0DCYz3zVGIuCyia/ptwK3wv3wdsT+2dA
         zbtLlqhxH8hmPX9xvOiJaPxP+0nVZqcIrXouGzWFAGBxd5Q0AG26UkuVfFIrF20Aci
         4X69dUGtUhblAS4z9vvHfWrQZvXcgECuN6WADNb85hWJpBlMq12AhhsYUqXail7XsC
         gjGaojpN84Jfw==
From:   Mark Brown <broonie@kernel.org>
To:     vishwas.a.deshpande@ti.com, steve@sk2.org, lgirdwood@gmail.com,
        mr.swami.reddy@ti.com
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220405163533.2157401-1-steve@sk2.org>
References: <20220405163533.2157401-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: lm49xxx: use simple i2c probe function
Message-Id: <164932428860.3844153.16224414206632151177.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:08 +0100
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

On Tue, 5 Apr 2022 18:35:33 +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: lm49xxx: use simple i2c probe function
      commit: 6b84012ef242c8793c1fdcc002db48c822bb641b

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
