Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B78E4B4DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbiBNLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:17:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiBNLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:17:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE175C2C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:49:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso5407801wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DXv8SmLAPMNrPJ3mqwP/UuQ6ZTsnkTp239g0OTWzlWA=;
        b=Mzulk2XClL7m/nGCOdw94t+dgDFGHB4aVksteuofaaRa6xxyPqxvdn7NK6SdQpTIMm
         84gOQ2nkgwCF9lkU3ebqn9ocLqVhl9nK7Ol91VzuatvgUT3/MILOC8C+5Dge0ll5speM
         OPvTq4XR4At4lH7P+VkO3WylRaVGmycHr8XnjFvvjFWoYFm2f1BQtXk2q6Pr8qQwOt3c
         Nc9YMgKNlihGbhiwqPc3Hs7FekGV//l+Px+d3fDULIOGW9seSwIaQSDaiouk5PerQLqc
         j1auWiU7PiaW3VMZu/4Uh2g4Wcc/fNkhXlYwqYQWnZU1G0FGf7yHWAlqbIYnf4cv1g8a
         VHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DXv8SmLAPMNrPJ3mqwP/UuQ6ZTsnkTp239g0OTWzlWA=;
        b=kp1uMbT2eEdYfwolM8jHXQjWqRTxQA89o1POkVk/vJY2q9426X/9Uakfh+bymZ8PEQ
         mLTKqZ9O5He1RcYrFw0SsQSn2OEpWndY9Q3EU4rkzNgC+vCUMDMfq72MfyJiGckPlWDB
         gfdD3zbNB5livOoiEQt+dEIfybHjT5YfFa8CgjMUqDFdJg8BebeEJbT35OswfTcNoAal
         eGS/JHe5wML4c5t0SLbJHcfc88FVY1TKLBLhyyCwqxajDTGXk0flieZvF5nuDEijCUiy
         glgSx8o0Fjc3VEIdYQXN8DD1omJ5cGM/F2xyR6oaCfd27xip3sMOfAKf+qNd6ETF7qEO
         6qhQ==
X-Gm-Message-State: AOAM533E6SMEKrqkGY4pWEPWlI7N2gtg7h9TdJPzzCziW5X5+eP9hBxw
        oiWBYeh8kJ1mGOQbUozB6PEAWA==
X-Google-Smtp-Source: ABdhPJzKJsy80xYZ3+bzTwXnv+y+Y5fOp64rrpJitEd3V8DuS1Z1Eai8C0vh/48VKS2HutAE73zE3g==
X-Received: by 2002:a05:600c:b59:: with SMTP id k25mr10603699wmr.170.1644835798574;
        Mon, 14 Feb 2022 02:49:58 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id h6sm1920631wmq.8.2022.02.14.02.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:49:58 -0800 (PST)
Message-ID: <7a796e98-ef79-e50f-77b8-0b7ae533f06a@linaro.org>
Date:   Mon, 14 Feb 2022 10:49:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: SID: Add compatible for D1
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20220203012502.10661-1-samuel@sholland.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220203012502.10661-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2022 01:25, Samuel Holland wrote:
> D1 has a SID like other Allwinner SoCs, but with a unique eFuse layout.
> Add a new compatible string for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---


Applied both thanks,

--srini
> 
>   .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> index 6687ab720304..e558587ff885 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> @@ -20,6 +20,7 @@ properties:
>         - const: allwinner,sun7i-a20-sid
>         - const: allwinner,sun8i-a83t-sid
>         - const: allwinner,sun8i-h3-sid
> +      - const: allwinner,sun20i-d1-sid
>         - const: allwinner,sun50i-a64-sid
>         - items:
>             - const: allwinner,sun50i-a100-sid
