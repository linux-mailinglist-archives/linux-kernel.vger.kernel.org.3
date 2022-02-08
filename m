Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1294AE1C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385722AbiBHTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385707AbiBHTAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69755C0612C3;
        Tue,  8 Feb 2022 11:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 064C7CE1C15;
        Tue,  8 Feb 2022 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E120FC340EF;
        Tue,  8 Feb 2022 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346824;
        bh=0oEq0H6r2djLAksGfJSDTE7q5yoYgycV3Yo21Q05Kss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SW9N2CZ50C5WB00+MOta5o/zk8QettLfBfnCL+Y+XRIcsnW/T+XGGYOj4/poT7TVJ
         I/YOY0DEAPfna+JpUBmZGzP5bZUPjjzfnMqplcBox0CMWjrxr3fuqlFcRe8NBQqNMm
         QK09n9SpQOdrjzMmvtipwp2UPuvE9NFnUKXzIkIj3vExFiwxLy7LO3Ca3tO75a/6e1
         YwPwlvetyn5zBBXCEecoWTx2iur3vJcEOCQ4o42DGVmW3pm0PUAQbI5UR+NlkCpuev
         OYCaQQOszIgo8HNcI6oOc8gy4AvTl/zmmSLPNQUTUVWoIPJqkfK2vSTp+bu9+gIYfE
         CO3xpLhu/r7jA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Li-hao Kuo <lhjeff911@gmail.com>
Cc:     lh.kuo@sunplus.com, wells.lu@sunplus.com
In-Reply-To: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
References: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
Subject: Re: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Message-Id: <164434682261.1135514.9209006322953151639.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:22 +0000
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

On Mon, 7 Feb 2022 09:46:34 +0800, Li-hao Kuo wrote:
> Remove the include path and modify parameters for fix error for bt binding test
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings:spi: Fix test error for sp7021.
      commit: 3b8ab4da3405d07ddfe434f17f9014740b30a19c

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
