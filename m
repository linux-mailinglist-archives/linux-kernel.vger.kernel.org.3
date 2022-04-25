Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAACB50E3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbiDYPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiDYPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2821E1E;
        Mon, 25 Apr 2022 08:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1813DB81860;
        Mon, 25 Apr 2022 15:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FADEC385A4;
        Mon, 25 Apr 2022 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650898866;
        bh=9hllUNLLrvoMwvZyuPXHkZexGl2ciWzTfh3rijJrpiA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=IaySX6Xm3kQ8Nd+VmYOTiycWuEgJBntduvaLUTxNRDD1p8ZtLGwyxD9dtLXUOE/rA
         rpoYkYOOv1dFqYkYl6/L3eykLrtNZh+nUfu8k5sp1WnCpR6p3JPMkzjNiH+5jusvAa
         mCjJpk+NlJyrdCqt3g5j00P6OgVudwHy+sSTzOt5/RlhWt/uY9y0V3QF3gYr618w5k
         nXFkx6k4i9vg6BN2K8pYjNoFqfIeaL1sVZ2bRG6Ts+FsCRkzhHuL1CEp+XEEoRxYtY
         fnrRkL0A5F0H8E/UWaj5y+HVxkW8Mb4SIEDVIU+7Hu8tUx2DGsyhn3bnlGZ3kqL0kI
         njXQoIujiGBjw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] regulator: richtek,rt4801: parse GPIOs per regulator
Message-Id: <165089886500.211842.728549769223794277.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 16:01:05 +0100
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

On Mon, 25 Apr 2022 09:24:53 +0200, Krzysztof Kozlowski wrote:
> Not tested.
> 
> Follow up of discussion:
> https://lore.kernel.org/all/2d124d53-1f36-5315-3877-af8f8ad5f824@linaro.org/#t
> 
> Changes since v2
> ================
> Patch 2: Do not use core's ena_gpiod feature because of lost voltage issue
>          (ChiYuan Huang).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: richtek,rt4801: use existing ena_gpiod feature
      commit: a498db69dc6d7511d76a4f04ec19c5e378db1c3b
[2/2] regulator: richtek,rt4801: parse GPIOs per regulator
      commit: 6963569103c02b22076da245b19bd081d8da8f9e

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
