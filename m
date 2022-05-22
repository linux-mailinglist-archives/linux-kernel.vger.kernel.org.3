Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEE5302AE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiEVLgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbiEVLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23D35DE8;
        Sun, 22 May 2022 04:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D422960F8F;
        Sun, 22 May 2022 11:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A286C385AA;
        Sun, 22 May 2022 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653219373;
        bh=fBMFnBqiOGAN81A9MlWNSeOZT2JHUUQYFi9G9tUejEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YEaq327qkK9QJ7ad+CMNuwjvp8tX5/V1S+PtLRCZew5/f+G+pL3Z/1EMDv86xrMIg
         LuLFC4UyxRBKfFmi5DD+UPz3ahh01GnfGb8vMxtW1FmFfPsB5SBABGPRcsZ77eH9o+
         LqFp2cCxI5Kawb8AZhPpQ56MeE2Ef9gzPfSXWnK/LJJk2LFfK5RXjUqlmzvEe8wwy8
         FkASzoBTXgDeChym7sdL6Og3T1v2T+71LEw8cxKoc4XaLD3CawjpSL4Q1Q1BRvsdZo
         fQvA0SyhN1Ure8EFw6nVWgH/+pGfnA6VtuEFj48w2AGhETp/zzkzsSpmybtaZx6iHI
         EWY9u2MAh5MsQ==
Date:   Sun, 22 May 2022 12:44:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yannick Brosseau <yannick.brosseau@gmail.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com, paul@crapouillou.net,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: stm32: Fix ADC IRQ handling on STM32F4
Message-ID: <20220522124457.3546c9c8@jic23-huawei>
In-Reply-To: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
References: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 16:39:37 -0400
Yannick Brosseau <yannick.brosseau@gmail.com> wrote:

> Changes to the STM32 ADC irq handling broke the STM32F4 platforms
> These two patches bring it back to a working state.
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Changes:
>  * Removed spurious IRQs detection
>  * Updated comments and commit messages
> 
> Yannick Brosseau (2):
>   iio: adc: stm32: Fix ADCs iteration in irq handler
>   iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs
>     message
> 
>  drivers/iio/adc/stm32-adc-core.c |  7 ++++++-
>  drivers/iio/adc/stm32-adc.c      | 10 ----------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 

