Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38DC4F681B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiDFRxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiDFRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:52:52 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19A1B3707
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:21:40 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BAE3E3F6AE;
        Wed,  6 Apr 2022 18:21:37 +0200 (CEST)
Date:   Wed, 6 Apr 2022 18:21:36 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable
 qcom wled backlight and link to panel
Message-ID: <20220406162136.g4lwvhnm3xnyupuu@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Joel Selvaraj <jo@jsfamily.in>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>
References: <20220401001810.81507-1-jo@jsfamily.in>
 <BY5PR02MB70092607CD7CDD8CF8BCD464D9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70092607CD7CDD8CF8BCD464D9E09@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-01 05:48:10, Joel Selvaraj wrote:
> Xiaomi Poco F1 uses the QCOM WLED driver for backlight control.
> Enable and link it to the panel to use it.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
> Changes in v2:
>  - Remove qcom,enabled-strings property as either it or qcom,num-strings
>    should be present. qcom,num-strings is specified and sufficient.
>    (Marijn Suijten's Suggestion)

Thanks :)

>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index 798fc72578a7..d88dc07205f7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> @@ -231,6 +231,7 @@ panel@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		backlight = <&pmi8998_wled>;
>  		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
>  
>  		port {
> @@ -314,6 +315,17 @@ vol_up_pin_a: vol-up-active {
>  	};
>  };
>  
> +&pmi8998_wled {
> +	status = "okay";
> +	qcom,current-boost-limit = <970>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,current-limit-microamp = <20000>;
> +	qcom,num-strings = <2>;
> +	qcom,switching-freq = <600>;
> +	qcom,external-pfet;
> +	qcom,cabc;

Unlike the number of connected strings and configured ovp/current
limits, aren't external-pfet (and probably switching-freq, perhaps CABC)
hardware features that are common across all users of `pmi8998`?

- Marijn

> +};
> +
>  &pm8998_pon {
>  	resin {
>  		compatible = "qcom,pm8941-resin";
> -- 
> 2.35.1
> 
