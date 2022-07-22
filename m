Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC057E810
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiGVULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141129FE0D;
        Fri, 22 Jul 2022 13:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56C761EFE;
        Fri, 22 Jul 2022 20:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E3CC341C6;
        Fri, 22 Jul 2022 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520678;
        bh=cmm3CdfEPD3Si/hx8bqyBlplBSOo4abTd55makU8OHk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sTsQfiX9gwXeEARaMZdIqAOwQXe7WCvb4t0eXU8SO1R2Xf1cHwicmRr5kIPOyNVKH
         z9A7kVYJPN3IHmuvTGZDzJ1BB7vZEQDh4/EJGddgwer4EjhSa0lXT3urNLhCl4sbQJ
         z83pjWjQsMiAVvJv0YAUYdEEt2jdnHfyPx+mfmMRR4Vg224g1WLLIM1wiCkx94seoV
         c+N9+7fhMqkB7MCAPTAUufTF55am20Aa8KL0+RfIP5uiZIK9WPoqcAmZEVSjEOwvDs
         hBcMp7/AUlgcWeo18iEHMAMBj4a77zdZPqIZsA/7g0NIhlaNPPNVd+uQ9jUUhWceFi
         B52fRzpOarp/A==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org
In-Reply-To: <20220722190910.76865-1-krzysztof.kozlowski@linaro.org>
References: <20220722190910.76865-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: correct example indentation
Message-Id: <165852067657.1177199.4108095906094515594.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 21:11:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d952f
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 21:09:10 +0200, Krzysztof Kozlowski wrote:
> Example DTS mixed two with four-space indentation.  Preferred is four
> spaces, for readability.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: spi-controller: correct example indentation
      commit: b54f2401a17b829a402904d759b288e9bdc81df8

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
