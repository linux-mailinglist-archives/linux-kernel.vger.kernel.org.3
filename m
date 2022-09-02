Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F75AB828
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIBS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIBS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:29:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF884110DBB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:29:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u17so3352719wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=samYhApSiue4F9SKFyP/nfGqognVFcP2K4kMA9ZsZNc=;
        b=cHtVgbwMav8eoXd8UPdlWXEdfUgp0HFb1onFgFRetBNBC3C9+Ayj8ySMHLRpC8mpoI
         uu1xjT+VxLlRd6TAlgKtfPzQIDsn9Bl/Fr3NohMdkBYzLfcePw8T4Y7ZqiJaid5sQv/V
         kmXNkqstxszBnhdseyBYT8XWxq/Iqx65BizI0xrklkzdcpiVK+UN/z3O3BrSG2tnn1VR
         xnmGCj/qnVuBa/mYUaArc7ecTaSm7m+Rxih5UIn8wPZYRF6KMiVOSxS8z/t5d4KK4KXG
         iqHdfjvtkM2i0ByTDq2Ym8nMNJIiR1aaopvaDVUITRteuK8yFb5/84aCPppJ56w+MJp3
         U5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=samYhApSiue4F9SKFyP/nfGqognVFcP2K4kMA9ZsZNc=;
        b=Gpuyf/iWjEY8ic2kc/XSdnUqe85mtRDXPnU1tKhLXxcgTGudf/lgalKnwjpMjqsR+4
         4PbCSCVQfWeuMvFls8tthnp8vmNPtG21Nu8WX25HEtZOxSKcxy7Jie16KtErSCwP/7iR
         /qkm6cw/A6IfL2bsJ/a0PO7Ju/T+BoqoQG8TBSVLnXOKfbsK7EsWecNmQ4b1lOQM3IyA
         Dtw/3o7eh+4I9zbYThv/s2WRIXYXssxWq9JNTs9+GvhPDSX0sF4vwa/Vn7BVmGk/eegh
         2kgQSO43F+rLAtx7SNKIE8WdbvLQVwuoAfdsF47RqiF7a0yk8cEsiTvD45kyxfPSdQM4
         uttw==
X-Gm-Message-State: ACgBeo17xCizj1Yl1PhAmx3KSi19Ou7KfsIgk7Ku/Sc/OftHv/fEScAe
        /otn0wQmp8Bahus0negZ/vLwnW87SQqUEQpr
X-Google-Smtp-Source: AA6agR7IA2A7tqMFoUgfORv4pB4nIvZ/RLZmG29cSAtFFoXwwnOsHOOgSNSCSkwoozNdNhUZcFtYpA==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr19132392wri.16.1662143341417;
        Fri, 02 Sep 2022 11:29:01 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6a07000000b0022586045c89sm2115203wru.69.2022.09.02.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:29:00 -0700 (PDT)
Date:   Fri, 2 Sep 2022 21:28:57 +0300
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
Message-ID: <YxJLafhnMVUygQTs@linaro.org>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
 <20220722215445.3548530-13-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722215445.3548530-13-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Applied this one, thanks!

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
