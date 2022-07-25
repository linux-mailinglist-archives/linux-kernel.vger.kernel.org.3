Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A575805B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiGYUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiGYUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:33:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521D22531
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:33:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so6670450ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YC8yaQgFd+HG90KHMM102sQ8/krtMPBNJtVyfTE8BxU=;
        b=H8jtIOaXjJ7yUxFhSWOj1urgWFO6iQ83rNUIXkwDGDtbmGEP9rVWQZyiTqrwJXRhB4
         1tFh5KmbcQwNa24WhXO5Bpx5Oe3C62+3QRfywxyln3vs3RI/Anblz8DZRUia9gDyM31F
         6NA4WZpuj2WpUg49DZkd6QOsBbk6eoW/xuxNXZQEbAXpvlox/m5chQ65kqk1Rbo+feUr
         kQ91xSyLF4qlz0q4S5JL8f/TqnSH9FuWPoCQWkq9BwMPBqgTZTTIn/wsEvkrklfoVIMI
         F82Mhqkivvv95+91hOq2XBVDwmJMRP8AXVPBBmn4AJIVjBYMy51raEZwn4Hcv31bR/eL
         CfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YC8yaQgFd+HG90KHMM102sQ8/krtMPBNJtVyfTE8BxU=;
        b=Us0QVAXKjk3PSeVJvnpHc1YQGMmzfthbiBcdxKAgwPTt3CN6oZ3i/8yd5eOX20d8pf
         7Jlt/P4/2OWAm2r9j7fqFDmm3mGSIpARab2R5X1vd+JSHWf5KXKEuWz+3u1Md+NZL4NK
         8hjSPu58BO03hI63bVLrq/2THceAaMevXp1mliCXdyp9mj/CDRKNGwQbuXxj19zN/1kN
         J0kebfDFEuVV8U7tYAuBVWogtZWsBTOh5zHYs96uQJsOqWFRUUVentYgMJ8YSoPRq7ZV
         RBtFqobITL3Ws3Ftb2dusIjzN/RAbXdRJvf22rOHnAXlw7T11E7/qWoOUrUtFNKOhVZe
         ltfA==
X-Gm-Message-State: AJIora8o/jGqB7ZwDBwoQFfN7/bYWPn/I1Uf4dCTSyuXtSteBcYy8M5K
        Mouey9BE2ioDHJrCcJW0D3JfEw==
X-Google-Smtp-Source: AGRyM1v1aUdfNCXXDlZnX3/vJ315xsXYbqnTwqAVNHZm40uZvVM7McQWSiMH0kIGD5GH4I/HPdPJhA==
X-Received: by 2002:a05:651c:1501:b0:25d:a415:8ffd with SMTP id e1-20020a05651c150100b0025da4158ffdmr5079109ljf.310.1658781194399;
        Mon, 25 Jul 2022 13:33:14 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b0048a843505f9sm1300967lfp.293.2022.07.25.13.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:33:13 -0700 (PDT)
Message-ID: <de68c1e8-447d-f1e9-7885-6a109af1e971@linaro.org>
Date:   Mon, 25 Jul 2022 22:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
Content-Language: en-US
To:     David Jander <david@protonic.nl>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220725124813.1001032-1-david@protonic.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725124813.1001032-1-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 14:48, David Jander wrote:
> On some older hardware models this is needed. It will do no harm if used
> with newer models though.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> index a1676b5d2980..08d425020088 100644
> --- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
> @@ -37,6 +37,16 @@ backlight_led: backlight_led {
>  		power-supply = <&reg_3v3>;
>  	};
>  
> +	/* only for backwards compatibility with old HW */
> +	backlight_isb: backlight_isb {

Node name: backlight-isb

I know that other node had underscore, but these are not correct for names.


Best regards,
Krzysztof
