Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72E50B863
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447944AbiDVN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiDVN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832C583A0;
        Fri, 22 Apr 2022 06:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D7C620A9;
        Fri, 22 Apr 2022 13:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B7BC385A0;
        Fri, 22 Apr 2022 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650633827;
        bh=0wP0O47cfWb7KPvm1ysuIetJ74QEy9EwsCeai68tPXg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T+v+4H4mDS8vF4/C8h/544QCxf3S1n2ayJsHufZmPEWWfHpKc2qI2/sQs04VsTu6d
         U7OKVQw2rwyUlKNG4dbb3vbUG7LEAplGB6kGGPm7V0o4LWByWGd6nf1T2pr1emPCzS
         +kVDWQeYO+Vk57etpOrAvsKpn0RhkxkIgnO7sStJR18MuQlqjlFW3920LlCMx/Itz/
         MPQKajvRR85mBofGZAoO7NOU9Kp0LyHGRpm58MgqBFPSQefyUuTnGHcfdiR4s+DyFf
         odDRM7XztGXiqGmJqCu/nggPAkc9r95SCd/YKxG5zl6wjOaSOeAOek6hSzx7J23pAV
         S34Xep0I1BNUQ==
From:   Mark Brown <broonie@kernel.org>
To:     u0084500@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, lgirdwood@gmail.com, alice_chen@richtek.com
In-Reply-To: <1650610255-6180-1-git-send-email-u0084500@gmail.com>
References: <1650610255-6180-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: Revise the rt5190a buck/ldo description
Message-Id: <165063382544.419666.7006851480891588487.b4-ty@kernel.org>
Date:   Fri, 22 Apr 2022 14:23:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 14:50:55 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Revise the rt5190a bucks and ldo property description.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Revise the rt5190a buck/ldo description
      commit: dfd2b37edf7ef469574ef7f36e3a1905ac9ead62

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
