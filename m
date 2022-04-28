Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B63513A49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350334AbiD1QuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiD1QuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CF4AE2E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFDDFB82EDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0496CC385AA;
        Thu, 28 Apr 2022 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651164421;
        bh=+RKLk9K6/GT4CyUUwj9j7R0islPDkWCMgjT+jFXMSDQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P7mbsYTwr8FAZSziLNTBYcHxEL0bwO1N5uSk0kLF0pB7j//Nmqo61SzGkoXAOpv7P
         Qh2pKMSZsG/UkD2/AHBby+wT2L/6sosdsGaSFrNKWhHDtX2h+1ktHYky6Kkz1FPHzW
         PNkC1ik45wdhBq5BuwUf0wOwaaHZOw6YeW0vC7LiZc+WYqJwg2B3vsqvmCEu+hIoo4
         AzoHCn8aZ94fzIy7YwaG41y02Id0iq8smbd23r57+HmqkP2iAg92xACXm/J+YQnobu
         bDx7X8du13fAzjn4f/KxmItkVb/i+pjaY8XURDboQLCNPNrsok6IJaLSF0C7MdgMIm
         z+atlvl9BKwVQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, nick83ola@gmail.com, lgirdwood@gmail.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220427212916.40145-1-nick83ola@gmail.com>
References: <20220427212916.40145-1-nick83ola@gmail.com>
Subject: Re: [PATCH] ASoC: wm8960: Add ACPI support
Message-Id: <165116441974.4067540.12774509625457137042.b4-ty@kernel.org>
Date:   Thu, 28 Apr 2022 17:46:59 +0100
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

On Wed, 27 Apr 2022 22:29:16 +0100, Nicola Lunghi wrote:
> HID made of either Wolfson/CirrusLogic PCI ID + 8960 identifier
> 
> This helps enumerate the Waveshare WM8960 WM8960 Hi-Fi Sound
> Card HAT on the Up2 platform.
> 
> The scripts at https://github.com/thesofproject/acpi-scripts
> can be used to add the ACPI initrd overlay.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Add ACPI support
      commit: 7e0bdbae446ff8a752484f6bcbcd7157e7484158

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
