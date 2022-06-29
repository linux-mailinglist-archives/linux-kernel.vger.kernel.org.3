Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB66D5601E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiF2OF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiF2OF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A12A703;
        Wed, 29 Jun 2022 07:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3443361EAC;
        Wed, 29 Jun 2022 14:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F6FC34114;
        Wed, 29 Jun 2022 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511551;
        bh=UTir4jvtX/Wc9f3wx5siduKUlp1IwFcyfl2zQub0Q54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dw1yUl6jJ7er1GoSbOqDxte5EKisctjZQcPmXUyqaQH1bY7xwW7YnFOeaq4U0mXSp
         G4I02MyNDCl5svJ8CsA9h+q4xVSspolwODPkBvv6QiqTjmAcIkoxPgkE3gfqHs/kt6
         WSHUJe0BTgDxI5Zvhlo/3ht1+i59FPyJmi1vYLZgznseboWsYn47Dt0RuZU6sSTK8j
         zFsA9Kxmiil2q3OQTReiEEclNgQADZkTo5hHJjE/ge6bJJ1Mecto2cBwmFsbxetqvk
         onok6aZT3wRCZHuOHZYOgAmeNkMharNuGXM1s9R/Q03NaQx7C1ca9wU8wj5PM8wgKn
         px5Etqg2jrL7w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
In-Reply-To: <1655980125-24141-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655980125-24141-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
Message-Id: <165651154969.1437597.15028170773257315286.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:05:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 18:28:45 +0800, Shengjiu Wang wrote:
> Convert the NXP MICFIL binding to DT schema format using json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
      commit: 02d91fe47100a29a79fcb8798e45c22591ca852d

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
