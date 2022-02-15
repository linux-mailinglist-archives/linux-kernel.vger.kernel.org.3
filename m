Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617E4B6CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiBOMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:55:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiBOMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:55:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E0443E3;
        Tue, 15 Feb 2022 04:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC9ADCE1F1B;
        Tue, 15 Feb 2022 12:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C0C340F2;
        Tue, 15 Feb 2022 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644929705;
        bh=p1tJVXNyyLVvsyyu/uQ3N9eU1Jya4h24+Tsf3iiMlAQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ms8Zgq+/dXjmfQCkUbxTAtEKx/ileHFkTsIXxFSmde9KNDBXk/KBRJvtbG1TPgsuf
         E1cUngzylxKYVMy+Toj/hUXgfQJh+eaeQsv0MBSZNXLanPHtIJLbO7WYkXw2sqcSCa
         7OMJ1ua1dpnwoVbsFcwzFbIzrKC04EW8k2jerH6C9D7Aw7Hut1rDmonUhJESxRHb2f
         8j79HT6Mr3hcEw3RYYyVPSj2oSjcyUU3qyz0mi+UihB4Fdx1zCY3Ov2xyo8C0C08A7
         nXB2SSFOTjmKjspcSjEvLxsUyDp2q0bYiVaSy+hWgOSSUz5JZlQRugtIVKJAHVO9ei
         IuTpq8k7TyDFw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li-hao Kuo <lhjeff911@gmail.com>
Cc:     lh.kuo@sunplus.com, trix@redhat.com, nathan@kernel.org,
        wells.lu@sunplus.com
In-Reply-To: <7d91e6ce29f9a8df2c53a47b4b977664020e237a.1644805060.git.lhjeff911@gmail.com>
References: <7d91e6ce29f9a8df2c53a47b4b977664020e237a.1644805060.git.lhjeff911@gmail.com>
Subject: Re: [PATCH] spi: Fix warning for Clang build and simplify code
Message-Id: <164492970350.14011.3679967978147631328.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 12:55:03 +0000
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

On Mon, 14 Feb 2022 10:20:11 +0800, Li-hao Kuo wrote:
> Clang build fails with
> spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
>   uninitialized whenever switch default is taken
>         default:
> 
> simplify code
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix warning for Clang build and simplify code
      commit: 5790597d7113faabb1714d3d1efa268e36eb4811

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
