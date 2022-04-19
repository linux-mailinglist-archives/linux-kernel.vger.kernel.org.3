Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB5507CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358317AbiDSWsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358306AbiDSWsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD231CFE9;
        Tue, 19 Apr 2022 15:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796F2617F2;
        Tue, 19 Apr 2022 22:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0D5C385A8;
        Tue, 19 Apr 2022 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408345;
        bh=w1oz4vsB+DixJWlyEpiGA6nXN8ZnvlUZM1l0l0XJ120=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E7JLW6t3eCFa5HOzFVkW1w9IVFCeABhqWwhjhPV1VRf97lLgr49dxDiaql0AgXa8W
         eOUMN3mZElXxXk8+wyhvvt532OKlw5dZwAUa2si78mtpfA5k8lVk1M7fqVOARGBpOz
         JWGPogpFTajHTSjXhE+9KNkyGAN0n5njfr3rMUDHGraZI9JCZ84yvzR0WOWpksx/CB
         T7x2MHRSk2/D7VFfXm1QeQf4bU7F8eyXo91zrS2L36bvmzqOe+EbkpQkt0BiYWUZCQ
         YNgskPfIQP9KiIx3COLyggVwo/1CF+25Aw8gmCh8DJNqHU3qPSdzXQrXbIUZNMDM6C
         JzIzQ0zjkKBew==
From:   Mark Brown <broonie@kernel.org>
To:     lhjeff911@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     wells.lu@sunplus.com, nathan@kernel.org, trix@redhat.com,
        lh.kuo@sunplus.com
In-Reply-To: <f9991d6064d892d22ac7c2dfabe16309e9d03888.1650010304.git.lhjeff911@gmail.com>
References: <f9991d6064d892d22ac7c2dfabe16309e9d03888.1650010304.git.lhjeff911@gmail.com>
Subject: Re: [PATCH] spi: remove spin_lock_irq and variable in the irq procress
Message-Id: <165040834422.1910395.12598803243774889664.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:44 +0100
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

On Fri, 15 Apr 2022 16:12:04 +0800, Li-hao Kuo wrote:
> remove spin_lock_irq spin_unlock_irq and variable in the irq funciton
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: remove spin_lock_irq and variable in the irq procress
      commit: c81085840e03dd421532e16b22a8cde95de8ea41

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
