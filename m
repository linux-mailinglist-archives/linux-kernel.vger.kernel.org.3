Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8850E715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiDYR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiDYR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE240E71
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BB6DB8191E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CBC385A9;
        Mon, 25 Apr 2022 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907445;
        bh=2uF8MzO9fpXb0VXdWOAk8N460Awjyq9LYp9uzBNQ5Wc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LjUjX8p2Y9SQ0jUKdqZoNGK8IclVXefqAMsH06oYn/RHah4crOJ0p462Sde+0kBCc
         WsXvjAK/2Cs+oW5pVb8HO+NyN+n0ly+f8W3ws4g115t3Cq6FSdyT+IBW4i2J0hr6uy
         F2KfrXoDx8fhSIO2tfS3BMx8sKsOiWA4zwbPhbucjoEJg7M4XhUkZMRP8QKTsfCxTH
         zKmyuDiN76XulsYQoVwGq8Aqn9/KaBI0uLyXAXRJ4t7PV+nNwB4zmK7vHL/f+1hndV
         PN+qq3yAeRstReAjJLgy25yBPOHx8AzL+tMary5o0xgyzStJe63gRvNPjBAjcpFWbi
         0TRKMuPwHFSVA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, steve@sk2.org
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220415160613.148882-1-steve@sk2.org>
References: <20220415160613.148882-1-steve@sk2.org>
Subject: Re: [PATCH v2 0/7] ASoC: remaining i2c_match_id i2c probe changes
Message-Id: <165090744431.583823.7165616164947839079.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:04 +0100
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

On Fri, 15 Apr 2022 18:06:06 +0200, Stephen Kitt wrote:
> This series covers all the remaining changes to migrate
> sound/soc/codecs i2c probes to probe_new, where the const struct
> i2c_client * argument is still used. Instead of relying on the
> parameter passed in, i2c_match_id is used instead.
> 
> With this set of patches, all the sound/soc/codecs i2c probes use the
> new probe definition.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: ak*: use i2c_match_id and simple i2c probe
      commit: e654a1331f68550f4c7c85b13b2bdb3c2502a9af
[2/7] ASoC: alc56*: use i2c_match_id and simple i2c probe
      commit: 9d8f2edd3d7d11c9f1fc978e36219b3178af13bc
[3/7] ASoC: max980*: use i2c_match_id and simple i2c probe
      commit: 4ac8ebb6cc28cbd99e10d7a4772be1c4da5af130
[4/7] ASoC: pcm186x: use i2c_match_id and simple i2c probe
      commit: 3577a8a0ac5b9aaf22ff4fa6a9670cf85351ae50
[5/7] ASoC: tas*: use i2c_match_id and simple i2c probe
      commit: 55116b39e5e1c2d0fd1a77e9f46ce8437623e0e8
[6/7] ASoC: tlv320*: use i2c_match_id and simple i2c probe
      commit: 988e6870c86cce7999f55133197fddfe7e2795d2
[7/7] ASoC: tpa6130: use i2c_match_id and simple i2c probe
      (no commit info)

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
