Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE64845BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiADQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiADQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:02:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE32C061761;
        Tue,  4 Jan 2022 08:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEFBEB81733;
        Tue,  4 Jan 2022 16:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85EAC36AED;
        Tue,  4 Jan 2022 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641312141;
        bh=F3uSH+/Vwrjib9qd6ezayGVt8+Ohsxo0V/y/G8I3Suo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=so5HVB75J5Pw6VKymQT1U5/hr0/cgk5Poom+HUXS2iQ4dP1gZl7Peg1VBB7FLVik3
         7/zUN7kLvkmSw6jfJNPdCl9Arff+h1UrMayxehsKB0Mzr2uTfKBNfDQMlAFYKsTmOu
         AfleMiohLLf/B5tHfMT9d15ZlF7KNiUTxR9Idwpx1dDHcVDqB50H0Dv8rZm9ppfaMv
         VW9jjOIR8+QtfIzHr0mi5KxF8KQl/hpl1UBeCGTTOCCYSbXIIIG5Zi4xHqXMI8wkyJ
         6BeyLuIQqxvenZR8nPtchV3vUckCmVDz1sOTqKx5gLIUuA58Tub9E4pMkuzf3xygyW
         vmTne8BnFCCbg==
From:   Mark Brown <broonie@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211222055958.1383233-1-oskari@lemmela.net>
References: <20211222055958.1383233-1-oskari@lemmela.net>
Subject: Re: (subset) [PATCH 0/2] spi: ar934x: fix transfer size and delays
Message-Id: <164131214060.2665194.12806236437618254189.b4-ty@kernel.org>
Date:   Tue, 04 Jan 2022 16:02:20 +0000
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

[1/2] spi: ar934x: fix transfer size
      commit: ebe33e5a98dcf14a9630845f3f10c193584ac054

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
