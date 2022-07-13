Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE93573A99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiGMPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiGMPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8911B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E795E619F6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31707C34114;
        Wed, 13 Jul 2022 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657727611;
        bh=RLAlbg/ljGHtCwtTI1C+Qj2j4SMelIPhBh6jbFb1/wE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W0sUWld8/5j9/EUWbwHhDi43z7rkQj6uNlXyqsWKnHPxCrEoQ1lfmSKlY0n090Cys
         grsjSXFTqkM5v4N0scqFwIDz5oVLqvT+6+70FRnQLKWbe24bFWg63XOEumqC3A+Ys6
         Wk6FsY0y4w6P2o4y4j4qY7Jtd17c9d3qwAnA9wI1mRUQNi0CEj7D3EKo7lSc26ieBN
         s1uaWGcyugmcjklZ470VcGiX4/9g9fA4IC5chSiYH5SzuQICIkH8p3a+l6mmxY+df6
         4CZsBFp2UzOKRgZ89PfF3WxrxWnmGkkmlunmPRC5uVqOCWTqll5qsEYhyjV/YU1//4
         85joRwZfhU0gQ==
From:   Mark Brown <broonie@kernel.org>
To:     yung-chuan.liao@linux.intel.com, vkoul@kernel.org,
        alsa-devel@alsa-project.org
Cc:     srinivas.kandagatla@linaro.org, bard.liao@intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vinod.koul@linaro.org
In-Reply-To: <20220708061312.25878-1-yung-chuan.liao@linux.intel.com>
References: <20220708061312.25878-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [RESEND PATCH v3 0/2] ASoC/SoundWire: Intel: add sdw BE dai trigger
Message-Id: <165772760890.142759.10751775895640491241.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 16:53:28 +0100
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

On Fri, 8 Jul 2022 14:13:10 +0800, Bard Liao wrote:
> For SOF IPC4, we need to set pipeline state in BE DAI trigger.
> @Mark, resending this series in case it is lost in your mailbox.
> 
> v2:
>  - Change "#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)" to
>    "if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] soundwire: Intel: add trigger callback
      commit: 6d1c1a73e1126572de0a8b063fe62fe43786ed59
[2/2] ASoC: SOF: Intel: add trigger callback into sdw_callback
      commit: 2a1be12c4d77d4f7b122568383382e006a60381b

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
