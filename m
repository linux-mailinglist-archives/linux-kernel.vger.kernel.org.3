Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5314BA5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiBQQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:23:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbiBQQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32225BD4D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:22:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C2A860F2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B331C340E9;
        Thu, 17 Feb 2022 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114962;
        bh=xfdhzSsjj/DTtlqONlbnm01z3Tz7AvHFA5SCuYuWvYw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QQbOk1qQ0tF9tKv+D3HjuPPNRu4RHLbTJC7w+LPZF0izCZdeU/QQyMvLakArAHRmT
         hBgfF4BLtjqnW8AW0vvJJSfwca1xrlxXZnYsoSbxebt757v3EeP9q5ATonCPeK4oGC
         s/2gIVZ5sEn+Osz6nXzCXDOOImTG5CfXrzPT5a//WIXQ4hi/03R7q34z1tLNpghaat
         xwMOynTJ8mXbd91z3Hi4fkFLLRuK/I0ghHPWJfn+K+Xd0iqm01DzAumLIRdeMlBCih
         uWkeFGV/VQ4cbZANR+1WxmPq9VWSKtxk52/EZ7g5QdpI224njNlodzh1eepFIYAOHL
         LRaUv/YMaiA5g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
References: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
Subject: Re: [PATCH v3] regmap-irq: Update interrupt clear register for proper reset
Message-Id: <164511496093.1843761.5184860429642885960.b4-ty@kernel.org>
Date:   Thu, 17 Feb 2022 16:22:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 14:20:07 +0530, Prasad Kumpatla wrote:
> With the existing logic where clear_ack is true (HW doesn’t support
> auto clear for ICR), interrupt clear register reset is not handled
> properly. Due to this only the first interrupts get processed properly
> and further interrupts are blocked due to not resetting interrupt
> clear register.
> 
> Example for issue case where Invert_ack is false and clear_ack is true:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-linus

Thanks!

[1/1] regmap-irq: Update interrupt clear register for proper reset
      commit: d04ad245d67a3991dfea5e108e4c452c2ab39bac

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
