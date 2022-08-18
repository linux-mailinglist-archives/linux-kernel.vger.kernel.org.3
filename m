Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0528598717
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiHRPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbiHRPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A182BE4CD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35FE0B821C8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C6EC433D7;
        Thu, 18 Aug 2022 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660835466;
        bh=jEaSi3//ZcjcSJYCTtWKOStKXxh0VlQ4sbaPnZZ6OwI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jo4OYGwk/jSlf28wKYzzhjOGpVpdyfENoT6QGXc4wMosFOAEQh3hPqERuX88JYG+/
         jG6Vb4m5uebWNPmTrLnU7IiQxykWAv7Gn7Y/DuOtEllEoHgWap4vLPxCEtg8JmfxM8
         ciOIPOjk3r824OoSssFKeGA/Dfu3pDcB63UScGcGXV/2IxpJN249hkWsGtx2TYHdRc
         FmuYEIq15iDFuGBnaIvNCzVo0L1SSVywNPmZt+OJ/DrEnJIXMy2I9sd9kwtibrI9pn
         kkscqt/2s4sJpTFBRosK1GjdHaYAOGS/JFYZ97U40KolHvOt435U8zAKxi1gjbRE52
         2z1tk55KOi1wg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     rander.wang@intel.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
In-Reply-To: <20220818081751.2407066-1-yangyingliang@huawei.com>
References: <20220818081751.2407066-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: ipc4-topology: fix wrong use of sizeof in sof_ipc4_widget_setup_comp_src()
Message-Id: <166083546318.130965.12497020446854226805.b4-ty@kernel.org>
Date:   Thu, 18 Aug 2022 16:11:03 +0100
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

On Thu, 18 Aug 2022 16:17:51 +0800, Yang Yingliang wrote:
> It should be size of the struct sof_ipc4_src, not data pointer pass to
> sof_update_ipc_object().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: fix wrong use of sizeof in sof_ipc4_widget_setup_comp_src()
      commit: ecdb10df7e0d83bfd12fb8f71e28ea4753e3716a

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
