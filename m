Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F75035F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiDPK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPK3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD53FDAB;
        Sat, 16 Apr 2022 03:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE5BB81D0A;
        Sat, 16 Apr 2022 10:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4FCC385A3;
        Sat, 16 Apr 2022 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650104797;
        bh=AsTNMnnFrylLkvAKOwNYV1qQNbmyfcozPFi2fyLHsKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqCFt6AcWP0IJUg0922aSVt6BpGhy/0yCQbGoJpaYUVSpLAHdCqHSFz/CRHlKAQAC
         IjUakhwy8ycAc56bfP+x2gmWVkIWoWLaeltDs7gUiGgFcKxuymfpRrlZyi4lfXwjQ3
         jjpI5imUkd1Cavj9E8jSfUJeVthPrHMLvubVt/TmPb2LWr329/z5MEtOo2w7N48EIb
         u1yiyWW1l4IEsEjcqQX90NyXv4fAtDR/neyVuN+Kj6QFIvoncjV94fv1u9pfgHi5wf
         iE3SgQG8sFalF2le4Ioa4pYNedSbF1U7Z96rjT7m+nlM1edlslYz4PjlXyj1lvU0gP
         lxhvHXcqrl1Pw==
Date:   Sat, 16 Apr 2022 11:34:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: dac: lpc18xx: Drop dependency on OF
Message-ID: <20220416113435.14f82d06@jic23-huawei>
In-Reply-To: <20220413190819.38206-1-andriy.shevchenko@linux.intel.com>
References: <20220413190819.38206-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:08:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Nothing in this driver depends on OF firmware so drop the dependency
> and update the headers to remove the false impression such a dependency
> exists.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied. Thanks,
> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 8d5b3bad75ad..d578e242d74d 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -304,7 +304,7 @@ config DS4424
>  config LPC18XX_DAC
>  	tristate "NXP LPC18xx DAC driver"
>  	depends on ARCH_LPC18XX || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> +	depends on HAS_IOMEM
>  	help
>  	  Say yes here to build support for NXP LPC18XX DAC.
>  

