Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E365593279
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiHOPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiHOPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81818363;
        Mon, 15 Aug 2022 08:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 633D0CE112D;
        Mon, 15 Aug 2022 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A385C433B5;
        Mon, 15 Aug 2022 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578306;
        bh=Dt7UFo2hvk7w801In8MZ1AepU8mKiD3cZKwIGWvPBEk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=VaShcqkZ3uBeBiArMYvK8aBgmTU/EliuOj3Wj3/q/yK3G/ZEhjdcip69t5dXv4FmB
         foUpscijB5fKc5R6b/ehGr7tPvFvJ6nYf2ID+PNovjLf5+f78B2CsN8oO1eY3xHa1w
         S/tk0FTIaxrAhv5DXn1aUf9PpnDx6lfVMNRZdgmz+kX7Qw+60X8I9Gbp37rgnvWHpf
         kUwveCtyxg9XRYmySC+ZJ5GtMzW5Z2dqXkdOxP9dB5MioeVKL9RTeY+UzUp99a9FwM
         143XYRmuUmXIPEfakwWQ+1HsCRqf/CfGDRvFSXASkhOK28k9VEg41bZOE8E0BNnT1I
         x8F+GTsH/nUYw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20220810131236.428529-1-krzysztof.kozlowski@linaro.org>
References: <20220810131236.428529-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: nvidia,tegra210-quad-peripheral-props: correct additional properties
Message-Id: <166057830399.697678.9931194157523714173.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:45:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 16:12:36 +0300, Krzysztof Kozlowski wrote:
> Re-usable schemas should use additionalProperties:true, so the schema
> using it will check for evaluated properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: nvidia,tegra210-quad-peripheral-props: correct additional properties
      commit: 63e2df2d9e46e7f9bbbe4a2b94426bfaedb32807

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
