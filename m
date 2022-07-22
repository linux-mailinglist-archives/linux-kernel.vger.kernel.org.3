Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C357E78A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiGVTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGVTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55857217
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BF261DA3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 19:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4DDC341C6;
        Fri, 22 Jul 2022 19:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658518775;
        bh=VHs38k86FD8Ipse+90wcagxiXIrg0RPFHyV7c6mJ+64=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rmmlAToJHxOlSd+lXyzxqoLDHJxLNVXR0jYmTDZOW6dOP1oWf7Kd1b4EgT3/LYuYX
         CKqhNZbCNPsPJnYzq70fkkRfRj6s5fIpWRV851NUzounrBQvNUeIm7yemANusup0pQ
         clYcQJ6LKrd7cq9X7aBQDU9Cg3Gsufj704tzGdccOsEkAKNWlcMvSut9vwNkmpxnd6
         /oRTAnlwNs61jSD40S+5decNTMpJ020WHU4OhkaeQUh2sHRdzvdFeDEV6WNTxv+5Er
         wYw+TTp6+R9bSLmX9lSmNd+7+q9oV91syjwGpJ9LAq2vMt3EN66EpY+TAlwmu+HSlB
         des/itefRM1mA==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
In-Reply-To: <20220722094851.92521-1-ckeepax@opensource.cirrus.com>
References: <20220722094851.92521-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] firmware: cs_dsp: Add pre_stop callback
Message-Id: <165851877383.1163063.17627437769670549231.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 20:39:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 10:48:50 +0100, Charles Keepax wrote:
> The code already has a post_stop callback, add a matching pre_stop
> callback to the client_ops that is called before execution is stopped.
> This callback provides a convenient place for the client code to
> communicate with the DSP before it is stopped.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] firmware: cs_dsp: Add pre_stop callback
      commit: dea997733575c5793ca77e166bbbf89097987eb4
[2/2] firmware: cs_dsp: Add memory chunk helpers
      commit: a4b976552f122ea851f556769874022cf097741e

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
