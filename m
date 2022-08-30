Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD95A6B89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiH3R7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiH3R7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03BD17A94;
        Tue, 30 Aug 2022 10:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C40AB81C55;
        Tue, 30 Aug 2022 17:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7370C433D6;
        Tue, 30 Aug 2022 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661882349;
        bh=4jVEmahLqpDeaKuJzaBO3pkE5i6P3EDFl9lkCX4/whY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jQEwgSihrAGlTw8f870SkCmjyzHaHO90rVPO0pcOl3Einb+K2wOR8U3VOGHzSElC4
         P570NvCcvxl7hM3elJYkIEAQO+XfhfQhQMuJExch/L39oudGHL4xNdL9DH1jzUvLk6
         3gVF6Lwkedo96w8cwtUSucIZbIPpOVZqzBp0hm7bAoYso4xqemjBSeIxJCV1Pm58ie
         daOjPfOVnusG78328TyvHHnoWOZUBEUFiVpJR7oMOfwBFdpiaadmdxLLZbiz835ynG
         qPcbZMgErgITFFEVJe93kD7Bk0ws26/yw2mhdwzTktZav8nwGU/haLP9OM5xWlTGLt
         sAU8a8F59t5gQ==
From:   Mark Brown <broonie@kernel.org>
To:     sanju.mehta@amd.com, Shreeya Patel <shreeya.patel@collabora.com>
Cc:     alvaro.soliverez@collabora.com, krisman@collabora.com,
        linux-spi@vger.kernel.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220830093607.45484-1-shreeya.patel@collabora.com>
References: <20220830093607.45484-1-shreeya.patel@collabora.com>
Subject: Re: [PATCH] spi: amd: Fix speed selection
Message-Id: <166188234884.1136776.7157896600575366558.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 18:59:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 15:06:07 +0530, Shreeya Patel wrote:
> If the current speed is equal to the requested speed by the device
> then return success.
> This patch fixes a bug introduced by the commit 3fe26121dc3a
> ("spi: amd: Configure device speed") which checks speed_hz instead
> of amd_spi->speed_hz.
> 
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Fix speed selection
      commit: 9477420efc41f60f06413cefa38f5bfd71ba64d8

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
