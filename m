Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61353FBD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiFGKqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiFGKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2DBED7A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9BF6155A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429D9C34119;
        Tue,  7 Jun 2022 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598747;
        bh=7KeROakQhh0RozS317QXHC+LfNUD+I20gakesbMfS+4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OASkSWPBwmPdUP8MgbOJ5BFcCe2vA45UG1zIKgvn93P58gfD34zijkQm+mmSX2Pf9
         DC+e01U7scfAaEU4Wlk4GV1nAUyaCJwIuVtkAbFh4qkCT0NuqDb7VBWK8a1rMRp/25
         Dt7E71WfKSe1Whgik5G/2KEf7BxkdsXKPHwWTE0FxFfMpBiik+dWZW2Lg9nlzD9+U5
         cJQQQVgXlT6Zd9He+1Cut9FRuGD0aGTVicwhYtB1ZZnHC2kgoA/yByiiHvlnaN8tg3
         M0Vgqy+X5wFcsKdurOZu3Q5iZqZh3ewULDwJitzaY4yY1RqFQkhOk3LNK4Djz9Phxz
         pYCPbVaW2FLIg==
From:   Mark Brown <broonie@kernel.org>
To:     linmq006@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220603083417.9011-1-linmq006@gmail.com>
References: <20220603083417.9011-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
Message-Id: <165459874498.301808.15369617374937965221.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:44 +0100
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

On Fri, 3 Jun 2022 12:34:15 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
      commit: 7472eb8d7dd12b6b9b1a4f4527719cc9c7f5965f

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
