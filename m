Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650635B1CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiIHMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiIHMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F17DFF62;
        Thu,  8 Sep 2022 05:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01009B820C3;
        Thu,  8 Sep 2022 12:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E5AC433C1;
        Thu,  8 Sep 2022 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639656;
        bh=0mxXnqiCBIz6MCrFRUCqtBLAvMSXOlLHP2NCWyHlgvU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mxk5LTjMEjrKIxrO0ZArMAgMad5mpdU2em4hF5IPWbFKJ/X2x7uL7cPJ2+hm4xpPu
         aANlobG2HF3FvODTJpHtNQbbyJiocEjJej8+edk/EvPcJSRKDxFj+DNV60HyXOjZdH
         x1MFPeEHbdcQKgzfm+g9nYlOftvDMulbKwnaGnun4m5V83YqhX3qCnYb34sebU8AKT
         CVvYP/4S5S50u81jSuVoHarr2a+duJzQp0t766EE7zPvHiK73aqvMdlDPUbYPNstWC
         vHGtfugDqvfRgKdQbXPhCYcXgVqLD8Z0XK/7+7EETGFXqTce+zmHfu5vjRsvhsTSGD
         eSNh6ipRbN3ew==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>
In-Reply-To: <20220908010429.342875-1-ye.xingchen@zte.com.cn>
References: <20220908010429.342875-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] spi: lpspi: Remove the unneeded result variable
Message-Id: <166263965532.78625.7360091717176089663.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 13:20:55 +0100
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

On Thu, 8 Sep 2022 01:04:29 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value pm_runtime_force_suspend() directly instead of storing
> it in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: Remove the unneeded result variable
      commit: 014eac3e93515ef37a794b1880340efd616d5768

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
