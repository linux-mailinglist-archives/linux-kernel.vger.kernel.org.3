Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245657BCB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiGTRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiGTRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:32:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77B5B79B;
        Wed, 20 Jul 2022 10:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8164FB81F5D;
        Wed, 20 Jul 2022 17:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3495C3411E;
        Wed, 20 Jul 2022 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658338321;
        bh=QW5QDhun33Dcra4wuqwEq1g0A/ITgvp5MONc92eOG28=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FU0sbqWi8aIMGs0VhG6ac7lMFmZcxOyFk/uM4w+tzxdQa5XwbbsYG3koCh6Yp0bRu
         t/FtjLn9hBtzcDNaOviI+3dPSBr8GPpnnZ2GTboynTOQVOkoDPtJUR0BnXpSL2BZfx
         BCmG0LdpBWzld4IMb6KjR44+R+ZeFQCPKekBXaPdDokcZHDjLOdTyN1rySWlSRVvo7
         6XUI/cTiLjDRLnW7DMs5/BXzDvYJECgnZjOjTSOfIVumtIXCbOPVPtcsj2uLH6ojZt
         m2Hl3W6c0qQGtHigbzIQEqvSYCvUTLzhsUdvwI/djh7osoI7fBdMZjhWi+UWIegi/V
         FU7Flb1gVvZzA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220719215010.1875363-1-robh@kernel.org>
References: <20220719215010.1875363-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: Add missing type for 'regulator-microvolt-offset'
Message-Id: <165833831967.356027.7079398627546745517.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 18:31:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:50:09 -0600, Rob Herring wrote:
> 'regulator-microvolt-offset' is missing a type definition. The type should
> be 'uint32'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Add missing type for 'regulator-microvolt-offset'
      commit: 4c7da3741804fc5631d94f4df24382ce6e88f02c

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
