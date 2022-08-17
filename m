Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90088597125
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbiHQObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiHQObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64BE91088
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7186D614B9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EB0C433D6;
        Wed, 17 Aug 2022 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746666;
        bh=+fAp6q0oNEBcBmsZFkorVQv43BFESvY96V4smdRItO0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZMztFhN/hAv57Vj9ldCdrInquS1yuzUY9MmCzygZ6Di2ZH3ApbYyfvhAbWZyJVTLN
         kbZoOTGJObkZoMPNO/FwaZ4nrFTz7GWE7m028mHG1iOx+I9tXYnczhoNVyykA9IqEK
         sKlLQTbmoPBoCvK4FWO04dLcjyogbccSEmlHoX7Nd/PrKwr+jsnlnR2S9Jlyw3g7Gi
         0vVTkwNVZv6RDYL+8N4nzUSUgv8A10DwzXqIq2BH+c8AKnayYpxYjvhHB+oyToBfEN
         Hm/9mT9WEFuPBs/SnmoMfjS6pMxRVtWJXKrrhwbeUuC28kxMW4LbA6Z8AnGx45zjrp
         7xT3ILCxjXk+A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     laurentiu.mihalcea@nxp.com, peter.ujfalusi@linux.intel.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, daniel.baluta@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220817080529.10864-1-daniel.baluta@oss.nxp.com>
References: <20220817080529.10864-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/4] Enable timestamp support for SOF compress driver
Message-Id: <166074666372.210979.8582498171681865301.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:31:03 +0100
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

On Wed, 17 Aug 2022 11:05:25 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patchseries computes pcm_io_frames from the DAI position reported
> by SOF firmware.
> 
> Using pcm_io_frames userspace applications can later compute timestamps
> for compressed stream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: compress: Remove byte offset computation
      commit: bab10ec9fd9dc1537b705d0dd3862dd5982b921f
[2/4] ASoC: SOF: compress: Introduce sof_compr_stream
      commit: e3091f0a3f563ad1c9b60c290752e1190b67ea97
[3/4] ASoC: SOF: compress: Save channel count and sample bytes
      commit: 3ccbe6887747679d15e5c9524b23754281a24d9e
[4/4] ASoC: SOF: compress: Add support for computing timestamps
      commit: c1a731c71359407eae4fd0a5fd675ef25a582764

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
