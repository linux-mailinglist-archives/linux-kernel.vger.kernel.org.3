Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E405518FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiFTMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbiFTMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CCBF1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:32:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eo8so14977396edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UDlZOOyQdcNu04vWkuOzesBNpGjux8CrCm9cWVOIx24=;
        b=zQ1FvVojJxROAc1xXxm+Q6cBQ7SGQl0HPdbo12uBjLljHYHp3EYPKPj2BiOT7I3HD1
         xjEPTKhkQtk1STTWMoge8lIfpjZNp2wugI1qPpsvda68JgAfKc71C4vnlRGrqqAzP4c9
         J883NpqgMB5f+SR8ZKBvnp9zDKPBu3O6N4dEWny9Ge4i/d172YuID0ea9s5BO3MFOQKO
         BENntZOjJci5jUckZhfwYjTkBCLzIBp9GeTwjLK4IXhLEt2gJxVcpTbwuOtDTc+ZMdTK
         7eiA/MJ27BjcGvjmq8rxM2VQrSsV1Fm/V2LvGhmJ1A3N1jeAKFXtz8fldr1HkQR2Uirv
         M7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UDlZOOyQdcNu04vWkuOzesBNpGjux8CrCm9cWVOIx24=;
        b=CDpgfCOYofLADqn+GOuWhEuj4EpJYEVM1yRWkVnHWbz/JntpnyBgYxckv55PyBagwR
         fLhmr6CO2JBbsTJ3qPoJz1Dd3ImI8hPmb6lVKNNq5UTTY4pihXS3dfsoEjFEOZHASaqN
         2Q7tZNS3C44rrUiEpxfcDFKnNDyNWkhOVXdoEHYPVwQ1HQ3Q7bL+cgalMRT/Jx4CnNH4
         Q1Ym/MaDvPF40PlNS59Hk/AALkG12/qxLpqLBw0v7djgQMt7FKwN0LxK0grjVWDcmYYw
         xFW3YRU1ndTjw9Wr4NPjFqVl53ubusm2LCM+MFcm/FQsIGMw3OPzRenIlbydFOvzZnYB
         vGmQ==
X-Gm-Message-State: AJIora8MFTkz9N+BYA1l/oDxquP79+A1nYyoj7cblP+6ioOsN4SNyUDs
        US9BsB55HcVtpbx2ek7f90YIwQ==
X-Google-Smtp-Source: AGRyM1t9fgr1zoTLwtaWq0ssCaBkm8DpxdEBpv4kn21sr0j0OBPkidHuMRMK80YULvQJL6Af2+vclg==
X-Received: by 2002:a05:6402:294c:b0:435:2155:fbe8 with SMTP id ed12-20020a056402294c00b004352155fbe8mr29002964edb.256.1655728377499;
        Mon, 20 Jun 2022 05:32:57 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063a5700b0070efa110afcsm5847013ejf.83.2022.06.20.05.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:32:56 -0700 (PDT)
Message-ID: <0d0ef565-9579-31ca-7f9a-7b3c0e7bc090@linaro.org>
Date:   Mon, 20 Jun 2022 14:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] ARM: dts: am33xx: Fix MMCHS0 dma properties
Content-Language: en-US
To:     YuTong Chang <mtwget@gmail.com>, bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220620121900.5196-1-mtwget@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620121900.5196-1-mtwget@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/06/2022 14:19, YuTong Chang wrote:
> According to technical manual(table 11-24), the DMA of MMCHS0 should be
> direct mapped.
> 
> Signed-off-by: YuTong Chang <mtwget@gmail.com>

This should be v2, not v1. You already sent a v1.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


> ---
> v1: Cleaned up coding style and addressed review comments
> 
>  arch/arm/boot/dts/am33xx-l4.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> index 7da42a5b959c..7e50fe633d8a 100644
> --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> @@ -1502,8 +1502,7 @@ SYSC_OMAP2_SOFTRESET |
>  			mmc1: mmc@0 {
>  				compatible = "ti,am335-sdhci";
>  				ti,needs-special-reset;
> -				dmas = <&edma_xbar 24 0 0
> -					&edma_xbar 25 0 0>;
> +				dmas = <&edma 24 0>, <&edma 25 0>;
>  				dma-names = "tx", "rx";
>  				interrupts = <64>;
>  				reg = <0x0 0x1000>;


Best regards,
Krzysztof
