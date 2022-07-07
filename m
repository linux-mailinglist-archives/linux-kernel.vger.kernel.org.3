Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9156A9EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiGGRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiGGRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27275C95A;
        Thu,  7 Jul 2022 10:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D6AE62091;
        Thu,  7 Jul 2022 17:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC55FC3411E;
        Thu,  7 Jul 2022 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657215915;
        bh=6utmIEBNmJdH+aR9y6LOhDYh2NSUvaIjv2jcybsXQCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAyhptaXy+sXh7tJLLUO+9hfDyjRzLENSJ+HBy9X2F4/HeOhUBO8Meizj2dsj48tz
         2+VupD/n2oX7oFzpv16iq8VNsclGafp+yIWNsiOIFOX2W8H4xvQ3Q6HCgALmEozHL6
         XTOxP9EBdkL8eUZvR6Bk/6juwd4q+iXJXVPOHNNA8TPzcIhRm2vMZ461Nw/sRDZf88
         m/b4+3DIOKRlWJ5jWfCQILcqGxpewHxdxLsAKdMD29xuKKWJReWU+qmJkVrMFyzE0q
         azNUDuTJIrNHopCJpU0ZKAgvGCeREEI34ir7vMV89SbCvKbfA+lN86hFzyoQpRuPFm
         UY+TA4fWyt11Q==
Date:   Thu, 7 Jul 2022 18:54:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 10/12] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC
 to rev2 ADC5
Message-ID: <20220707185456.45ff3958@jic23-huawei>
In-Reply-To: <20220704212402.1715182-10-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
        <20220704212402.1715182-10-robimarko@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Jul 2022 23:24:00 +0200
Robert Marko <robimarko@gmail.com> wrote:

> Add support for ADC5_VREF_VADC channel to rev2 ADC5 channel list.
> This channel measures the VADC reference LDO output.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm assuming this will go in via MFD. Shout if I should pick it up
directly.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 87438d1e5c0b..7bd3745884f0 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -589,6 +589,8 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
>  					SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_VREF_VADC]	= ADC5_CHAN_VOLT("vref_vadc", 0,
> +					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,

