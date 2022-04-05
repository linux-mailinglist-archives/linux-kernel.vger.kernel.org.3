Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5254F4030
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388213AbiDEPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiDEJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D62AE00
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD99B81CBA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6C4C385A3;
        Tue,  5 Apr 2022 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151125;
        bh=prxp14Ph7x4eGuDyhsNEtXCkl4YWUf4cu71uu6Q/kVc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aUgNJfzsK1Tf/zbkyhG241BqkorRDntFnlVMlqCsMhe67OA4HY5FHGVjOv1nQe2IN
         ppYRa3/FZfQFnfMYZAJ2Oe8lVus4JYsN7AaEsHSZ0MlR0ux408ziqWxGl3JUDqO1wV
         8NZuvzTK1c7VQkELiKy+JHobUEegoscyvSh2umRY60J7PORSvDv0v/JSs2G0XBAakO
         nGyayEoiCEMQITsU58dybDmI1e+VBlOlBF/bnIBsd/WMV0MMtJhnhPXWu+P5CMa1ws
         37izamC1KComhKNeqrjx4wz3ZYhRzRmfSgN8FBwwQ39NqrwgHnSzrsf5PxSA96Dfnm
         IDzMgxtd6krkw==
From:   Mark Brown <broonie@kernel.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220324201854.3107077-1-broonie@kernel.org>
References: <20220324201854.3107077-1-broonie@kernel.org>
Subject: Re: [PATCH] regulator: fixed: Remove print on allocation failure
Message-Id: <164915112476.276837.9420066139945665585.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:04 +0100
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

On Thu, 24 Mar 2022 20:18:54 +0000, Mark Brown wrote:
> OOMs are very verbose, we don't need to print an additional error message
> when we fail to allocate.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed: Remove print on allocation failure
      commit: 6c315afe65d05dc6eebf2d6b73a191990aada218

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
