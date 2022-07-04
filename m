Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326C565D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGDSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGDSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:03:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41BDFCB;
        Mon,  4 Jul 2022 11:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E1F6B810D8;
        Mon,  4 Jul 2022 18:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DEC3411E;
        Mon,  4 Jul 2022 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656957814;
        bh=KeIrV7IsIQA+Gg5j5qbzLEwhyvqJCUF3LCrS337KMV8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uWB/yAMUWXflanaPwbZh29ZAJERVT9flU0P4KR9kzEPmOr3o18HjqsLRDBJ04gd8g
         /OI8XDTBX/+Kfdk8quk+N5XMfH0aWu2PknUg9CeM6MaCPj6P0oNzf8Nx9m7eWhpQT0
         CMLUkkR/3ZFsiN2cQMs5un3FK28/GHEvVYRVfCVacLE7dAjSzsJG210EB0dW8rOCHD
         vHPjx3zUoKLq40sRAAcQ9JwBItRXUZxGbMuHp/5awJ1PIhTK2AuFig3LNmKbmmy0NF
         B/SqyJ1wdiSjr8/RmQAw4PYPcfa8Q/18d6e6gCoWSVW5bCZnshcbc5MW9unOhBToCw
         1eAxvM9/tINpA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, iwamatsu@nigauri.org,
        krzysztof.kozlowski@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
In-Reply-To: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
References: <20220704130618.199231-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: cadence: add missing 'required'
Message-Id: <165695781192.3311776.4824742953879745650.b4-ty@kernel.org>
Date:   Mon, 04 Jul 2022 19:03:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 15:06:17 +0200, Krzysztof Kozlowski wrote:
> During the conversion the bindings lost list of required properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: cadence: add missing 'required'
      commit: 6eee27c598fde65988723b785a9c9192d5ffb93a
[2/2] spi: dt-bindings: zynqmp-qspi: add missing 'required'
      commit: acfc34f008c3e66bbcb7b9162c80c8327b6e800f

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
