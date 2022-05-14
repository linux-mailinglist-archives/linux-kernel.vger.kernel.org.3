Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A535272C8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiENQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiENQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:04:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4D2AC7B;
        Sat, 14 May 2022 09:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80547B808C9;
        Sat, 14 May 2022 16:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4299BC340EE;
        Sat, 14 May 2022 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652544278;
        bh=ahkhJryacQr7ULePw0qjg+sVbSF/2SBQ/b0sTtL5hKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aoWMhXojLJv+afB8djzlOLgAZQLKrZ81hUWX6xvYGtmBRyWa3Nvj4lF0KFuhpbhI9
         yeL04eD+01R3zSYoLLPL6yRS9xmbKihb+6LPr540g0Sq/NpNMDz3jeYGdVKcfymjs+
         86OemoSG4NcAS++BPFSYGri2rYwRgFakEV8dFRJ7hkZ9Uxm3aiFGLxsTH6eNECJRRg
         LVDawoo52+o3m4oCAlbdX0+a+Wd0CkJTBOXBlmko9Vtn4FjYDitHNZKRyexo8fCPFV
         juwVvS8WgwAe6Y9aVQ91PWGYVm9qRrx449yR/ZfXSyIuMHSgeC0667jTMB7dES/4MZ
         rEMuCoq8eOr+g==
Date:   Sat, 14 May 2022 17:13:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: adc: qcom-spmi-adc5: Add missing
 VCOIN/AMUX_THM3/GPIO# channels
Message-ID: <20220514171312.227a1f07@jic23-huawei>
In-Reply-To: <20220511220613.1015472-5-marijn.suijten@somainline.org>
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
        <20220511220613.1015472-5-marijn.suijten@somainline.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 12 May 2022 00:06:10 +0200
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> These channels are specified in downstream kernels [1] and actively used
> by ie. the Sony Seine platform on the SM6125 SoC.

Looking at the links, some of them are on that platform but not all.
Better to make that explicit in this description.

> 
> [1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

I'm not keen on patches with no context being
sent to mailing lists. Please cc all lists (and preferably individuals)
on at least the cover letter so we can see overall discussion.

If nothing else, I've no idea if intent is that the patches go through different
trees or all need to merge via one route.

Patch itself looks fine,

Jonathan


> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 87438d1e5c0b..69c7fd44d34c 100644
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
> @@ -549,6 +551,16 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
>  					SCALE_HW_CALIB_PM5_SMB_TEMP)
> +	[ADC5_AMUX_THM3]	= ADC5_CHAN_TEMP("amux_thm3", 0,
> +					SCALE_HW_CALIB_PM5_SMB_TEMP)
> +	[ADC5_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> +	[ADC5_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_100k_pu", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  };
>  
>  static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {

