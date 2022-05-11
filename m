Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F3523C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiEKS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbiEKS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972B5B3EA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B6A61DF9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98BFC340EE;
        Wed, 11 May 2022 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652293574;
        bh=2zcrEOajNJTX1aKEEpr6nnYpU7TON9ZpfJ3n/MylgJg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=a7unpZeYzP/ds8xFMoMyQCWp9KEgvoOI6vM9gP04W2g6snpOlN8OtK6LDXdvBLhsH
         bRf7WU/EwIgTstVSakfJgey5HsjgKQw9Q56fW+L7eAjBG58nwBl5qHAxobBG2H31HE
         VBSqULcOAnwgwHOPDeHpgFquo7J9lFmgtxksZmhWPhEghpTS3V6rcvEmC3W/QJUb5B
         8TSzpV64f75V9TgWCF0gL2iJBjBmcXcii8sNU2FPcgqiAT4C9O4oYjC9z+6nTDulNn
         nBhJxlqU3jQ3LWfc6KBWOFNYZqH1CB3vy4rcGNLoedw1PuWHFl7KdvqU9ACnvML7Mj
         ChBYe0jZyCAJg==
From:   Mark Brown <broonie@kernel.org>
To:     linmq006@gmail.com, linux-kernel@vger.kernel.org,
        b38343@freescale.com, lgirdwood@gmail.com
In-Reply-To: <20220511113506.45185-1-linmq006@gmail.com>
References: <20220511113506.45185-1-linmq006@gmail.com>
Subject: Re: [PATCH] regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
Message-Id: <165229357360.325561.18079537190408256583.b4-ty@kernel.org>
Date:   Wed, 11 May 2022 19:26:13 +0100
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

On Wed, 11 May 2022 15:35:05 +0400, Miaoqian Lin wrote:
> of_node_get() returns a node with refcount incremented.
> Calling of_node_put() to drop the reference when not needed anymore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
      commit: afaa7b933ef00a2d3262f4d1252087613fb5c06d

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
