Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5455D209
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiF0Uqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0Uqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D667519C15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 904A3B81B05
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA3C341CD;
        Mon, 27 Jun 2022 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656362795;
        bh=L4YuvpMGrnXrS3Vp6XV56Nv9k75SEE7cHPVHrCuYlII=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TyLYdBD8uFSiH32EAQH7pTl9RjQK83mjPiWyJPjZ+sjQ6Lw46+RCTesAM+RnnuyBm
         45xHgMVAJ3JL57Cpu64+xAQpOei35Y9+BcWG7JX8XcirQ5S4Mj3vGxKyejayatmT28
         NwT53ohmPbmqQneyO+Pu7V6vkaBR27kh3efZa6hMpNLjSTfbicOJP3rWP/w44qYbce
         S7woXG/i9qmxDMXSDo/PgQqSvYe5Ox97L2qA3+oAdo5bVPWOhg2gGIUGat4mGpPRuw
         dSeUNxZ2GIzSsG4KnQnmrU/kiJN7Njn532INOAQMwPffQlKEh+ghj9MA8Md5EMzuEn
         4KX1D572G2/hg==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     lgirdwood@gmail.com, jrdr.linux@gmail.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, s.nawrocki@samsung.com,
        krzysztof.kozlowski@linaro.org
In-Reply-To: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-Id: <165636279349.4185952.15017228946920740997.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:46:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 10:43:35 +0100, Charles Keepax wrote:
> The conversion of the set_fmt callback to direct clock specification
> included a small typo, correct the affected code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
      commit: ccb0bbe3e93efa1c794176200785737ba65b0131

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
