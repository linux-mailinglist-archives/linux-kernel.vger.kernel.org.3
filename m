Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B759713B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiHQOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbiHQObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA751117D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B5D614B8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6090C433C1;
        Wed, 17 Aug 2022 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746670;
        bh=m6l9A6JFJVk5sDcAAx0rc+8lNOpVT7N8YCrh37JoVv8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DtbFDIIGd7L1UG7t6nGP6H4PFZCBcHcfopHF1hyidthFZfOVT+HZE5qQLovFc4d4A
         orWknOPkiMWhWoNjCm7v56yNJlfHImR7EnSVCfDYUM0HoF1kAVy7KY25OnbI3pfU3q
         kBtBMXN3EPRlmokjQ9m7rfurj8MzvYIdTN/lJr4sFwQ2C1loQvpIINLz/UHJb9es6G
         KuvWs8lKwlX1JFdvvxFLcuqzyYfhNuoQfH1hVUohPbHiPXRx8ld8Flf46KyHqaC2BP
         bKUZCDHPC9iXR1GVewNBVw1d42ZRIQhRscCgXzDE794jHKZa2ipnIjVA+2t1CGipvH
         b8RnEWAsjxnJA==
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org
Cc:     bard.liao@intel.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de
In-Reply-To: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume issues
Message-Id: <166074666854.210979.4761279701927958076.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:31:08 +0100
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

On Thu, 14 Jul 2022 09:10:39 +0800, Bard Liao wrote:
> we've been stuck with problems in the dual-amplifier configurations where
> one of the two devices seems to become UNATTACHED and never regains sync,
> see https://github.com/thesofproject/linux/issues/3638.
> 
> This is a rather infrequent issue that may happen once or twice per month,
> but still it remains a concern.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] soundwire: add read_ping_status helper definition in manager ops
      commit: 874de459488b8741afc0e9888d39f2e15a962b3d
[2/4] soundwire: intel/cadence: expose PING status in manager ops
      commit: 133547a1ef16cbdadb5c0023e5917924ae326dcc
[3/4] soundwire: add sdw_show_ping_status() helper
      commit: 79fe02cb7547fcc09e83b850cfd32896d7dc6289
[4/4] ASoC: codecs: show PING status on resume failures
      commit: 917df025e1db1286afb6e46914ae3e8b40241568

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
