Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A384B44A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiBNIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:45:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbiBNIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:45:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58F4DF55
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:45:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i21so26572439pfd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ip60qtQLWzCCFSF+fXmXro0EJ/H2HAFhLM6Bus5v4e4=;
        b=uoqq23/QbISo1al/LhPmOxKzV5GAPTB76zb7Qa5T4GxRxNSX22mE6amrutaiEfsAcC
         jp7Bx5yaizO2+3qb4siYPg54h6U93ED9fMzF05dxpP7HTKfmC6AtXsnC3yBJLOUIBUMf
         DS5pROkZ5oo0YvTJsdiXi0qfKBpg7P6WebThI8kPhtTb/HGhWQIqAh1uhwZ5LqPehBt2
         WUQIwk+R4Qq2/xElBFW1xanMT5c69jX//G+d6aLHDZ4uxQdXWB2VM3D5j8YybE0gBXcH
         yMrVpSzK01LKgjfnq1nOIAic3yn/Znqvnhxkyq777YbDKs9N8Pr4hfWZSd8o4iVTQeTU
         uWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ip60qtQLWzCCFSF+fXmXro0EJ/H2HAFhLM6Bus5v4e4=;
        b=bEfeFReDwOHSCg6498H5vV7Qi0E1gKYA+93iXU9Os0+fOqcj9CezewYqjO5fxcIaKe
         zDiGomSU8v6o0sm3WY3COZZ9CJE4COcbU4Fxu/0I3U+FrkGc9yIbgwEST5ngxY901tOC
         eW1zwyWFmAQQKWmS0CQQJwVCH6l21ie2rB27nHKGV1Qk64pWox8/V2f6UhwpcxmdilEm
         mB4sU1STTN7WoesYeaam8rvY0K1B3SOouv5hoE6LWWv/zBF+z34NX0vuPiSn6G+1SQ37
         S4ygEgDQGYFOa1gm3tftWbobN5pKMo9lOh2bD0rW/+1izP0nyziYGhGTYflobtJOFi42
         /1FA==
X-Gm-Message-State: AOAM531hUyVgkN88RGKB58pH1gtgPEjUJSckBn3R5fL9H7PSAs3KiLHw
        H/JTahCjTGBhgXB0f4Met6kk
X-Google-Smtp-Source: ABdhPJwsYeE/PV70SFfexNjlPf9cNb8toQrpVB41ThYKDdMSFNKSSG4CT+EJ4n42UULgh8il/9nWfQ==
X-Received: by 2002:a63:fc65:: with SMTP id r37mr10968001pgk.123.1644828300703;
        Mon, 14 Feb 2022 00:45:00 -0800 (PST)
Received: from thinkpad ([2409:4072:817:5a6f:3104:62c0:1941:5033])
        by smtp.gmail.com with ESMTPSA id m23sm33785439pff.201.2022.02.14.00.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:45:00 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:14:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ARM: dts: qcom: sdx65: Add support for APCS block
Message-ID: <20220214084455.GF3494@thinkpad>
References: <1644822137-27760-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644822137-27760-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:32:17PM +0530, Rohit Agarwal wrote:
> The APCS block on SDX65 acts as a mailbox controller and also provides
> clock output for the Cortex A7 CPU.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 2900ffe..1646c7c 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -133,6 +133,15 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		apcs: mailbox@17810000 {
> +			compatible = "qcom,sdx65-apcs-gcc", "syscon";
> +			reg = <0x17810000 0x2000>;
> +			#mbox-cells = <1>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&a7pll>, <&gcc GPLL0>;
> +			clock-names = "ref", "pll", "aux";
> +			#clock-cells = <0>;
> +		};
> +
>  		timer@17820000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -- 
> 2.7.4
> 
