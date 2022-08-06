Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4FC58B5FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiHFOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiHFOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79311A22;
        Sat,  6 Aug 2022 07:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4692761045;
        Sat,  6 Aug 2022 14:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2994C433C1;
        Sat,  6 Aug 2022 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659795241;
        bh=TcspVgJMCYgRJe1eMgJY0EQUSYj1o9t3RcgqBFaD6jM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E7HEm/cxP5ga25D9GTx/My1OddhV+gPSXfH+W3eQVgvrbODGwJzexiZDm6N5Kko/f
         Z/MXzV1bm2Ls0ps/zf82Cp4Vv04LNzyKlB26JVREqMJ5+RqDOx0NDmrle4rjhkn0uX
         d975ui65x8MuEfkUD/WzuURxnUlHBsGOAaF5UpGc65zwRFaKA7ezax1DQRfxiPBfiG
         NU7OX9GyLJISqj6Iopd3mhmvsgAqad4+NgYBsKFFHs6mP0kp5Qz6OYsy7r26J0cOf1
         9G1t+ke+oeCw1F/GpD+CWomewHuvRJSatpJF2YALZmnIwU0klyBWq7U4EHhG7g+/Vp
         cBxH7bjBGcpAA==
Date:   Sat, 6 Aug 2022 15:24:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: qcom-spmi-adc5: Add missing
 VCOIN/GPIO[134] channels
Message-ID: <20220806152419.15a578be@jic23-huawei>
In-Reply-To: <20220805135729.1037079-3-marijn.suijten@somainline.org>
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
        <20220805135729.1037079-3-marijn.suijten@somainline.org>
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

On Fri,  5 Aug 2022 15:57:26 +0200
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> These channels are specified in downstream kernels [1] and actively used
> by e.g. the Sony Seine platform on the SM6125 SoC.  Note that GPIO2
> isn't used on this platform and, while the definition downstream is
> identical to the other GPIOx_100K_PU definitions, has been omitted for
> lack of proper testing.
> 
> [1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Applied to the togreg branch of iio.git.  Note that I'll only push it out as testing
for now as I plan to rebase after rc1 is available.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 87438d1e5c0b..0dc4fe612433 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -526,6 +526,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
>  					SCALE_HW_CALIB_DEFAULT)
> +	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 1,
> +					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
>  					SCALE_HW_CALIB_PMIC_THERM)
>  	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 0,
> @@ -549,6 +551,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
>  					SCALE_HW_CALIB_PM5_SMB_TEMP)
> +	[ADC5_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  };
>  
>  static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {

