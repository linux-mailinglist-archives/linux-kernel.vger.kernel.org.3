Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705904FE928
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiDLT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiDLT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB366AEA;
        Tue, 12 Apr 2022 12:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C52561BF0;
        Tue, 12 Apr 2022 19:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D09C385A5;
        Tue, 12 Apr 2022 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649793028;
        bh=YoI6Z5KYYwnoHCZZY4o7dhX5mC0b2rG6SYk2dpIb4Fg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XxqhmQXrk/9x6DgBLlGugkcJwpj2YoJgnNQ0yqC4v6dZvQOzLjqwxEeHFQv6d1ROF
         2r9j0/SH0IdoihWT4u20p8A4POJMErfEaxQ8UdKEQTt5epAlC96gx5rJQ+iE3ikqHg
         k0t+z2J2SFRXePaYNUFz1htRPRYSxigYYqoDoFbmeRHxM54Ln1Bkb8UdrWRSbC8HSP
         Lqf1pau7vD5kg07CNs0fW+eJL+k5z/u+F9m+i0V1zFL5uzwtwm9y40K/nMhM71LoTM
         djQ4twa/u4ixLm+yuDtfg7CNbMWkMVBo/Ou+ZuqGD+OVQt+c2hybMZTDF69nd5vE6o
         wJZzUQFSfn7wQ==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, clabbe@baylibre.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220411194409.3390002-1-clabbe@baylibre.com>
References: <20220411194409.3390002-1-clabbe@baylibre.com>
Subject: Re: [PATCH] dt-bindings: ASoC: fix invalid yaml
Message-Id: <164979302635.449327.5683662423554298406.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 20:50:26 +0100
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

On Mon, 11 Apr 2022 19:44:09 +0000, Corentin Labbe wrote:
> The word "or" is useless and breaks yaml validation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: ASoC: fix invalid yaml
      commit: 506840600613027f139d30447a2c27ec8088c698

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
