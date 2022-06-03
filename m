Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695853CD89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbiFCQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbiFCQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255EB51E6F;
        Fri,  3 Jun 2022 09:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4BE061A0D;
        Fri,  3 Jun 2022 16:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E67C385A9;
        Fri,  3 Jun 2022 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654275062;
        bh=FISQJyDGqAIiZncrB7QK52qKdvl4ZQMyTlmFRLj8KtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=is+T2s2vchI4uYG0K1GLeroJFnuAG3HvcIVuKuw/j+7YnEp5T50ldKdIMC0S01o/N
         qPol1iNaq+5DbtzRJxnI4k0WSg7zKXaM7Mla0+0uvLHdvY0hEd4AdozsrBdo53deXX
         1erDhnhiN39uuqtHuwU1H4Xl5Bcy2T7UzUZD0Y1/I0iT+X9Lmq8N/Ey6QVDGfzEyLM
         9Ba6ZqK2vd6o/iShgxfV1Ds3HVHnE/airgScd7vIbqX/QL7lqj5AJ8j/UcVwwkaxfp
         TXiqCQ8OTW15od+PKTUlzvEbGnOnizzT/5DZw6zBYrRRDuz8/bsd1qRIjEEiQ7YE6n
         2ooPBCcqhjwgQ==
Date:   Fri, 3 Jun 2022 18:00:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: sd_adc_modulator: Drop dependency on
 OF
Message-ID: <20220603180002.5135a065@jic23-huawei>
In-Reply-To: <20220530181706.3045-1-andriy.shevchenko@linux.intel.com>
References: <20220530181706.3045-1-andriy.shevchenko@linux.intel.com>
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

On Mon, 30 May 2022 21:17:06 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF so drop the dependency
> to remove the false impression such a dependency exists.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied
> ---
>  drivers/iio/adc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d0122b363ee8..3b6a80786b51 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -940,7 +940,6 @@ config SPEAR_ADC
>  
>  config SD_ADC_MODULATOR
>  	tristate "Generic sigma delta modulator"
> -	depends on OF
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help

