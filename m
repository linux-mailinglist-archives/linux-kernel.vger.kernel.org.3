Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CE537999
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiE3LOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiE3LOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:14:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534C79818
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:14:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so14180475wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5ns4sAybh4TgCu4Ru7gHJXiJGbL+lQMw1WNCULwfHYI=;
        b=Ap3LBwi1HjnkK+tjMaaSNaB5d9qYFwgjx5KsilFsV9uINomb7nRY0wcpr24XS9Fxjm
         kNOm1J+eZKOr3F9yURfbn3a38xFMr9ycGRAh3rnmgH+yePvWM9XhZDpg8gE9+mH1KViZ
         EHs0U13k/TdUCXp/OImt6PbmU1MoK49G0engcL2o9i3RfgQfkR51gAw2YDTC7hj4Frry
         PRVJS1igb1+sEgltSU0JuG4HfWcKpl136odwoo2lH4brRDbFD7CdMVPUyaWyJHgutbi8
         cmovSGmwAdAgqkTPgXonIWhcDYrscq3Ex5Sf4eDCsmRjekYj5tW42LDUlnn2QbN7KZsX
         CckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ns4sAybh4TgCu4Ru7gHJXiJGbL+lQMw1WNCULwfHYI=;
        b=lnEJOaUbkwbh5Zn8mqs/8oH784Es8HF2tTu+UG6dr0QWs8FfZrsZ/cYDYxsqXRJRdL
         8s/nMfReSsXLoUbJzfSbTNrXopJbgDo83VBhQLubDtiCls0syQI7rB/je5rJmk0k3yRo
         2Uwd7VX/gQONYn50whGUnslJ9WpOKJW9xj7f0/aEqvRpDSIz30zDZF2+sCtyVI1U9SYJ
         XuM60AuUvmQMuum7enK2M1LI3C/j+p+ViCQC9gUe+tbFro/1ZDVmJl6Zdo1ye2A2LDHt
         gIaKerWI4n8xdESYv9DBKXFWQ4WUy0EGAHy4/1cAmwXEoUWsg/FbaKbPAciSANtK+QNE
         I2iQ==
X-Gm-Message-State: AOAM532gonHDy8WRNziFjV8UyUIogBd5BWaVB1ZTfDBg22VNXd30lWo3
        ua8BechrVoGWE2/i3gMHGFtxhQ==
X-Google-Smtp-Source: ABdhPJxzlR6IVaPeURGn8HAw8VijyYBbOsX14dwuXhBLVh10oADT7aa8ETrSD4gvV3UsizicqC9zJA==
X-Received: by 2002:a05:6000:786:b0:20d:6048:71bd with SMTP id bu6-20020a056000078600b0020d604871bdmr44814724wrb.358.1653909275559;
        Mon, 30 May 2022 04:14:35 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000188c00b0021018642ff8sm9269844wri.76.2022.05.30.04.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:14:35 -0700 (PDT)
Message-ID: <390f1bf0-5f8f-840c-ea77-9d24d93f8c22@linaro.org>
Date:   Mon, 30 May 2022 13:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [uL PATCH] arm64: dts: ti: k3-j721e-mcu-wakeup: Modified fss
 compatible to syscon and simple-mfd
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, p.yadav@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220530094230.53823-1-b-kapoor@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530094230.53823-1-b-kapoor@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 11:42, Bhavya Kapoor wrote:
> The FSS node also contains the Hyperflash controller. Support
> will be added in future. Change the compatible to syscon to
> accommodate that.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index b4972dfb7da8..3c68094d835f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -169,8 +169,8 @@
>  		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
>  	};
>  
> -	fss: fss@47000000 {
> -		compatible = "simple-bus";
> +	fss: syscon@47000000 {
> +		compatible = "syscon","simple-mfd";

1. Missing space after ,.
2.  How does it work now? You expose syscon on this device node with
0x47000000 and the same time have a child device on same address range.
This looks racy and inconsistent.

3. This stops looking like simple-bus or simple-mfd:
https://lore.kernel.org/linux-devicetree/Ynq52E93mcTXcw9H@robh.at.kernel.org/

4. syscon and simple-mfd are not allowed on their own
https://lore.kernel.org/all/Ymf+OmNBaZ+7OrxD@robh.at.kernel.org/

Best regards,
Krzysztof
