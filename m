Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61C50E39A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbiDYOvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiDYOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:51:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39FE0C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FD56B8185E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DADC385A4;
        Mon, 25 Apr 2022 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650898083;
        bh=SAN7WwrgtUPViCdr3PCmoQam3W0Ucu5f9PJ6opty1hI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hmBTjMirsCxtGBA3PGdIBg6q4BOUfD10/bJyrssZ1CfVpUumYRgQaeFSgSdWHbLdB
         p0X2h4nDUBXahClezIPnIGadNFr5ssTG42EweOjl6J0fkcpKETxq0aWEJJLBwDf2JC
         dY9MlogRFtpeG5wLdy5Qko+ICEzZMV4StzQ7B26dM8dIkAYSg1MtuK9GCxER3/XvK/
         Vfno0OHlrwutTC+6F9EP1/ZYs88RFWk4K1W37S2u0pbkxEFD9OkZIDf8bSliFGHyK2
         LQE68ip525FnMQL9p49bfjWRB48KeWUloeRQPerKZJY+OoKjHrbDweyf7xFQ6IBePN
         CG25FYKLk/mSQ==
From:   Mark Brown <broonie@kernel.org>
To:     jtp.park@samsung.com
Cc:     jeongtae.park@gmail.com, dp@opensource.wolfsonmicro.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220425114613.15934-1-jtp.park@samsung.com>
References: <CGME20220425114955epcas2p331be3ef61616c06974e3e9c6448e6394@epcas2p3.samsung.com> <20220425114613.15934-1-jtp.park@samsung.com>
Subject: Re: [PATCH] regmap: cache: set max_register with reg_stride
Message-Id: <165089808170.183945.10265494062208936278.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 15:48:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 20:46:11 +0900, Jeongtae Park wrote:
> Current logic does not consider multi-stride cases,
> the max_register have to calculate with reg_stride
> because it is a kind of address range.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: cache: set max_register with reg_stride
      commit: d640947562cea6158df13fe021b0e117865ba8b3

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
