Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1C53ECFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiFFR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFFR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46D12E83E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42E161195
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60376C3411D;
        Mon,  6 Jun 2022 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654536503;
        bh=TAjXN5t1kl1liQB0EA7xPPA/gWHdtE8TWEe0yeztTOg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jF+sKnPYnKtZSHgrxMEenDirjCqzYU20WudnWr1FPgHTaopsMhiw/5pSWbdS5jMob
         cGu5NL3JvjoejhAInPxf1ibQ6hjCMHTR0P9woFy00GbeeggHPkyxHbcSR9LcFHvN//
         90f1mShydmLFuUvrOWq5UzZ1DlZfiHWQlchLNYk9AiwtEE80dq/bP2mvZgg1dLi4SE
         Q0dCX0Qg8SUAZUOKKpmef9HvUfW8AZ9FciJPd078t9B2ImfZxXr9kJNPbqWGECHjW4
         sJlgfBkKVzRLFNfHuoKUm165MSPBZpWxsM2y9thxcHAPw0IZFe9ClBCvYvQ4VE88JT
         FvfcSsZ5okrww==
From:   Mark Brown <broonie@kernel.org>
To:     u0084500@gmail.com
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        cy_huang@richtek.com
In-Reply-To: <1654148646-12182-1-git-send-email-u0084500@gmail.com>
References: <1654148646-12182-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] regulator: rt5190a: check if init_data is NULL, bypass rt5190a_of_parse_cb
Message-Id: <165453650212.2545008.1594929544989513438.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 18:28:22 +0100
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

On Thu, 2 Jun 2022 13:44:06 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> If the node for the match name cannot be found, 'of_regulator_match' will
> returns init_data as NULL for this regulator.
> 
> Add the check for the init_data. If it's NULL, make 'rt5190a_of_parse_cb'
> function directly return.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5190a: check if init_data is NULL, bypass rt5190a_of_parse_cb
      commit: 5f7202d827b8d39146b27c2f813849b1ad437beb

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
