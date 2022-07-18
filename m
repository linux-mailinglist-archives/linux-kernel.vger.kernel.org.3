Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3744457855C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiGRO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiGRO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:28:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3B26FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:28:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t1so19602328lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EEVhzQnfaeo8RGfWKKBG4R4Qy8MCeB6s3/UGPiuFDGk=;
        b=l+RsQJLYuRzU2srE3sz1+Xkobf7m9387jofZ0jO+O+TvEjPQarTlaPm0rNNSA+SA0B
         HCi4EmN3Sv7DV2hE3xB5VTC7xH/1f2pixJndWh2g6VNPb4EfpXb8PDHwxrj3vDnylr9G
         5247m0A2zegEkZLgFbJdYKNQb+WdwSkwumBieFMQKm+8L+tgZL2DWiOQww4UlmzPjpvf
         PmCgajYKDRCGtxckFbX+4FWJNCnN//6e8qA+e4eO7kB/v3E/bS1UHg4tfGcTH6YHK4Ax
         rbfudhIMa9kxgt4h6HAk3bEfmHs29DMwFYP0MvD06qKBvCfcv93jPvz69HGiKPHxI9O0
         6VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EEVhzQnfaeo8RGfWKKBG4R4Qy8MCeB6s3/UGPiuFDGk=;
        b=bWoN4QdL48WlyTZHcAjjJDFl0XiIi+/qTSu3az9PNEi27/lWSbtyVlxW2i2ausM2Gj
         cD/he8m2PjbkBLaS586dMFimYLobWogtgzp97cLITpbEYvqpeVJ3ZIIPNCLrrgRpU7EA
         BL2N8mQDinXppri8ygpi9ugOj3kTzhugzvpZI/OI3Bq1F/1omWPtn2jAyqCN4Y6tcrTV
         /lwEKOqKzKsQ0kYyUbNP1PfIjJc9ZtREr9NIiqqd+7gqmcrhoMyfWmu3stkAs40WOXWS
         nr6ExVnscScrS203uBUqzE4edOy2TdgFBppv4IOBJUVbaj6JKBOoC9ZAbWmopQQr+ff3
         IJZA==
X-Gm-Message-State: AJIora+3ToxMqV4PtLMf2/SXorX7VjqVNuzqvXu83DF0P4iq5XznBlsq
        9Z8PLiTLoKx8Qfef4Vj/pmOraA==
X-Google-Smtp-Source: AGRyM1tLMM7i1ct/kXA+jcAh+hm7oU6HjGG0FYLSKpJYiIrCBlnQyGABDVPi9B6996sE3NnmfCEt7Q==
X-Received: by 2002:a05:6512:3d15:b0:489:d97d:8927 with SMTP id d21-20020a0565123d1500b00489d97d8927mr15638309lfv.80.1658154517942;
        Mon, 18 Jul 2022 07:28:37 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s27-20020a05651c201b00b0025d30dba34asm2130114ljo.113.2022.07.18.07.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:28:37 -0700 (PDT)
Message-ID: <2719bf40-475c-65f6-a537-e2e64b98126e@linaro.org>
Date:   Mon, 18 Jul 2022 16:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: rockchip: Add analog audio output on
 quartz64-b
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220718064336.822773-1-frattaroli.nicolas@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718064336.822773-1-frattaroli.nicolas@gmail.com>
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

On 18/07/2022 08:43, Nicolas Frattaroli wrote:
> This adds the necessary device tree changes to enable analog
> audio output on the PINE64 Quartz64 Model B with its RK809
> codec.
> 
> The headphone detection pin is left out for now because I couldn't
> get it to work and am not sure if it even matters, but for future
> reference: It's pin GPIO4 RK_PC4, named HP_DET_L_GPIO4_C4 in the
> schematic.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 02d5f5a8ca03..a53cf81494fd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -42,6 +42,21 @@ led-user {
>  		};
>  	};
>  
> +	rk809-sound {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Just "sound"


Best regards,
Krzysztof
