Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C6581311
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiGZMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiGZMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:21:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BDEB4B5;
        Tue, 26 Jul 2022 05:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7022B81609;
        Tue, 26 Jul 2022 12:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60865C341C0;
        Tue, 26 Jul 2022 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658838057;
        bh=dMsmEEAwYOObzLO5qEy+jt6mXJJ5N38xn2mW+BUHQRI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=W0E81hogS2fjZEJVIMZ5pr0MPsJYjH0VVBdVhs6C+/lOZ/3N4q7Fuq74z8wLh4NwH
         UK1+of6P6xDKyYx9/LAAxa2jhVJB0LxfzY1Hf1Pg3AcliJmrh/I4AXLZZmPJEykTSr
         Vv0sd5LJx7hyec7vP009SNMbIA8aToGlA1r+3lDq//d1tNC5//NuSXALLyJC4d8HzR
         t/zIw1U/VWGu1aanFJISk5qBsdCQhKKXZSmQ66aAzF3X1//UNGi16mUnIxT3JJS49K
         tXjXLKQlFoyHhqnO2NUUExAqtYBSHHkHBl6g75CWUiBkiaf6SXcBYL4NW5kuyqnB8e
         Sbxo5w59mYqFw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>, linux-spi@vger.kernel.org
In-Reply-To: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/1] dt-bindings: spi/display/panel: drop SPI CPHA and CPOL
Message-Id: <165883805411.119869.5769652988278331456.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 13:20:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 21:15:38 +0200, Krzysztof Kozlowski wrote:
> Rebased on Linus' master
> 
> Changes since v1
> ================
> 1. Rework patchset as Rob suggested, so there is only one patch - changing spi
>    and display/panel.
> v1: https://lore.kernel.org/all/20220721153155.245336-2-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi/panel: dt-bindings: drop CPHA and CPOL from common properties
      commit: 233363aba72ac638dda6838f8e817c46d36c2431

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
