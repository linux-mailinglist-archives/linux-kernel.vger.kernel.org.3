Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1259152B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiHLSAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiHLSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:00:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539C1E4;
        Fri, 12 Aug 2022 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDD58B8233E;
        Fri, 12 Aug 2022 18:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A00C433D6;
        Fri, 12 Aug 2022 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660327209;
        bh=qlpox5oTG4mGqf0Z5CixjCw+6OtL2a4Mfnk09AY4MdQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DjM7h2Ej+Y3LMuAZVTKSAZfTFyxK5YcunEXcMSR1Aiqe9vM9v6zHd3RHQY16bqhiL
         tgTIIujsgIWrd9Ml9S++a0ucfaOPkuq2JyuoHF949zbd0OFsegJUCz9gSPbV3DeXLe
         ZrPYIPF2+pvvrmyWep/LrQgwJ1aD82WLyAx2ZRDBtXxNMXy73+tVur9Zu6ZyToeOxX
         dyBZUbIjoI3Im8H30B7Pg7qbAAz3PSYnULV5xSe7keieyDs9dS26qQjQDpZ4gr3Gqj
         rZUMcEImmxmiF4aXHV+k0AtNbk2JXuTa6QH10p1qNZUf4XaW8nnW04qy8pVleOSbfw
         O6NIMnS+fzMcA==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20220811134445.678446-1-narmstrong@baylibre.com>
References: <20220811134445.678446-1-narmstrong@baylibre.com>
Subject: Re: [PATCH] spi: meson-spicc: add local pow2 clock ops to preserve rate between messages
Message-Id: <166032720712.92213.8055426385524956373.b4-ty@kernel.org>
Date:   Fri, 12 Aug 2022 19:00:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 15:44:45 +0200, Neil Armstrong wrote:
> At the end of a message, the HW gets a reset in meson_spicc_unprepare_transfer(),
> this resets the SPICC_CONREG register and notably the value set by the
> Common Clock Framework.
> 
> This is problematic because:
> - the register value CCF can be different from the corresponding CCF cached rate
> - CCF is allowed to change the clock rate whenever the HW state
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: add local pow2 clock ops to preserve rate between messages
      commit: 09992025dacd258c823f50e82db09d7ef06cdac4

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
