Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BF4EBB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiC3HUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiC3HT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:19:58 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174218F20D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:18:10 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 772943F744;
        Wed, 30 Mar 2022 09:18:06 +0200 (CEST)
Date:   Wed, 30 Mar 2022 09:17:59 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable
 qcom wled backlight and link to panel
Message-ID: <20220330071759.ftcs2fhr7ehrfsqs@SoMainline.org>
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
References: <20220330065639.245531-1-jo@jsfamily.in>
 <BY5PR02MB70091CBCF76C99109C72E7C8D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70091CBCF76C99109C72E7C8D91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-30 12:26:39, Joel Selvaraj wrote:
> Xiaomi Poco F1 uses the QCOM WLED driver for backlight control.
> Enable and link it to the panel to use it.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>  .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index 798fc72578a7..3ebb0f9905d3 100644
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
> @@ -314,6 +315,18 @@ vol_up_pin_a: vol-up-active {
>  	};
>  };
>  
> +&pmi8998_wled {
> +	status = "okay";
> +	qcom,current-boost-limit = <970>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,current-limit-microamp = <20000>;
> +	qcom,enabled-strings = <0 1>;
> +	qcom,num-strings = <2>;

No need to set both nowadays, the driver will even print a warning in
this case:

    https://lore.kernel.org/linux-arm-msm/20211115203459.1634079-6-marijn.suijten@somainline.org/

Sticking with qcom,num-strings is probably the right choice here.

- Marijn

> +	qcom,switching-freq = <600>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +};
> +
>  &pm8998_pon {
>  	resin {
>  		compatible = "qcom,pm8941-resin";
> -- 
> 2.35.1
> 
