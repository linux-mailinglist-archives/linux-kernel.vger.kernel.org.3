Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E292753FBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiFGKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiFGKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5680AEFF10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:46:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 010AFB81F06
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E1C34119;
        Tue,  7 Jun 2022 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598775;
        bh=3AqcgFROyY3hkCEzdOdEFdNbxxw2PBTGqPDd+uvJsfg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HMQtJMbLxLQSEp7UXDJ7hEzxzW4fRv+j2PIoSK3J3pTWeudUPx8n5kx7opSQXGVHA
         EyniiYipGW9svD5twRM5TSY91gW1hzouKgenmFd4IrEb4WfSuIHHIXVLKQb1Kfz8kk
         JmX9onj1NqItd3H9uZeO9yh9ozWlUNaBPiftGsjH1noMt1mBZCQ3n1UPW0UFHisUgl
         f58QhKi0WiSPJ4h4L9uI5TH0f/Hr8C2O8FAR8NFakWP/K6pKzUtwWJuEnxxWmoR8K8
         5bJp5IhW2xYqnOEhKK6WmxpehnwHmfBH9Ka7MVDKJUOlm28k/qfDQOaGaDd4au6ROD
         APBg2hiXEMQgA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, support.opensource@diasemi.com,
        lgirdwood@gmail.com, perex@perex.cz, jiasheng@iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220531094712.2376759-1-jiasheng@iscas.ac.cn>
References: <20220531094712.2376759-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: da7210: add check for i2c_add_driver
Message-Id: <165459877402.301808.1092458245565665338.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 17:47:12 +0800, Jiasheng Jiang wrote:
> As i2c_add_driver could return error if fails, it should be
> better to check the return value.
> However, if the CONFIG_I2C and CONFIG_SPI_MASTER are both true,
> the return value of i2c_add_driver will be covered by
> spi_register_driver.
> Therefore, it is necessary to add check and return error if fails.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: da7210: add check for i2c_add_driver
      commit: 82fa8f581a954ddeec1602bed9f8b4a09d100e6e

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
