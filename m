Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1D501A18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiDNRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiDNRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A8DE0BE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A28B826FF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A2BC385A1;
        Thu, 14 Apr 2022 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649957871;
        bh=6dOv01az04T/z1BTO+IT24inw8nsBFbY540g2cn/Fkk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LG79QvOujphjFiE7awNBuY5vBsXnGOqY8CuaLQGHgNFC8sxXWS4augbLnrwQSiGXN
         sWfBXgNvPE4fK0z14guRsmx5qUgzswleIXrh2bwMK+VH8O03uGVO/2qG0AJlrq2x6I
         DDnlf/cVe1/hlyQSIPoXvQBD5zTzZ3yaE2bDOYue5Vlt56TvOD1ACXIzALl72ZkGm4
         Frwq69xH+JjXB+VhgABOdoa1znAHoIa4ksH6IOxV6yEYBYMbMzo+aeneB0enNmJYvR
         cVpFnW9zwbDMM4OMuoDK/UrpCY+qmI5GkodTRS7pOeoRYhNwbyYkdiIs0sO3+d1IJq
         RZn+UtyJiau7g==
From:   Mark Brown <broonie@kernel.org>
To:     akihiko.odaki@gmail.com
Cc:     oder_chiou@realtek.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220408041114.6024-1-akihiko.odaki@gmail.com>
References: <20220408041114.6024-1-akihiko.odaki@gmail.com>
Subject: Re: [PATCH] ASoC: soc-card: Create jack kcontrol without pins
Message-Id: <164995786974.2810970.8441162989456904692.b4-ty@kernel.org>
Date:   Thu, 14 Apr 2022 18:37:49 +0100
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

On Fri, 8 Apr 2022 13:11:14 +0900, Akihiko Odaki wrote:
> snd_soc_card_jack_new() allowed to create jack kcontrol without pins,
> but did not create kcontrols. The jack would not have kcontrols if pins
> were not going to be added.
> 
> This renames the old snd_soc_card_jack_new() to
> snd_soc_card_jack_new_pins() for use when pins are provided or will be
> added later. The new snd_soc_card_jack_new() appropriately creates a
> jack for use without pins and adds a kcontrol.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-card: Create jack kcontrol without pins
      commit: 19aed2d6cdb72a7c92909832b9480d9cadebeef9

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
