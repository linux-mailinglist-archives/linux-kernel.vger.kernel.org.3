Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4664F85AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbiDGRPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346000AbiDGRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:15:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999E1D31F;
        Thu,  7 Apr 2022 10:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D14C9B827B2;
        Thu,  7 Apr 2022 17:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745E7C385A0;
        Thu,  7 Apr 2022 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351578;
        bh=AcW2qSSyKVYlcD6HJhXQKK2NGshCVTDKYTfHP29ybig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Cl4Ox9I3U1vnxHbJg02QdXvgOW39gF9FoKGB3koI9LuWDIXFda3dEdkfTLnqCPqf6
         SFH5ACGzhukNAZbn1kNgsP+j+HAOkmlyrfwJLGadYEocx3d5McyE4aYkkRAMCPBFov
         wobW+uR0XE9FXAuuK5sgHEgHXQu6wNhBTcb02k3zmvE2ntcfjQF9zkru9Q92HSDzNL
         Tx0OqaK78r6rrcEbj+IZtmCgK6NRwRewzZmfevAJe2qRp72BqIJhd436TzIIhFq5Uk
         txaI76DyDgSVT0qH3SxG/0qviZM5kuKSBO3oY1PnQER5JANCZkZaETzS81hgR8LpHg
         UmjcR4WmReaVw==
From:   Mark Brown <broonie@kernel.org>
To:     bbrezillon@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        kdasu.kdev@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220328142442.7553-1-kdasu.kdev@gmail.com>
References: <20220328142442.7553-1-kdasu.kdev@gmail.com>
Subject: Re: [PATCH] spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()
Message-Id: <164935157716.1057547.16040863851899755370.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 18:12:57 +0100
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

On Mon, 28 Mar 2022 10:24:42 -0400, Kamal Dasu wrote:
> This fixes case where MSPI controller is used to access spi-nor
> flash and BSPI block is not present.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()
      commit: 2c7d1b281286c46049cd22b43435cecba560edde

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
