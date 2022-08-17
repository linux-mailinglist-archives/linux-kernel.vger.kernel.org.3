Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD259711E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiHQObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiHQObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5698FD7A;
        Wed, 17 Aug 2022 07:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F89B81DED;
        Wed, 17 Aug 2022 14:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB46C433C1;
        Wed, 17 Aug 2022 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746662;
        bh=/37xOLgFFyR9lC9/rK8t//Keov0kWYTvWZQazTYIghk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SCywGIC8zDAOdKBO+hN5TkQIZjWsSWZc6OBOtPg0Gsux+Gbh0y/zm4M53SQL1fY4F
         xfjHnnENM4FHxgP5EaSibRL8FWiy1S0J0uLqigJ8WT/ar3hwf84ERxJfAjWWNgQa2O
         VGqHqWD+YM6O/dRZnguVtcvn6F873fhk6s5QLmv4KI7FRtJ3tLUa1+dRK1H29BrleY
         pZ5Uwpn2xDkOQ+NgUow6fgCvIhysWJnjeVBqL/S0WxKWBl3v2cIsce/10TmcwcqUVb
         yY2Mv13uJ/mXs5WSHt6HmZocojQANek1bHbMPLKTsq4gg27ZeI9kYVOp/tPkCA29FY
         GU8uMC0mXi6+w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, robh+dt@kernel.org, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220816170118.13470-1-srinivas.kandagatla@linaro.org>
References: <20220816170118.13470-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: q6prm: add new clocks
Message-Id: <166074665990.210979.17992957875043506685.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:30:59 +0100
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

On Tue, 16 Aug 2022 18:01:18 +0100, Srinivas Kandagatla wrote:
> Add support to new clocks that are added in Q6DSP as part of newer version
> of LPASS support on SM8450 and SC8280XP.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: q6prm: add new clocks
      commit: ea15d3bd3cd6e9483bb8aa664954c0a8cde253eb

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
