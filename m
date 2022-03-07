Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25584D0885
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiCGUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiCGUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104075618
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F34CFB8170D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAC3C340EF;
        Mon,  7 Mar 2022 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685555;
        bh=BXpes14VYfngOaWXmh7Ky4YKpFjhJAvPaUR5cUr5tYg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IPULQSXuBuFE6e3zunx7f6HoQOCc3DaFIrTLbdGtWfU7ttGGA3SvpwTcORZFarNlH
         OX+H9zF5ubtbQ2RosycbHh2NNndoxR82Vn9el7/R3uB1G6xuMFi/OKKnbB/uPwbHDE
         /D79MzooOWXU/YitHfScbEP9RIPTGt/BwWdMQ+HwWSO4nuqpkHllzmXOSADCPVwx+H
         9hCjj+RUDNE5RZtlHx4uK9SMTGKEcu8Ao4FIzHewPXb3/OEQw67AleGGP9MWNDTDDL
         bpdVlHOkf7Lm+XTG9G31MRZl+0kzWd4ufY1BC289hiOlvIfll4KZ+fY7s7NqAerfqU
         nkONoD+BQ7/fQ==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <20220304023821.391936-1-jiasheng@iscas.ac.cn>
References: <20220304023821.391936-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] ASoC: wm8350: Handle error for wm8350_register_irq
Message-Id: <164668555349.3137316.17429422601485375594.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:13 +0000
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

On Fri, 4 Mar 2022 10:38:21 +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, use 'free_' in order to avoid the same code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8350: Handle error for wm8350_register_irq
      commit: db0350da8084ad549bca16cc0486c11cc70a1f9b

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
