Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F150A5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiDUQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiDUQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:20:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E872F3879C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:17:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so5617058pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Fty8QNXfrAs0BV6klkEKYRiPAtqj4wdItJ/oZdWShw=;
        b=kRX5k9piGdMkSNkFjTIMS1g8v4ZUcKqn+BMMV0eG4CnXV3Zj9/qyJRQiXSZiY2v3AR
         qIBYYn5FczOPbiYThonWlEwbb/0x3ufJaykEhq6VS1IPmNvnuFeQJe61+hYwuxT2qZGK
         X6kAYxgcUYWg5u1pcH3zKB3sTp1SVjddn2srA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Fty8QNXfrAs0BV6klkEKYRiPAtqj4wdItJ/oZdWShw=;
        b=B4pCLyRRyCXkEN9FN3k0rcoQLVhpDSVLYDyH4SWfp4D4/yPoPauwgcxdLMjtCX7AiN
         MbR8zjYxJmSVr1nBcqvJnf++v1Dt+T/rkJhqyN0xB4bq1oC3AukKYpybGWS3rrww8+Jw
         qZsaMeWV2yhC+P23NqUBqFSBwUDZbj6I1+t7b2sIpY/XbsANqQTBXSYg5hz46iSWLII1
         rPL7rMTVos0SXI86s4GjduiQg1N+vZevXZ12T6bzs7nf91ub2HqiVGAzMxh432XhNu/Z
         tFEgBLcJ7ntyd6OtQbXsnYOsFd1f6eY5JfCH31+kZFGdiS3Ci/7geLORUdP03M6RJ4Zs
         y6LA==
X-Gm-Message-State: AOAM533MxgF7k+6bAZ7wjNIk8vji1D4SZ/RD5ckNts/9hoheci9an4hT
        gxFmdpEPp0xekl3viPQV9wWTaQ==
X-Google-Smtp-Source: ABdhPJz0jVyZiWkJb5eJkw4mj6V9lFamfYYK+Z0tLblE59uEzfuw9mcwUtLalS/qcqGqoxv1GYXr0g==
X-Received: by 2002:a17:902:8b8a:b0:158:983d:2689 with SMTP id ay10-20020a1709028b8a00b00158983d2689mr241189plb.173.1650557850191;
        Thu, 21 Apr 2022 09:17:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id t21-20020a17090a951500b001d77f392280sm513587pjo.30.2022.04.21.09.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:17:29 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:17:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 02/12] arm64: dts: qcom: sc7280: Enable digital codecs
 and soundwire for CRD 1.0 and CRD 2.0
Message-ID: <YmGDl4+os6Wkxn1G@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:29PM +0530, Srinivasa Rao Mandadapu wrote:

> Subject: arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 1.0 and CRD 2.0

This also enables things for IDP boards, right? If that isn't intended
then these changes should be in sc7280-crd-r3.dts

> Enable rx, tx and va macro codecs and soundwire nodes on revision 3
> and 4 (aka CRD 1.0 and 2.0) boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2f863c0..6cb5fc4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -238,6 +238,19 @@
>  	modem-init;
>  };
>  
> +&lpass_rx_macro {
> +	status = "okay";
> +};
> +
> +&lpass_tx_macro {
> +	status = "okay";
> +};
> +
> +&lpass_va_macro {
> +	status = "okay";
> +	vdd-micb-supply = <&vreg_bob>;
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> @@ -298,6 +311,28 @@
>  	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>  };
>  
> +&swr0 {
> +	status = "okay";
> +
> +	wcd_rx: codec@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		#sound-dai-cells = <1>;
> +		qcom,rx-port-mapping = <1 2 3 4 5>;
> +	};
> +};
> +
> +&swr1 {
> +	status = "okay";
> +
> +	wcd_tx: codec@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		#sound-dai-cells = <1>;
> +		qcom,tx-port-mapping = <1 2 3 4>;
> +	};
> +};
> +
>  &uart5 {
>  	compatible = "qcom,geni-debug-uart";
>  	status = "okay";
> -- 
> 2.7.4
> 
