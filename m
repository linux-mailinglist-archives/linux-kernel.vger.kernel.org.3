Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3451AFD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357905AbiEDU6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiEDU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:58:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12328515AD;
        Wed,  4 May 2022 13:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5DACB82988;
        Wed,  4 May 2022 20:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09C8C385A5;
        Wed,  4 May 2022 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651697693;
        bh=iA5vkbIA9NTfenOG2m2/vpIGFQLXt9XVSFrGul7+NgI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QzjTRmMLh9jv8SZCbzxSgPezaKMtprLp22u3Hq1AbYlF/cRxSdYeyG5TX6gIEZir/
         jVZoqB4db39gbYZPUAaKOR2oB95eElBP9TxLQSns0Q8+pAwx+uO/to8MvjYaVEp1Wf
         g6SyOQM31v0iR7NoZBao5GJQNu1w4CkZoirb6YHZQWW0bHImIjQRs5q5pOxJZraf54
         akKEK7YagoBToxv3YjwBiSJq75EaI1rcnlpdR8dcCFbOBrJLs5qwg/dBoWqq07ueRu
         50YHU6IhIbBIjt+3bu+KSGjic89FHXJuuwrKkFXbFYTYpIRK0kgCtEoobRMrU0HXPO
         3KMFh04Ed13yg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, zev@bewilderbeest.net
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
In-Reply-To: <20220504065252.6955-1-zev@bewilderbeest.net>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
Subject: Re: (subset) [PATCH 1/6] dt-bindings: regulator: Add regulator-external-output property
Message-Id: <165169769164.1749555.12170259506910526602.b4-ty@kernel.org>
Date:   Wed, 04 May 2022 21:54:51 +0100
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

On Tue, 3 May 2022 23:52:47 -0700, Zev Weiss wrote:
> Some regulators do not provide power to anything within the system
> described by a device tree, and simply supply an external output.  The
> regulator-external-output property can now be used to mark such
> regulators.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/6] regulator: core: Add error flags to sysfs attributes
      commit: 0f2d636e7d1fd76f704dd3ea5089ce29a8aee049

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
