Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11C64D0894
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiCGUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiCGUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE07B541
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76D0EB8170D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB4BC340EF;
        Mon,  7 Mar 2022 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685568;
        bh=5S61BsIR/H5cTwmksDis/IvC7kKtQMQg9m+Qpo3d+Ec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p9raRPCGJzmCKsABw/ZELXBixP1/POtjWYHK475CrsVbx6JkYMQUUkh+jekzbICww
         ZVfhD+cpegaowbL/ayaRB1u+bVwcdM/PR5tCdWE6mQ+/j+KzvSmPsWPi7ZhkorQCan
         BlXnV+IYfvtU7DZcSxci/SHezivnSR4Lxn4T2oPiFIQrNeKaCnBw4v65qco0BT8lcz
         aPNpeHSl1PsBgopMb2LABt/I9iKh6CktUxDejWVweqEdHJEuPn8iiixVhKx0DRBX1W
         qgDj4korCJYmwqOL9Tt1H64xNJI8HZgh30UTs29uJbJm9YwqX1M7yZBRnckUafioNC
         6n8OqYxGy7h1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Randy Dunlap <rdunlap@infradead.org>, perex@perex.cz
In-Reply-To: <20220304160934.32010-1-srinivas.kandagatla@linaro.org>
References: <20220304160934.32010-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: select correct WCD938X config for SC7280
Message-Id: <164668556615.3137316.2971642861768642189.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 16:09:34 +0000, Srinivas Kandagatla wrote:
> SC7280 config selected WCD938X instead of WCD938X_SDW Soundwire codecs.
> WCD938X_SDW actually selects WCD938X, so directly selecting WCD938X results
> in unmet dependencies and below warning
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WCD938X
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m]
>  && SND_SOC_WCD938X_SDW [=n] && (SOUNDWIRE [=n] || !SOUNDWIRE [=n])
>   Selected by [m]:
>   - SND_SOC_SC7280 [=m] && SOUND [=y] && !UML && SND [=y]
>  && SND_SOC [=m] && SND_SOC_QCOM [=m] && (I2C [=y] && SOUNDWIRE [=n] ||
>  COMPILE_TEST [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: select correct WCD938X config for SC7280
      commit: 6ed5dbba6c971fe644f5c2b4aae436b39da99f18

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
