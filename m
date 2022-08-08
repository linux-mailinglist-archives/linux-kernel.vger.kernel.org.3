Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5C58C538
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiHHJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiHHJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:01:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116C11C2A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:01:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v2so3080450lfi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tAR6MlMDHmDQO73lbvVKnLotbZsWUuiG6QGGNmumCB8=;
        b=gWVR2Kps4D8nn0alN5B/hZGj94MWs7kU7Gwqnnl2BvuVMokaEcekKRrxTI5hOCdM7K
         PhgHi4f15Zc1B7KE8+KVwzj6YPXUPs4qDSzBYRNmcEhc0d1FG3Ay90Dh3A6U70M/4mm2
         SP3fmkuUL1t/hD4oHqurrdKK+bN3wDgIx7b7HS0vy+/Hpo95vdj6sK6rey97Jf022eDq
         wol4+vnqdptvdGx0D4jEZTmFdLSe5VPfWINbZAAa7nM/tLL6+tXSQocSdFli84RofZ5j
         LZM5IefgJuEsPr7IG3MV+NXR8Artn3/kDPgFGBKdpu6BWQeBB/v9MbPySJctKuwK2Dp+
         tRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tAR6MlMDHmDQO73lbvVKnLotbZsWUuiG6QGGNmumCB8=;
        b=aRjhcOaav0IpzwqqmP64tNO8PxXwiMEAg+E8ioEX3BKmbcbYP1c7jpMF3Q0BVrDquu
         IjBzTPzsVKch+Bs5jc0eLiyc5YC+30GijNx+0ckUBwUjZjbkWfkhTP0YswyHKusmkwVt
         ph5Nlkp+zK+X/bfYGf8CGaM4jsgq+/aCtqlIcS9367c1f/PSZK2I8uhCCMD/Rv6mA5TO
         MP8c0etCq6Ot3YsYM33b23anZtPqqAUPrPZCvaievwEMA6Y9O0IEAf2gxhVfgvOQebPd
         teFpShwLMVVPOqGSW+DRHGixGA8O6ss1tLKTGy4nAjs6WZ9HArDZDe1ifD76rBTEtKsK
         GaLg==
X-Gm-Message-State: ACgBeo13jGikXjVTGZy4ojLatFNvIMmBwAGYRE9gkKhL45NW9JSCRKAa
        bJJd8FWRxZPyngGN4c+NTO7tSw==
X-Google-Smtp-Source: AA6agR6JGWYSid7rm3XtqM4yDPbb3OxW1R/HkQ9bGdK161ybakPEk9MBDB6c00tdGP8rOZd5G05GEA==
X-Received: by 2002:a05:6512:2201:b0:48a:7440:aaf6 with SMTP id h1-20020a056512220100b0048a7440aaf6mr6169290lfu.472.1659949290876;
        Mon, 08 Aug 2022 02:01:30 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 201-20020a2e09d2000000b0025e5fd96bf6sm1281379ljj.15.2022.08.08.02.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:01:30 -0700 (PDT)
Message-ID: <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
Date:   Mon, 8 Aug 2022 12:01:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property
 in st,stm32-qspi.yaml
Content-Language: en-US
To:     patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com, devicetree@vger.kernel.org
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-2-patrice.chotard@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808074051.44736-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 10:40, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add new property st,dual-flash which allows to use the QSPI interface as a
> communication channel using up to 8 qspi line.
> This mode can only be used if cs-gpios property is defined.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> index 6ec6f556182f..5e4f9109799e 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> @@ -46,6 +46,14 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  st,dual-flash:
> +    type: boolean
> +    description:
> +      Allows to use 8 data lines in case cs-gpios property is defined.

It's named dual-flash, but what if you want to use QSPI to connect for
example to FPGA?

Also how is this related to parallel-memories property?

Best regards,
Krzysztof
