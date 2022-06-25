Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13B455AA5E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiFYNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144692622;
        Sat, 25 Jun 2022 06:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B34612B4;
        Sat, 25 Jun 2022 13:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B1FC3411C;
        Sat, 25 Jun 2022 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656162787;
        bh=6PYmcT6tZFnN80dEHugRgJOLCEYpA5+gGU6FfiYeZIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ttx9MosP+bLFHAtIczywCko67Q/MxBrHrXwCcXlwjfYMoHIX6+f5BGGZo1CCC4nc7
         GYfQuylOZPEo3H5Z4i19R8CBHb5HvhgHGLpHdchc1FSr7lzGzbMeF5CLHWAmcW1Ll9
         4SEHXQ1u64fECzn/+Zd6iz24ntMVApKQzfqCxFlhBxPclYMUNkg1U8geJjgKfR5CDK
         GFeHJYZwxjBB29/7A8wxSh/U5CnbmxnNoLKV1KhyoJNVNgVVFcmPcPH6aJGIxBd+Nq
         B8QIFoVRfyOvEhPpo1RXgnZQLCe0kvzRk8/W27d+aiu9QAxkOQvcgQ82uhdSJL0oFR
         3q8fo0p5OM3gg==
Date:   Sat, 25 Jun 2022 14:22:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: qcom-spmi-rradc: Fix spelling mistake
 "coherrency" -> "coherency"
Message-ID: <20220625142234.3f4a6ee1@jic23-huawei>
In-Reply-To: <20220621094736.90436-1-colin.i.king@gmail.com>
References: <20220621094736.90436-1-colin.i.king@gmail.com>
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

On Tue, 21 Jun 2022 10:47:36 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied. Thanks,

> ---
>  drivers/iio/adc/qcom-spmi-rradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
> index 87f349782108..56a713766954 100644
> --- a/drivers/iio/adc/qcom-spmi-rradc.c
> +++ b/drivers/iio/adc/qcom-spmi-rradc.c
> @@ -295,7 +295,7 @@ static int rradc_read(struct rradc_chip *chip, u16 addr, __le16 *buf, int len)
>  	}
>  
>  	if (retry_cnt == RR_ADC_COHERENT_CHECK_RETRY)
> -		dev_err(chip->dev, "Retry exceeded for coherrency check\n");
> +		dev_err(chip->dev, "Retry exceeded for coherency check\n");
>  
>  	return ret;
>  }

