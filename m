Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9B4B70C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiBOQbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:31:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBOQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:31:48 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530344747
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:31:38 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x193so21374234oix.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qvw6yBKslnptQAEGBK+TPeQpSTeAZ2XR520/qUmqko=;
        b=ku36OtVat06YmsdQXzLJPPzujZv0oRg5u6WslCYojCY3zg3nh6fsrkORPv3u9pWRJs
         i6LNjy6WkuQd2h0ap+DUulemJczX3f0HQeI4NNQzvFD86iy/3eA77uE4MBy/voBnglqZ
         wUmhJ9AW7xswDT2GU3pkYqMlQQhl930vKf+kN6W9IB+j3hILh4K4JLQ4OfHhxnPF/pRH
         yXBg3P0x3yQPQGl8C3NWH7lNWmLB4WoJcafzifTOnPfcdZ0jKOQjsEeQaewSO7Mw0w23
         i3rq7OL3o7vvARv4HyThaMmBe0VyB2MywmjrCCL6ahxxtLcvsgN5uho22N+cQwb68uEi
         WPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qvw6yBKslnptQAEGBK+TPeQpSTeAZ2XR520/qUmqko=;
        b=E1FriTgMCvhT+qE517Kl8IuF6r+fZ4d7DAu2vuUIunHFblVFyG2Orw0kFrIx5wCfYz
         5YW+pjlBg4ivYRLpffj6oIIbpVMw+LC+V+uxgVOVzFLMLbzZlWkKvroWeVsYxsQEZtFx
         D6GIgYv9+X1S30/xbCLnyAb594xxIbjHtvcUVconB4s9MPMLGrEjqtJ2pxBIRfO+Ay3C
         bxu8OS7lNNWB3GZGUmGmwXlA4vbxEnkpZ1QftLLU7JSeIQjBcuqzMacfPp6IV3ceYzp+
         o42N1hNG1j/Hah2evvANnHVITg48c1QoicusCXZn6uhFkTNXt2j984Fe5HF6I1gjDgAd
         OyPA==
X-Gm-Message-State: AOAM532PGACDls+i8Kq94766gyuyEuKVHstAQsCpTACjgiKGWz2l7dez
        gozKCB4ulvfF53L9BPsijPzjvg==
X-Google-Smtp-Source: ABdhPJx1NHzLURoEZZtTBOsVuAbEOu7SN7/Q8HCr3dwJetsEmzt5pCEpmx67aE/WzgkEJNebGo5A4g==
X-Received: by 2002:a05:6808:1482:b0:2ce:6ee7:2cf1 with SMTP id e2-20020a056808148200b002ce6ee72cf1mr1952114oiw.287.1644942697880;
        Tue, 15 Feb 2022 08:31:37 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id w17sm512720oik.30.2022.02.15.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:31:37 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:31:35 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] arm64: dts: qcom: Add SDM632 device tree
Message-ID: <YgvVZ5iZn0UbyF3u@yoga>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-13-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-13-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Jan 13:41 CST 2022, Luca Weiss wrote:

> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Snapdragon 632 is based on msm8953, add the devicee tree for that.
> 

The commit message is a little bit thin on details about the change.

> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/sdm632.dtsi | 125 +++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm632.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
> new file mode 100644
> index 000000000000..b80ba8a5ef3f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include "msm8953.dtsi"
> +
> +/ {
> +	thermal-zones {
> +		/delete-node/cpu0-thermal;

Below you replace cpu[4-7]-thermal. What about cpu[0-3]-thermal? And I
would prefer the answer to be documented in the commit message.

Regards,
Bjorn

> +		/delete-node/cpu1-thermal;
> +		/delete-node/cpu2-thermal;
> +		/delete-node/cpu3-thermal;
> +		/delete-node/cpu4-thermal;
> +		/delete-node/cpu5-thermal;
> +		/delete-node/cpu6-thermal;
> +		/delete-node/cpu7-thermal;
> +		cpu4-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsens0 5>;
> +			trips {
> +				cpu4_alert: trip-point0 {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu4_crit: crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4_alert>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +		cpu5-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsens0 6>;
> +			trips {
> +				cpu5_alert: trip-point0 {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu5_crit: crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu5_alert>;
> +					cooling-device = <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +		cpu6-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsens0 7>;
> +			trips {
> +				cpu6_alert: trip-point0 {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu6_crit: crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu6_alert>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +		cpu7-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsens0 8>;
> +			trips {
> +				cpu7_alert: trip-point0 {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu7_crit: crit {
> +					temperature = <100000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu7_alert>;
> +					cooling-device = <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&CPU4 {
> +	capacity-dmips-mhz = <1980>;
> +};
> +
> +&CPU5 {
> +	capacity-dmips-mhz = <1980>;
> +};
> +
> +&CPU6 {
> +	capacity-dmips-mhz = <1980>;
> +};
> +
> +&CPU7 {
> +	capacity-dmips-mhz = <1980>;
> +};
> -- 
> 2.34.1
> 
