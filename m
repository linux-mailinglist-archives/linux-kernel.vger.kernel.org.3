Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B285A1A78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiHYUie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbiHYUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:38:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A5BB913
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:38:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 2so19558729edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bE5zN8mW2wFaoag3CV1bmUwVW/DH2Tvtq/imB8LMKgk=;
        b=i1YRORPITMQM/HrasLgyPYcWQ823dLI/Ng45Or/ZygrCULIwqrLECQWZcWFxupsxD2
         X75GLtf0IT9Axfv/HcEcWRhO9BRu8OhmmgOe99T2VGAaf1UwetmYFKIPN0BDbb+vKuQJ
         FVqzT9mrDPdT1fuSctzFueULvXWJOs9lXI7qbXTPDJCf/2pc2MEQhhQSYmGsNBjgqXpV
         SsQ0CEYdXoPMuCCmqGPiK44u8ZIvEJfis8ig+Jf7A9t2zM+Grzi0keHHmTFPAmCb0XNg
         /XL5bl7pCeO5PrR499vfKh1avb3ZCBTWbxEYFbEgZk4PpEIc+VfYFea2h+3HlN2Ab5x+
         +7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bE5zN8mW2wFaoag3CV1bmUwVW/DH2Tvtq/imB8LMKgk=;
        b=59zu7lHGu4B31oHBh7hHy/Xrr42u+gmP0jK4H7MlfAEEj0JEnLQ04J5lRUDXuDAXHN
         GQi+2qHV7EY/ae6VgzI2TVjZtis6+LCmaKDw5BqCkOjl1u0KLKkpps23k9hw/Y+FUvaD
         kMgDcNT1JE48qeBPKNjl3Ty7CkBp+i2SXpvuoSvx2U4XyHdsxqIbhk5tC05TCv7qVUnc
         zY92irb/e0OBkpByuvFi0R5R9mCMSRxf3F5KTK6lB0SuHyLheA3yHlqegLneMKLryUbf
         uhl38jL83y2dcdZ4GDxLm4+HA+Wao3Z/sgZ/OFuOeNafnSpo2QXM5zu5YOMBVfASMGGN
         PpwA==
X-Gm-Message-State: ACgBeo2Ua9jod8wP6+zS9eAe8PiO3GkL+sMBxFBU29U73QJxGzLKi6i5
        jSxXtR2r8O5zkaHE9hzsV8+3Sw==
X-Google-Smtp-Source: AA6agR46vM7ZB5GITiujfB+3Wcr0lm+Jdx1W0UL4jQUUev+eK1iWLAq9R4sWuvGXhdxS92NKg4e9ng==
X-Received: by 2002:a05:6402:35c:b0:43c:8f51:130 with SMTP id r28-20020a056402035c00b0043c8f510130mr4457209edw.393.1661459906956;
        Thu, 25 Aug 2022 13:38:26 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b007305d408b3dsm77319ejf.78.2022.08.25.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:38:26 -0700 (PDT)
Date:   Thu, 25 Aug 2022 23:38:24 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] clk: imx8mm: don't use multiple blank lines
Message-ID: <YwfdwKVU0pMoxIXe@linaro.org>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
 <20220722215445.3548530-13-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722215445.3548530-13-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-22 23:54:45, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Avoid the following checkpatch warning:
> 
> include/dt-bindings/clock/imx8mm-clock.h:284: check: Please don't use
>  multiple blank lines
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> ---
> 
> (no changes since v1)
> 
>  include/dt-bindings/clock/imx8mm-clock.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
> index 47c6f7f9582c..1f768b2eeb1a 100644
> --- a/include/dt-bindings/clock/imx8mm-clock.h
> +++ b/include/dt-bindings/clock/imx8mm-clock.h
> @@ -281,7 +281,6 @@
>  #define IMX8MM_CLK_CLKOUT2_DIV			256
>  #define IMX8MM_CLK_CLKOUT2			257
>  
> -
>  #define IMX8MM_CLK_END				258
>  
>  #endif
> -- 
> 2.35.1
> 
