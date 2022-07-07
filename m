Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92656A65F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiGGO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiGGO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B85A2D6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20498B82245
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0FEC3411E;
        Thu,  7 Jul 2022 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205781;
        bh=29cEPvHAlw8eCIh2gtRvtawUMKFPh11oa+ribnpSLZU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N9JRBOylg2/hSGgv8Yoeh4t6WVqXYVJDiKSxLgnwaWnP5T08gRrsp5kPBAa5D9Q0/
         JMGVVVX0qIEOC8/B9Mnt0Ye28KMdoq3CNXA31yrcfq+eC7FMu0JvUfBueVoBO0pf0n
         G9IyCJ0wOSlQkki8Y3s0PtTersfaJ/IHlilBt4KUR6Fq6gPqZY9V97JOgW72O2GYjb
         GmCpG9Y6kuYI6o6vMZSZosTrXqcIH0JkkobTibr0/cDSugy/R/CiECtOwQbKJ+EASa
         OAA8mkoGWxYLwipRd7nTHrv+RHLB8331Em8+Bq6uCZ94j1arbOxKQSuqpuh99G/NcS
         uThVQdglmrU1g==
From:   Mark Brown <broonie@kernel.org>
To:     naresh.solanki@9elements.com, lgirdwood@gmail.com,
        broonie@kernel.org, patrick.rudolph@9elements.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <20220707111753.16581-1-broonie@kernel.org>
References: <20220707111753.16581-1-broonie@kernel.org>
Subject: Re: [PATCH] regulator: Fix MFD_MAX597X dependency
Message-Id: <165720578028.1259782.4101203033564494968.b4-ty@kernel.org>
Date:   Thu, 07 Jul 2022 15:56:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 12:17:53 +0100, Mark Brown wrote:
> Drivers should depend on rather than select their MFDs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix MFD_MAX597X dependency
      commit: 79152fc74ff664e2912abe17f21c42d7c49c90c9

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
