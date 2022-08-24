Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E159FAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiHXM63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiHXM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1B97B11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D346162F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F93C433D6;
        Wed, 24 Aug 2022 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661345901;
        bh=d37TvzEEwV/Y4PGipJK/1XGqv3smEB6DxMlu5+fnV+A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pEiH716iUzx0z4CkedRKooX9m+2QGfaaBlPRgPyvrcvjyAm2bfZPg9kyoj4GRDsIW
         HkOpjMKDIKKJ7WURG+sB2E1FY7zfTZ7Jny9YaLzwxVXUlGDDU6y8/+GWPPaixtli0H
         t4lQ3yjtS/TkqzLxd9W+m4IgAQ9LJov5mVFeGEkfkArexirnufQ7jCOhaiEEOIyr/I
         oQuIqr+/hZa334npq348Cxk19Is7jTUYsIsEZy/uHEtKmKPUy1cpivmoRDGZTgfovl
         g9HmNgQNVneBckdPurpdQ6EWvUnWu0Xl7rTZGA8h6py4X/USE8F9JC7BC8SH/mzBr3
         I2y/L77R/6baQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peng.zhang_8@nxp.com
In-Reply-To: <20220824013234.375738-1-yangyingliang@huawei.com>
References: <20220824013234.375738-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/2] ASoC: SOF: imx8ulp: change es8326_regmap_config to static
Message-Id: <166134589925.62446.9609144399973742023.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 13:58:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 09:32:33 +0800, Yang Yingliang wrote:
> sof_imx8ulp_ops is only used in imx8ulp.c now, change it to static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: imx8ulp: change es8326_regmap_config to static
      (no commit info)
[2/2] ASoC: SOF: imx8ulp: add missing of_node_put() in imx8ulp_probe()
      commit: adc641f1dbce48914445efb79f302380ff10df10

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
