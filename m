Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF25AD86B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiIERdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiIERdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412C5A3FB;
        Mon,  5 Sep 2022 10:33:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96E461369;
        Mon,  5 Sep 2022 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F6C433D6;
        Mon,  5 Sep 2022 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662399201;
        bh=fJl2loForj832KBRuUXO1rQdi1jQcxM/e8AQQzTuHYo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I73vtqRP5D3OpZADsGj16+2lyQtKBWSU66U5KTMIuET9gCbn3GP39nR7LRUMupe0/
         3riKs0mbTQKuJS0+hFS/TWYxX5yIR5QXDW9KFNKT8p+huHZgPCodGHuR9LvyfOVEkH
         LExEQrSmUQtKarJux/AAe/6Qfpe8wtLX5QzQbIN3KaQi0iZ/Mt7O3QK03aZFvU31ZR
         /KGf+qkXqnTHK6i0h4X8aUKiVP9s7TE+CywPweBUaSabPKVAFShoDp3oipchrRYuCv
         KO/ALv4vpBzWNTZp+HpUWvJFlDlnUFgCYEza2EWUYvfgtrwMyMIbTuZqF5xR++NBcq
         NgDEm+iDbNqjg==
From:   Mark Brown <broonie@kernel.org>
To:     pramod.gurav@linaro.org, Xu Qiang <xuqiang36@huawei.com>,
        konrad.dybcio@somainline.org, iivanov@mm-sol.com,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     weiyongjun1@huawei.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        guohanjun@huawei.com
In-Reply-To: <20220825065324.68446-1-xuqiang36@huawei.com>
References: <20220825065324.68446-1-xuqiang36@huawei.com>
Subject: Re: [PATCH -next 1/2] spi: qup: add missing clk_disable_unprepare on error in spi_qup_resume()
Message-Id: <166239919867.807748.1227253290015300046.b4-ty@kernel.org>
Date:   Mon, 05 Sep 2022 18:33:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 06:53:23 +0000, Xu Qiang wrote:
> Add the missing clk_disable_unprepare() before return
> from spi_qup_resume() in the error handling case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: qup: add missing clk_disable_unprepare on error in spi_qup_resume()
      commit: 70034320fdc597b8f58b4a43bb547f17c4c5557a
[2/2] spi: qup: add missing clk_disable_unprepare on error in spi_qup_pm_resume_runtime()
      commit: 494a22765ce479c9f8ad181c5d24cffda9f534bb

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
