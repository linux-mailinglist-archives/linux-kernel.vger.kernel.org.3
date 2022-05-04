Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A051AEAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiEDUM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377861AbiEDUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:12:25 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84F4DF79;
        Wed,  4 May 2022 13:08:46 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-edeb6c3642so2323381fac.3;
        Wed, 04 May 2022 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGpGSM3JO+2veRFHs1niFNH4/CD/2VyoSg35vRROAu4=;
        b=fGopPWAtHiLV7gStSX4XRtHLswyOdo3vhAqK7edPvkvY5l+o5PmGZnz/KMiyHopLHG
         okclwkZF3m0U0kaVlsr6wJ1SZ8EsB/p7Uaq6WOCcfPcfDF89ehWm/hjNMAenvnjx+qBx
         VCGC/bSW/7/VcyUpnI77VyTUxlLfWUjlvoI5Rg6cOcrjnqYQ1tSzDhTlDb36rtp7BTx8
         ngH6eU6CkfUuHkPmH09hb/6I/oCI6VCWLSKEGU+L8WngYHSANMoW51lB/pvN8OAsztth
         7Tjb45jjLRxtPltnA3U//0QS29a42FxP8zS82k3Cxv+BJfMlLtb6iUDEtnEnJpTXmjtP
         OJ4Q==
X-Gm-Message-State: AOAM533HD92IXsAmIqDjE/8+ZuIDox93YllpI065mypmuXE8/7Vq6vzp
        nHVLiU+t4hPTc5d1IB9Ayw==
X-Google-Smtp-Source: ABdhPJyO+rbTvhFFkPwVnyYpktm0eXBaVjuGB45CdORn8cVCMYDfYrUn5SmcQfX2hJ6YD3tJhqa9sA==
X-Received: by 2002:a05:6870:c6a8:b0:ed:d3e0:52b3 with SMTP id cv40-20020a056870c6a800b000edd3e052b3mr637039oab.92.1651694925950;
        Wed, 04 May 2022 13:08:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f15-20020a4ada4f000000b0035eb4e5a6b5sm6338487oou.11.2022.05.04.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:08:45 -0700 (PDT)
Received: (nullmailer pid 2140556 invoked by uid 1000);
        Wed, 04 May 2022 20:08:44 -0000
Date:   Wed, 4 May 2022 15:08:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add support for IPQ8074 APSS
 clock controller
Message-ID: <YnLdTIKx80wszbj7@robh.at.kernel.org>
References: <20220503195605.4015616-1-robimarko@gmail.com>
 <20220503195605.4015616-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503195605.4015616-2-robimarko@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 09:56:01PM +0200, Robert Marko wrote:
> Add dt-binding for the IPQ8074 APSS clock controller which provides
> clocks to the CPU cores.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Correct subject
> ---
>  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> 
> diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> new file mode 100644
> index 000000000000..df07766b0146
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.

> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
> +#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
> +
> +#define APSS_PLL_EARLY				0
> +#define APSS_PLL				1
> +#define APCS_ALIAS0_CLK_SRC			2
> +#define APCS_ALIAS0_CORE_CLK			3
> +
> +#endif
> -- 
> 2.35.1
> 
> 
