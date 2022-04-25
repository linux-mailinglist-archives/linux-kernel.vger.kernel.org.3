Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9650E718
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbiDYR2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiDYR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7E4130B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F3461583
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B32C385A7;
        Mon, 25 Apr 2022 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907456;
        bh=ZkbN3DzlqOxrOBbGH0dbaZi13IG8v/ZLFQCNjbMKA/s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Im8LNR1FR73F86Ri3qldYBCSxMU7TmNO7ovTLt9g8H6Qvh1oIdtGjD43Rdgq5UY3E
         n2ryGs+XZdzLgHlLtWuJuBqpSP7fbwabTpxQ98xwT7/Toxmz+21jhK95SAgvYV//IL
         SnX9X4v0iwNHW5SEGmvNjbF2TYi9MRVY3OuG17aUonTJmWEN1TeaNGAKyNslKNB0pE
         J79D6R1P5kknMbVh2V1pmhXLnHk/wzg4aL6njOLs+EzuEc/IN1JP7FQCHL5catje4X
         MbmdkOjYxophO8FYIYQ2wg+qWK5GHboX4jmY5oHJaCr+WpE7V8Q956lK/98bpenOaC
         OVOtuSDdjRNkg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     alsa-devel@alsa-project.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <20220420030439.2575817-1-chi.minghao@zte.com.cn>
References: <20220420030439.2575817-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: img-spdif-out: using pm_runtime_resume_and_get to simplify the code
Message-Id: <165090745525.583823.16752213604992639909.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:15 +0100
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

On Wed, 20 Apr 2022 03:04:39 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-spdif-out: using pm_runtime_resume_and_get to simplify the code
      commit: b1d1b02594d4599f0d3d5558ba9606a69df6381b

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
