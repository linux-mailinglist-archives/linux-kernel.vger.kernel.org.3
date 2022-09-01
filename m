Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC75A9608
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiIALt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiIALtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:49:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6F13BB10
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 456DAB825C9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A99C4347C;
        Thu,  1 Sep 2022 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662032956;
        bh=oQcRcueyeZGLd5NpjwzZcahqf+ZvA/FTegc8Z5bzuu4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UasUgYzlJUCsMJUVfP4vW6me6slI0D+PxO1y/0Ze2IqeSPEvUS+w6RW+loPT4Li8t
         NVZBJXqkUWcMKTxqVPL4MQ6WqXOlXE7visxBosES2VstcaoW4dc6R4PKco/P8c+NKb
         T58g3LdhKp4VKIJSXWehQ2e9xw2j3cUp/8mul1Wwn4bGPiLtm0sMOQOFC35Asjae8v
         0chGz/4Y7lQj9w/l4vgUtL2YOetrewcoB/hevdaMlbGZdeGzN/oV4XUut4kXT5XCJ7
         u5VZmxVc7OzWNQAiKkH1GWOMZ+0XXAgOTnx+N6gs0Ub7mSAmoivPYJwDxSkhnNK6HG
         mmfgzWeirOK8w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel test robot <lkp@intel.com>
In-Reply-To: <20220901101458.365354-1-krzysztof.kozlowski@linaro.org>
References: <20220901101458.365354-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wcd934x: add Slimbus dependency
Message-Id: <166203295512.40681.12809849481799379505.b4-ty@kernel.org>
Date:   Thu, 01 Sep 2022 12:49:15 +0100
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

On Thu, 1 Sep 2022 13:14:57 +0300, Krzysztof Kozlowski wrote:
> The WCD934X codec is a Slimbus driver, so it must depend on SLIMBUS,
> also for compile tests:
> 
>   ERROR: modpost: "slim_stream_prepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wcd934x: add Slimbus dependency
      commit: 9815746c48ebbd38d32a7a1dade7fa1e3948c54d
[2/2] ASoC: codecs: rk817: drop I2C dependencies
      commit: 69e3e537ec8a2e345f72f65ff24d3486d4764d83

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
