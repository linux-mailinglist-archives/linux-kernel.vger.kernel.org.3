Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406105765D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiGORWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiGORWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66F84EC9;
        Fri, 15 Jul 2022 10:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394556225E;
        Fri, 15 Jul 2022 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F6C34115;
        Fri, 15 Jul 2022 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657905726;
        bh=zhKFGDAKzjIcdaKCKOjey1iz1DIJM+vZjFXRFpNiVa0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rFmPJuP9Z+UG9D6jPNimAhPrSVZLAU88g1c2UJrPhNhk55G/jNf37HEZFCuHrCGrw
         SQ+dMlDeNQtQRIZ/9dhvPUgRNClxsg8iVlLR8c19K45YpJkHNLO4qrO9TVdmDXXh2P
         YcTUyWJnBzN8iHZIOHja5PmogyG/YQ54FgiTnipDOPvDBLdN+hpwx3ZjAVRk5yroW9
         2xPkx0oAtqhRipjosoRCjWno4md/Sj52bM638vNBfoOA6aBT/UuSLHSHpgqBc/PmGx
         xZ3X5SU9yD2LKQJWvJOI1YZgSUdh/gKpro7M94X0xH/tZ7NSN/dnSikHA0FMx3VguN
         vebCAIu42KI3A==
From:   Mark Brown <broonie@kernel.org>
To:     sbinding@opensource.cirrus.com, lenb@kernel.org,
        lgirdwood@gmail.com, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220707151037.3901050-1-sbinding@opensource.cirrus.com>
References: <20220707151037.3901050-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v6 0/2] Read _SUB from ACPI to be able to identify firmware
Message-Id: <165790572476.3961283.3237743064047303492.b4-ty@kernel.org>
Date:   Fri, 15 Jul 2022 18:22:04 +0100
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

On Thu, 7 Jul 2022 16:10:35 +0100, Stefan Binding wrote:
> CS35L41 has a DSP which is able to run firmware, as well as a tuning file.
> Different systems may want to use different firmwares and tuning files, and
> some firmwares/tunings may not be compatible with other systems.
> To allow a system to select the correct fimware/tuning, we can read an _SUB
> from the ACPI. This _SUB can then be used to uniquely identify the system
> in the firmware/tuning file name.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ACPI: utils: Add api to read _SUB from ACPI
      commit: 93064e15c8a3a8394319a11b8037666e4b7d653d
[2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to identify firmware
      commit: c1ad138822a1be95a7a7b122521c2415583a0c26

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
