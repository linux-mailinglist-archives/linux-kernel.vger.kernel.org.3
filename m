Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0252015D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiEIPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiEIPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABAABF64
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF9C760C7A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25F9C385B1;
        Mon,  9 May 2022 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111139;
        bh=b+0bTNxvxsgDQNXw7Vjz5YHZ8VLG91q1lL5GmMMGn2M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s+x9C0GGh4n8hjY6+DdrcoFVtXDfvVE3eSUlgBZRcq6dDybjYiZ9on7NpDX7xH6Av
         47Q4RRrDlU7mayUQX3MbIcHWvO0pp/UgNRlly0ocFP8DU8dxpoEzH5dTh1g9PZ+QBa
         aPBjPJmRwQk8decE0QWsM4HJY5pDPlENEgxuN7Mp760I2QXWdOFOU0jZN7VVEvjcg3
         9ILHZX78SPM5E3TMiCKryWDVJmI/fZhvIF3v0SVeMKmRNhg6IEzwb8pxz+I4ns0+jV
         7i0iTFTqjKQRdOp3pSzV3LurduMJV0VIsYFk+5yf29X9Q8sgJljYJ6B2WIBEUBvrOK
         lP/4KEkI3/QUA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, zealci@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220505021733.54275-1-chi.minghao@zte.com.cn>
References: <20220505021733.54275-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: uniphier: simplify the return expression of uniphier_aio_compr_set_params()
Message-Id: <165211113755.774487.2751485031602325886.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 16:45:37 +0100
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

On Thu, 5 May 2022 02:17:33 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: uniphier: simplify the return expression of uniphier_aio_compr_set_params()
      commit: ef1258a7820d99cc7999cafbd8ea78a24559ff12

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
