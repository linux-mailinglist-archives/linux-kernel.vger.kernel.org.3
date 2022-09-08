Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9385B1D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiIHMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiIHMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:42:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF1D0208
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB975B820E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5C8C433C1;
        Thu,  8 Sep 2022 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662640962;
        bh=Yn1mgLP0Ax3Z1pgIyIL7q6sYoi3PggAgd2wuqHldp7U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jqQVSenWK6/C3xORle4YN6B/NA/NpaqafFS6BuEiIM3HGorIxhnATdniUTBov3ATx
         abbh9DhQX0dL+oi90ew6oHJvOrAJPVR70gIfF3XBUHytziNO3yTQarhiu6ZsINwx0P
         MwuVccBI/5vXv95vF803nOWOhInf2gfT7+4Tk8xoMeYv9MWJG4Ld10wOHXvlWxeHhN
         ZURQq7+F4R3uW59FHAYfr3tPbovpI5rxdk2qRclYAkC9egvnaLzt7SbYTYpH8a0nId
         FOboJR3w8TXshoxipeo5Y+IGzDDuUhNY7+XVdpYg0bcimitj60Ln4HII1HFNzezDG1
         H3Myq+sJ7R+jw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ye xingchen <ye.xingchen@zte.com.cn>, perex@perex.cz,
        ckeepax@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, lgirdwood@gmail.com,
        tiwai@suse.com, alsa-devel@alsa-project.org
In-Reply-To: <20220908010304.342760-1-ye.xingchen@zte.com.cn>
References: <20220908010304.342760-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ASoC: sti-sas: Remove the unneeded result variable
Message-Id: <166264096039.88408.2327336590864979124.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 13:42:40 +0100
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

On Thu, 8 Sep 2022 01:03:04 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value regmap_write() and sti_sas_init_sas_registers() directly
> instead of storing it in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti-sas: Remove the unneeded result variable
      commit: b075f21e533aa51c2bda87d86ddfb6a3c0e38a92

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
