Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2374D1EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbiCHRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349244AbiCHRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCDE546A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2719B81B90
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739ACC36AF4;
        Tue,  8 Mar 2022 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760052;
        bh=Lg5l+lVaiRIYO+OoxUwg4IcaNNcQpd0IYxoVQ9lTYyc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P5jpwNriCQnrkXZfgZbGJA+O8dFA/CLORZmFnDVhwGnFmh45csUJUDeISFA2z79zF
         eYOyLl9YBPhKUA6NJwP4XONz2NqEkqipQuCKIIc+LDAQ1M4TBYZ1eDZHkgGqbZJBy9
         c8IG6ilWDCFtSBJQ5Y/3OnUwWWnoV6cXQxYa95+XFbk+R8nkrkKv3DqBKVKp+a/P7M
         fkSLWYTI9jO2Abbxhv5NA/OrN7N1OniOcrx/JRJWrzdhsOUh1TQ30L5e7+xATOQ4Ba
         hX6qC+LhswHYrVob3V9yWC6w26K4NtNEPXDiOa5trmYOAh8BowOC1l7K5EtM5B+W1m
         mH19YylPEprjg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Lianjie Zhang <zhanglianjie@uniontech.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220307151939.32870-1-zhanglianjie@uniontech.com>
References: <20220307151939.32870-1-zhanglianjie@uniontech.com>
Subject: Re: [PATCH v2] ASoC: Intel: catpt: use asoc_substream_to_rtd()
Message-Id: <164676005019.54315.15405377603345473367.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 23:19:39 +0800, Lianjie Zhang wrote:
> Now we can use asoc_substream_to_rtd() macro,
> let's use it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: catpt: use asoc_substream_to_rtd()
      commit: 51996ca26fc7b5dbeea80eddba0e8a4ece6af459

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
