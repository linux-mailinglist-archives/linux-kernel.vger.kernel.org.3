Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFE54317F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiFHNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiFHNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:35:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5ECC3666;
        Wed,  8 Jun 2022 06:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A871B827BA;
        Wed,  8 Jun 2022 13:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F06EC34116;
        Wed,  8 Jun 2022 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654695334;
        bh=B/8ENlbcOWNJTTEy5qDFazujVLKd+PmNdH7Y6kmfmdg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B6F7HJmuT7+oBM8n0dby41ZBCM/CBgERyrvk3SVbfDpvlnTXK4t+jLX2lU1Y7CLAY
         D+YUMuYhqWCwTnpAzfsHF3Zl1UawyCYyRnYvOhRUP2QIjjVhh1ZmbE1hoXILEQnZr9
         ZtQzIUBvEiZJ27EeELRwf8smJJ7dfS/TBQTImfd/ErUD7iGiRwD4lUpQ588gD2Ium2
         cwyv/ACHs0Fcbg3TNxffNCnYMukIVwemDeHzCv+HpGiDFrhjfBbL+zn/zgPD2PVKL0
         0lPFOmS5qOw6e/2o6wmIzq1BrScVD5ozJ+Ec98/iDoNTighBFEFQ9LEbJRaUAkk1Oc
         WeZ0fUXoPKhpg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org,
        Colin Ian King <colin.king@intel.com>, andi@etezian.org,
        linux-spi@vger.kernel.org, alim.akhtar@samsung.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220608081912.2083086-1-colin.i.king@gmail.com>
References: <20220608081912.2083086-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: s3c64xx: Fix spelling mistake "hannel" -> "channel"
Message-Id: <165469533210.615889.1786838524919245365.b4-ty@kernel.org>
Date:   Wed, 08 Jun 2022 14:35:32 +0100
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

On Wed, 8 Jun 2022 09:19:12 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Fix spelling mistake "hannel" -> "channel"
      commit: 9723070ecb280e3046dd32a4d11cb52a332507cc

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
