Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522204F43FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386694AbiDEPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbiDEJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C8DB48A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC8DEB81CC0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A514C385A3;
        Tue,  5 Apr 2022 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151085;
        bh=sths/yLUf6l8l/Q/YW2CkxyCzaOS6Ye289f/mAv1VcA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GYDH1QLby77EqcvwL6yOSXoxj43pdwRO8odNEidkRfhT69oDRpMRLHq7FCg+YI+pM
         Iwvsfi7rXPaSW+dYLBsVNoAdvrIzAo0Fp059rE64wF2ed79KXzwRldo8J0jYsIe7Zj
         VculLap4vxSSG+gxBPiWV9BECNrhQAShI5MIVLCyPnnPU/E3nsCUS2+6c5ud/tcspn
         v0EFlfGIC2ZkO6YQ4c12ilWm6R0qmKoVdHBwbsCybfiFUgLWiDBe6rbmMSOmg/V7Pc
         XTnRxIshg1Qwmmks2bgKjm/crz8HKEd2VRDOWsqozvBiIW1W6piYA3rnk2hUlUS1Ea
         jtb24YftzlIYA==
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, steve@sk2.org,
        nuno.sa@analog.com
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220325164828.1209201-1-steve@sk2.org>
References: <20220325164828.1209201-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: ada*, ssm*: use simple i2c probe function
Message-Id: <164915108416.276574.1317659435834583998.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:24 +0100
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

On Fri, 25 Mar 2022 17:48:28 +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ada*, ssm*: use simple i2c probe function
      commit: b79bd63a66894ca6c75fb9827dc8f3f7fc1233e2

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
