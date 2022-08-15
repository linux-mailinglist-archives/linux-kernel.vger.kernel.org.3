Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE61593250
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiHOPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHOPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109D17074;
        Mon, 15 Aug 2022 08:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F6E4B80F02;
        Mon, 15 Aug 2022 15:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BECC433C1;
        Mon, 15 Aug 2022 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578297;
        bh=OkFapyn4xOtZLGADcDAUVjgBIurU3qGxIAY1Mkf6qoE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ETeBHPMcFW3ZDtXQq936zJ20nAAFxeqmLmaRBQ78pLjnmCtE+wKyAxpr/vEsbTF32
         U6alnnwfxlxSjV0KG/bUUB+PkFp5Hyjc1sEmQZhTZ+YaEwrcsqJMQwAcI/A+b8j8dN
         CwzmcDtCRPQCzHSdBEqd2FloiDNc6hjuTt3fgCxCYHjAw7ZdEutqYvWFOoxpTzmqTC
         +NV2Szgwgp47qSg477gWDW05sQV0bYufwwxhc7I70kLH6cFPOV1u6AGN346hRU7WTL
         6f57hy60QsKe4PF2JAVwnWRAADqEgrqMGd0QE+t3O0TLVjFnw0/sE/v7A1G3dfgZRB
         wSREOaVjJMj5Q==
From:   Mark Brown <broonie@kernel.org>
To:     venture@google.com, avifishman70@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        Tomer Maimon <tmaimon77@gmail.com>, yuenn@google.com,
        benjaminfair@google.com, tali.perry1@gmail.com, robh+dt@kernel.org,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org
In-Reply-To: <20220722114136.251415-1-tmaimon77@gmail.com>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v2 0/2] spi: npcm-pspi: add Arbel NPCM8XX support
Message-Id: <166057829444.697678.15497743196363589755.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:44:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 14:41:34 +0300, Tomer Maimon wrote:
> This patch set adds Arbel NPCM8XX Peripheral SPI (PSPI) support to PSPI NPCM
> driver.
> 
> This patch set was separated from the full duplex patch.
> https://lore.kernel.org/lkml/YtlES7MX6nJr8l+L@sirena.org.uk/
> 
> Addressed comments from:
>  - Mark Brown : https://www.spinics.net/lists/kernel/msg4447178.html
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
      commit: ac2c55e2260e0ae019119e1b2a52dda138039841
[2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
      commit: 6db8595a3e1996654a130760d363912cdd28706d

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
