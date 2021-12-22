Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BCA47D35F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbhLVOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:05:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245575AbhLVOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:04:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841D361A51;
        Wed, 22 Dec 2021 14:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD2DC36AE5;
        Wed, 22 Dec 2021 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640181893;
        bh=75UqRnXbLJitl8WtJNjYmGOc6EmcXbtKbaBt7Oupp08=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sV3YLiSjoHeqLL0ckh1isztaGLB9gKFHasRNqEwFMyg0ar9/WmJh4qkN/P5oesGUz
         LwtnqkCfkzeJdfjeYIDrsgOyXfbE9vg+RkZo2PEOdR0fuuh/XDTIV/wdPLVt+9BsNX
         hkUdQxXTR2CUnX4pr/1l/q5Y8RwWLdKxT6+Nbwwt/vk/mSWHmqEMvv+f0TUwQbub+G
         U0t0p2WPdsamcDNDp0cVNWuzEfWjbBZWEojKYi+NheT0J0kajMRBgmZ+RBV4q2f67p
         crqZtWswU61HImrZVjXYzjBmuxAz612EU5QZh68Vz1YiN4FAkDLX80mLY4jvUVHBeb
         iCfko6J5IgJlg==
From:   Mark Brown <broonie@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20211222055958.1383233-1-oskari@lemmela.net>
References: <20211222055958.1383233-1-oskari@lemmela.net>
Subject: Re: (subset) [PATCH 0/2] spi: ar934x: fix transfer size and delays
Message-Id: <164018189202.2906173.12739449799192637785.b4-ty@kernel.org>
Date:   Wed, 22 Dec 2021 14:04:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 07:59:56 +0200, Oskari Lemmela wrote:
> Some of slow SPI devices can not handle 32 bits transfers or need
> delay between words/transfers.
> 
> Series is tested with ATSAMD20J15 slave device which is running @8Mhz.
> Limiting bits per word to 16 bits and adding delay between transfers,
> gives slave device enough extra time to process reply.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: ar934x: fix transfer and word delays
      commit: c70282457c380db7deb57c81a6894debc8f88efa

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
