Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46953ECFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiFFR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFFR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9178717F81D;
        Mon,  6 Jun 2022 10:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F5CFB81ACB;
        Mon,  6 Jun 2022 17:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AA8C385A9;
        Mon,  6 Jun 2022 17:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654536501;
        bh=pusrDuz3WUyMpSksB1PRPjrsVClzJ3+UWr9Zr58Vto0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=n8mQuHB2iketKlSgDR7HMWIiMRH14+ifSY5EffTO5vK2gOJcSRWQg5BuKRHQqhP/L
         jtEF9ba67nfGdhUG7KRO/DdUu0O4dgFHO38s/3Mi0AxiPhr/CbT51HWIbuDnCYLJ2G
         /WfiDnjPsL+b0ZH5bIkqyPOeJ2tBDe9WBgOqSFDK7bSUhAuHBrBNf2DFhlLLVZkTEp
         67zTemCNaDWbh6hhc2kaKYujEfvYKe8Nh7PK/L8qiA6xkVciRHvZ7fOG9UNNQCl/ZD
         R+WpS5f5/FGuK8/ZhB1fgqCTDA7rCxN5CHonMOwnF+4O3+a5v+BuWRP/vmB9MZo8g5
         4LBDD00I3PD0w==
From:   Mark Brown <broonie@kernel.org>
To:     robimarko@gmail.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sravanhome@gmail.com
In-Reply-To: <20220604145816.47576-1-robimarko@gmail.com>
References: <20220604145816.47576-1-robimarko@gmail.com>
Subject: Re: [PATCH v2 1/4] regulator: dt-bindings: mps,mp5416: add MP5496 compatible
Message-Id: <165453650020.2545008.16222686601707817374.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 18:28:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 16:58:13 +0200, Robert Marko wrote:
> MP5496 is the updated version of MP5416 with the only difference being
> that now all Buck regulators have the same 0.6-2.1875V range with a 12.5mV
> step.
> 
> Since there is no way to differentiate them other than using compatibles,
> add compatible for the MP5496.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: dt-bindings: mps,mp5416: add MP5496 compatible
      commit: 423156b3d37ba051e72e87a8b4791a2a0ea40592
[2/4] regulator: mp5416: alphabetically sort header includes
      commit: b9dea0184b2641fb3937162a617289b23d52a587
[3/4] regulator: mp5416: use OF match data
      commit: df43c245dd0535f6e2256e0261d43a4dd72b8b28
[4/4] regulator: mp5416: add support for MP5496
      commit: fcdaf74a0abb6a4410b69dd80b525562457daafd

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
