Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B777570A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiGKTLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGKTLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:11:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAEC52FD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CADB5B81197
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB2EC341CA;
        Mon, 11 Jul 2022 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657566664;
        bh=L0lSyjBiKezG5O6Uq/bakfNniucZFTebudbM02RJDdo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f2EwRdy2tNt6id+bBPT3BRycWRRWUiOT+YtMIVe2B0N29SLtFp/QIij0twzBiHyMo
         nC53HTo76zmSdoBz2W6qWdc7ICke2kxhgPj5fktpXmRiRG+yL14UOMYKPRoCRCI8ZE
         G/N0QQpZn8SY3FH6scYB4i/scevitLGF6D+o6e5BzzmWkN6rxm7n8UvzBRRrSAmN31
         ZTzbdreVdQNeULc1OCLxbIsD7sMmMbENZJ4jGirK5p0rWvtrLg33U1tKd9HSpid05R
         ybmhEyn+QRSzLAMHqUTgiyn13n8Sw0lhqoe0iOUeK116UAkHnIFOYGM12a99GZ5bdD
         GpJMePD2re/ug==
From:   Mark Brown <broonie@kernel.org>
To:     jiapeng.chong@linux.alibaba.com, lgirdwood@gmail.com
Cc:     abaci@linux.alibaba.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220711034011.46096-1-jiapeng.chong@linux.alibaba.com>
References: <20220711034011.46096-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] regulator: max597x: Remove unused including <linux/version.h>
Message-Id: <165756666336.1166849.14273128122593969453.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 20:11:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 11:40:11 +0800, Jiapeng Chong wrote:
> The patch makes sense but these are not compile warnings.
> They come from scripts/checkversion.pl, which can be called
> by 'make versioncheck', so I suppose that something in your
> build system is running 'make versioncheck'.
> 
> Eliminate the follow versioncheck warning:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max597x: Remove unused including <linux/version.h>
      commit: 3fec90048d3757fa4cedb598ff93d1cae23860e4

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
