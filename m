Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED86557EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiFWPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFWPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:48:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41C3E0DD;
        Thu, 23 Jun 2022 08:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1A0B82468;
        Thu, 23 Jun 2022 15:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2336C3411B;
        Thu, 23 Jun 2022 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655999324;
        bh=E2ZHa4TN+5+ejRiD5sM6vTPpHUBc/nI7dHASx3liJUE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZJ7KRe+PPhkrhtcpZO7Hpv5xz8T2QQ0uKQ+mbtqyV/uPJUvcM/wCNVtbvASGCh0eW
         LxZLqFi0ZfwEHAwM10jCnx3B3MseWbmmw9MVCn2HrOUFl7TnUEXOr8ttdsjm/NTeX3
         H4vgCmDBDOJhcrSDODTfKXdf/e8XLiN5eeJIbv5xdDChY1Kl4oo9dCjj7heOWbo9fX
         YaqDd1k9B270LN3IkVdsdngFaUxxwC/KmVcf1sflT3ARY8nkNqRSiLi+QBvylzNvMu
         6wA51T9zaS0me1goaaGsShDd0lMpo0iF0bbAQBHI+ijzQrdrgyVKKmiasvUYLZTvyd
         Nl8WurlOZk4lA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linux@roeck-us.net, pavel@ucw.cz,
        jic23@kernel.org, sre@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, chunfeng.yun@mediatek.com,
        deller@gmx.de, matthias.bgg@gmail.com, peterwu.pub@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, szunichen@gmail.com,
        linux-mediatek@lists.infradead.org, linux-fbdev@vger.kernel.org,
        alice_chen@richtek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Add Mediatek MT6370 PMIC support
Message-Id: <165599931844.321775.8085559092337130067.b4-ty@kernel.org>
Date:   Thu, 23 Jun 2022 16:48:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 19:56:17 +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> This patch series add Mediatek MT6370 PMIC support. The MT6370 is a
> highly-integrated smart power management IC, which includes a single
> cell Li-Ion/Li-Polymer switching battery charger, a USB
> Type-C & Power Delivery (PD) controller, dual Flash LED current sources,
> a RGB LED driver, a backlight WLED driver, a display bias driver and a
> general LDO for portable devices.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[09/14] regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
        commit: 8171c93bac1bf9e98269b2efb19ef4e6c4e55ed7

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
