Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE450E731
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiDYR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244072AbiDYR14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5C40E71;
        Mon, 25 Apr 2022 10:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45B7CB8191E;
        Mon, 25 Apr 2022 17:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E795C385A9;
        Mon, 25 Apr 2022 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907489;
        bh=oXDonDCRoq5ArdBi7s2pfOR94NBVaIngqQh1O0UA8jk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QP+JpNxHsSbszl8uYuQQrsV/VN3z3SqwsAGMCr6jnJCOckhah1CRhawR4koOo5AyN
         TXOu7o0uHm50bRMRy5v3q36RnUpzn+86/TQz6t51T1JqjuX6nw6sSviKmdFkRJe6tm
         rN1//r30953sOOxa8+rEki/W0Drp1uGUF5Bzl+TNjkyj6UJis61pGG15WADUx7Zm0O
         8ZXBliMnR2IB6Ad1SRv6l6+EyJaFUoaxhP0j9KAIpTDqPz8b94OWFGvQcGbCYYCiqb
         MzwXWrettnDtG6ck63pvEQaPY/C5XH805in/5VlrWr/S/4DnAKlMqE/SVxvIJdv0Sn
         YWIKlj0FmsfZg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        shawnguo@kernel.org, zealci@zte.com.cn
In-Reply-To: <20220420090420.2588868-1-chi.minghao@zte.com.cn>
References: <20220420090420.2588868-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: mxs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748728.584172.476405767078177971.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 09:04:20 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 32831bf569e377fc80dc2b1110b72874beb8f4c2

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
