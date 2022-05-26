Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6833C535356
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiEZSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiEZSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:31:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398E245B6;
        Thu, 26 May 2022 11:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93E29CE237A;
        Thu, 26 May 2022 18:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF58C34114;
        Thu, 26 May 2022 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589891;
        bh=u6QRn5T0x1Kw7yKo4gf6qe/2MhS9IdZC71xDGcCMdiQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fl6d2qpvdzkvsHowTRn9K+XxrIkljDiz+I4tfbSYjlkMUj6jqnK48OdFaACmr/rJV
         PN0dMF4goIu9P2PWvqpLVBEjZ98/CIo9i5CUKPLgM1S6WwXeRqu0qXB+czKtM1k7Q5
         AMh/T5Ey+gRBg48hiRIn4d9K8OybRqyErFo4T4SWQdutQgbMQHf0gJjO+tq3N3tv/C
         DaRVMEzht704h9RPGV8ER/MB/HrZoZKJQm/0Zyo41cJM1T67o+RPMytYQokgthWUAR
         ppcimrVsXsZCRG9T647ywZhelC22vvktDMY8qn55EW51EhaoVryM9ZuWxFDqdk/S+M
         SZ6Pnv+H2aTXw==
From:   Mark Brown <broonie@kernel.org>
To:     eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220525165852.33167-1-eajames@linux.ibm.com>
References: <20220525165852.33167-1-eajames@linux.ibm.com>
Subject: Re: [PATCH 0/2] spi: fsi: Fix spurious timeout
Message-Id: <165358989010.3223918.18351915520044853463.b4-ty@kernel.org>
Date:   Thu, 26 May 2022 19:31:30 +0100
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

On Wed, 25 May 2022 11:58:50 -0500, Eddie James wrote:
> The driver may return a timeout error even if the status register
> indicates that the transfer may proceed. Fix this by restructuring
> the polling loop.
> Also include a patch to display the error return code when failing
> to transfer one message, which would have been very helpful in
> debugging this issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: fsi: Fix spurious timeout
      commit: 61bf40ef51aa73f6216b33563271b6acf7ea8d70
[2/2] spi: core: Display return code when failing to transfer message
      commit: ebf2a3521738520e12849b221fea24928b3f61ff

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
