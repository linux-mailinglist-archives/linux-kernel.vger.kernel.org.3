Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04B450E748
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244010AbiDYR3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbiDYR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CFB40E7A;
        Mon, 25 Apr 2022 10:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCCEA614D1;
        Mon, 25 Apr 2022 17:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF16C385A9;
        Mon, 25 Apr 2022 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907499;
        bh=vXLMQVewDuf4CxFBhVBTEkU0dP04DdfcWaEPsVlr1IQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dPjlomPC9joKWwiksbIl6XiclQs1VrjOgEzaja2x7BIWGLucSaLbm3rcDs95VAxLo
         hHM9Zc+XanlnzufRPZBt+DCG1ntiZ6c66VjbljVi9BN1743KLpw7qPAL4Uf24pIDMg
         5e+sjVDN827TAZ/ma6JDNY1lV7QXameZQKf5c6lr0Xx2NZEyT0+zQBr2zKyQbj+iHC
         xRbTS4CYyhxw4mVvp8OLnAgchxvDMWm8ToGAu0NVyqqrqcKLBhFtlK1KgZaPkaiH9y
         byN84hIFljmbs3zMhSXRty5TupfqWORXZBL12BL1FBQqQakKee4SeaDKSKcwvStCIm
         VY/IvlY1q/qaQ==
From:   Mark Brown <broonie@kernel.org>
To:     krzk+dt@kernel.org, zhouyanjie@wanyeetech.com, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, sernia.zhou@foxmail.com,
        dongsheng.qiu@ingenic.com, contact@artur-rojek.eu,
        reimu@sudomaker.com, linux-mips@vger.kernel.org,
        zhenwenjin@gmail.com, linux-kernel@vger.kernel.org,
        rick.tyliu@ingenic.com, aric.pzqi@ingenic.com,
        devicetree@vger.kernel.org, paul@crapouillou.net
In-Reply-To: <1650724725-93758-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650724725-93758-1-git-send-email-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH v3 0/3] Improve SPI support for Ingenic SoCs.
Message-Id: <165090749609.584172.16916188059494565113.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 22:38:42 +0800, 周琰杰 (Zhou Yanjie) wrote:
> 1.Add support for using GPIOs as chip select lines on Ingenic SoCs.
> 2.Add support for probing the spi-ingenic driver on the JZ4775 SoC,
>   the X1000 SoC, and the X2000 SoC.
> 3.Modify annotation texts to be more in line with the current state.
> 
> v1->v2:
> Use "device_property_read_u32()" instead "of_property_read_u32()" as
> Paul Cercueil's suggestion.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
      commit: e64e9ad267ca22ee3db6f9d7a02dc8400a23d4c8
[2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
      commit: aecec8bbb225965c6f775b946ad7bf40736c8f09
[3/3] SPI: Ingenic: Add support for new Ingenic SoCs.
      commit: 6d72b11403549a34b485d2fe323c8a57b4dd1958

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
