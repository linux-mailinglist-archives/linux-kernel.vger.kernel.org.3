Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706E570A68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiGKTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiGKTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B994F6A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C997361560
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79960C341C8;
        Mon, 11 Jul 2022 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657566663;
        bh=+o4gUzo5jFwMZNn+jdneTId4bqHU+8g2vTdBk67T/cI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TNSwysxYP2mQ1guyPtnhp2SZxh5XeX/uLwlQqzyklAUxKWCZvnKbVP9ju4kAuXl6f
         fqU5YG5couLWOeBLyQQbaSWoFBtFJwg3vwfFv30W8joZaAL8KAza/tnCtrzGC2b1wL
         XPYD3poR/tsX6PJkCpEvJzb1cs02RG+2vj7KIzwBA3Qm40TXuF6CjIbfUb24DVGHyA
         aw1y2IwXVosn0HH0B8A0t3Mgh575ReHrtRRtacMZl3BTiZn25Z9c7rGhXcHc5KY+k/
         YXruI9ZXhqLC1fclvVto6FA6CCfy/Rh2NrwHCxc74ARVzQFvR1sQ7PgSAeuqRSz6eL
         pHct2Xl2JJHbA==
From:   Mark Brown <broonie@kernel.org>
To:     naresh.solanki@9elements.com, linux-kernel@vger.kernel.org
Cc:     Naresh.Solanki@9elements.com
In-Reply-To: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
Subject: Re: [PATCH v4 0/4] regulator: output-supply DT support
Message-Id: <165756666221.1166849.17586001373716391631.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 20:11:02 +0100
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

On Thu, 7 Jul 2022 10:18:22 +0200, Naresh Solanki wrote:
> v4:
>  - Add 9elements as vendor.
>  - Update dt binding.
> 
> Add devicetree support of the output-supply driver.
> The supply names for this driver is provided through DT
> regulator-names & regulator handle can be acquired.
> Driver events can be received from sysfs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] dt-bindings: vendor-prefixes: add 9elements
      commit: bd9b7998b4816b3d604253a774d83b6736474283
[2/4] dt-bindings: regulator: add bindings for output-supply
      commit: df9c96b69a1d2629519a5d8a9dc4b39f775ebe2d
[3/4] regulator: output-supply: Add devicetree support
      commit: 34e5700e1e64077ede50eb60d04e7604dc4f508a
[4/4] regulator: output-supply: Add Notification support
      commit: 490a15324ce6d55b950fce0eb9e95c793fac0dff

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
