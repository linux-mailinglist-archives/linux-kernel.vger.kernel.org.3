Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411B4BE8AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379080AbiBUPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:25:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379062AbiBUPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:24:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D431EAC7;
        Mon, 21 Feb 2022 07:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F7A611F5;
        Mon, 21 Feb 2022 15:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85113C340F5;
        Mon, 21 Feb 2022 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457074;
        bh=/BtsoU7g2MfbZ+8V1diNwCXGmkpDAVaYj4S5Gx1pPSY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aMQms1L+Qv3zAUoQAyx+8UkJ0/Kc+bM7qzBZx5w+gWrXKDwbNqcRhe0BYVOtEZfob
         Kc8iwbybnM2TTNr1izzQ+cYrh5a2d9K0o+9XN4Eohda88oGImRHchBb04FjDjcHwLJ
         NMZ0O/LTpGfG3yuY9sztA5WBsS4SgINsVSwY2QBWsCMlgcP8BqemnzwbMv+2ElW4Ld
         2nwugZUtGkpmo0mjcw4swkf1P1dQjA9JWUGfsiaS5yT9bHT7mGDNEwdE3P/Ur6+oGu
         DRgwqNu66s8eWNw8nixaxeZ4LiK4gMC+1u9EGNSuMTyoTimLqFTbGgS/CbjGypjfHE
         enKWL9xcLGTAQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        linux-spi@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
In-Reply-To: <20220221020233.1925154-1-chi.minghao@zte.com.cn>
References: <20220221020233.1925154-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] drivers/spi: Use of_device_get_match_data()
Message-Id: <164545707326.739789.1243249169632517581.b4-ty@kernel.org>
Date:   Mon, 21 Feb 2022 15:24:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 02:02:33 +0000, cgel.zte@gmail.com wrote:
> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers/spi: Use of_device_get_match_data()
      commit: c5a3106aa4923bec979c2a76667a493cb5d134fd

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
