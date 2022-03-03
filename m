Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC384CBEF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiCCNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiCCNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:34:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103E6E562;
        Thu,  3 Mar 2022 05:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F8F161A94;
        Thu,  3 Mar 2022 13:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F040C340F1;
        Thu,  3 Mar 2022 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646314403;
        bh=PzmD1DQl0AcE+Tk4xay3tQNO7r7M/VFyeQO/bs5i4qs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QNW3s+QRMh+TfNsAziQbGL+oxvc1NzLaH95icAinfzQGo1B+AK9FiegBrlR63Elqv
         QQGq6lk6hdNyJB8Dn+7yhbCAVBO65u1lGVIcgYpjHM09Jt82wmi2cXQY4c6mAOJLk8
         L5ppoa5dxpet8B3Z070TEWwjfw7p68+jd/En9k7G7LcgtakUGiKJ+60SnXi8r/J8oc
         cPz2Dy0yQ8NVZktakhCUIn7iJy0b4DUsE6SA1Z1HSBA8N0GAk8R6yxxjNyg2tZlRXu
         xBRc5DGW05bRokk/NnyC9ZcXhbQTq4M0nQkGdGhHqt92uiwKRJU9YeyuhtAm6BOIVg
         bCNGYR6VMqNtw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, avifishman70@gmail.com
Cc:     tali.perry1@gmail.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, yuenn@google.com,
        linux-spi@vger.kernel.org, benjaminfair@google.com,
        venture@google.com, Minghao Chi <chi.minghao@zte.com.cn>,
        openbmc@lists.ozlabs.org, tmaimon77@gmail.com
In-Reply-To: <20220303092131.2060044-1-chi.minghao@zte.com.cn>
References: <20220303092131.2060044-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: Use of_device_get_match_data()
Message-Id: <164631440076.1874006.2759123055383084875.b4-ty@kernel.org>
Date:   Thu, 03 Mar 2022 13:33:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 09:21:31 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Use of_device_get_match_data()
      commit: dc8fea13f98ace0ae8815dd44d1e60c184f3f930

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
