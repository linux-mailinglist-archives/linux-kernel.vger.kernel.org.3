Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C795AD6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbiIEPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiIEPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2541A832
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C77A761347
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3695CC433D6;
        Mon,  5 Sep 2022 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662393011;
        bh=qLG+gfl6NXOiN1sJRiTTTnudslb/lpCs8P99I2VG72E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UAnRCd0Ouphg1HatAZN2aLqLIxt84vYh1H5kpFF30njCC69n22BclB7oaliWbWB8V
         GNdNXUOvCrDPFRUk8nUie3N14Eaa0KpdHbgUiGlgdvGYkyEkXXn0z+F8gXBo1PlDUH
         bJhFN+uTJ8Zn+pUYEoiaXcKIyiQX9L69w/KMVDo+g2ej2nlsNLMYNby9Op9YRMmaRJ
         0KSzH14F2FFXRRS1J/P82ungI+y57iw0tlI9of6axXGyL2HITafdgD/oXHnuO2S230
         X38INZF+INO73jSxbEcdTRY0dr/KwBH1J33BxvZsFItM0d8nVisc37Pzg1M/6o6n5l
         bVb7KoF4bJ1Vg==
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org
Cc:     andy@kernel.org, willy@infradead.org, hdegoede@redhat.com,
        andy.shevchenko@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        kai.vehmanen@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
        yung-chuan.liao@linux.intel.com, intel-poland@eclists.intel.com,
        ranjani.sridharan@linux.intel.com, peter.ujfalusi@linux.intel.com,
        lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220904102840.862395-1-cezary.rojewski@intel.com>
References: <20220904102840.862395-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH v6 0/2] lib/string_helpers: Introduce parse_int_array_user()
Message-Id: <166239300589.745322.7930709481816524867.b4-ty@kernel.org>
Date:   Mon, 05 Sep 2022 16:50:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sep 2022 12:28:38 +0200, Cezary Rojewski wrote:
> Continuation of recent upstream discussion [1] regarding user string
> tokenization.
> 
> First, parse_int_array_user() is introduced to allow for splitting
> specified user string into a sequence of integers. Makes use of
> get_options() internally so the parsing logic is not duplicated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] lib/string_helpers: Introduce parse_int_array_user()
      commit: d2a411f810a0db055f02cc18e5cfa833bb2c9ccc
[2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
      commit: b9163e9b5f14d690752010ee843b2d788c3536f1

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
