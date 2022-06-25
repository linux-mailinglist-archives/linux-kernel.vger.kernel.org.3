Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F92455AA68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiFYNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFYNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:18:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304451A81F;
        Sat, 25 Jun 2022 06:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDC2B80959;
        Sat, 25 Jun 2022 13:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C288C341CA;
        Sat, 25 Jun 2022 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656163116;
        bh=DrvYsHNixQGAFxZ5B9o45TBNbqBktYaLq5jvaKUH8Tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=usAhrIS5wLWHr9hU7Do3gZcWvMC4Oeze1rkLQlqxian1RZ4QQIXbBhzWt2vE6roOv
         h5Sb+F/3L6++RBecYlOK+/fKWRJ9ym5nf86uqhRmfj1hA/GX7s/AZvZAJEWx7MK+G1
         WjtrYmqtpIaSuUNZ+7hjjnUNTSqE6HPkDiSXlsFudVcD3DDc7qBHhyLXGU4kjd2zSp
         hvJ4CuVgysdhorhnAngH26w2Avw3ksAbGOVHB5gl9/Gd+zfnFyIbFEQVEQF0kG4Net
         Qxs1BfQbAQQAuYWK2N4RMk0X61Dq6Ts87F1diYTYuaJz30o7bp9PW5Q58zMRjtuvlu
         QwEmR6sMofWDg==
Date:   Sat, 25 Jun 2022 14:28:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 0/2] iio: adc: stm32-adc: add checks on adc state
Message-ID: <20220625142802.51ee9637@jic23-huawei>
In-Reply-To: <20220620154738.801706-1-olivier.moysan@foss.st.com>
References: <20220620154738.801706-1-olivier.moysan@foss.st.com>
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

On Mon, 20 Jun 2022 17:47:36 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> On ADC startup a calibration is launched.
> A prerequisite for ADC calibration is to have ADC in disabled state.
> After kernel boot, the ADC state may be unknown as the ADC may have been left enabled by boot stage.
> 
> Call ADC disable routine systematically before launching calibration.
> Adapt ADC disable routine to perform disabling sequence according to current ADC state.
> 
> Olivier Moysan (2):
>   iio: adc: stm32-adc: make safe adc disable
>   iio: adc: stm32-adc: disable adc before calibration
> 
>  drivers/iio/adc/stm32-adc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Series applied to the togreg branch and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

