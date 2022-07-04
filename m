Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE956507F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGDJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGDJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:12:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4FAE40
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:12:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so14689715lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sMtVrpezShBuwcHrneDKoHxgcFVzeJwm+MAWXmI0nU0=;
        b=mNZIydifEE1JBpfDgkjlLPbKlyOUQeRSUqQa6CQLT9OF8XkeW/ZJ4oYcDIqK/5MlYf
         r1XNVgLhiovGfrpwGprmRTWiisNvOjAzP2kq33ajN18dz3zZhNKo7ISuB7HaRTi3Ygrp
         iw7+oZdHsM4ZrtCpzwPmZ0xJQKlOrVOBatiOWp21Mh7CjiPesSfSaxx9GU1txYSPDfxi
         hXpREtW03SMrXzu5ba0AdD9f9e86mFDiv9XsPpSV5Zq9hW6VnO57um+FTB+THdSWBKHv
         cyhlUics8AQB6hAa8fIltFEQVJjsTJR76zKCC8woVm6EG/V87ORn1IVp74H9olw33EjD
         GLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sMtVrpezShBuwcHrneDKoHxgcFVzeJwm+MAWXmI0nU0=;
        b=WR8Oap3KUC8aL3O9jHw+6Dlk4tIsYXSWo74W2eCa+tQQpuHzhgGpu4CwEi9KZXInz9
         cxXE+mfsRtQlhrcuaL4ctDBxbL3/sXNDT+ykrB+SKTOgGpcombyWVo3fy7r0PX26jM3O
         /RWRxdCiqdnJn/9FDcyf8XO8b6thy3m+k7rJKZ+Eqbt+SDMfgHHUeWkNWeWXuQaKHzLd
         uNOHCU13h9SFThiNxqeHkIq66LlAfiejQCZVcO1fyi8Jv5mxQNIFn4/90p3Ghz4TifzG
         J9zPzGj0sQdp/fkkjIa2EAozo9QedVIrtklmtdG2dnRU8hCEabt7MPE3taBXK+lvpjrW
         iyqw==
X-Gm-Message-State: AJIora8UQy+B94D7C3J6Qv+v60kmP0in9/wqM1HOow1DlDk7Gp6h/6HX
        jqK9udJbdaaMFeJylANpMYN1Cw==
X-Google-Smtp-Source: AGRyM1vDjFRe/KRpPzDWJe4ostTBzue/9izXe/wL6YMqW/loMLucg9g2bltguu+0oMfcBHrPwHwzWw==
X-Received: by 2002:a05:6512:2254:b0:481:4eab:7e39 with SMTP id i20-20020a056512225400b004814eab7e39mr13673738lfu.468.1656925931437;
        Mon, 04 Jul 2022 02:12:11 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id y9-20020a196409000000b00481541fb42asm2077966lfb.308.2022.07.04.02.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:12:10 -0700 (PDT)
Message-ID: <ef7e501a-b351-77f9-c4f7-74ab10283ed6@linaro.org>
Date:   Mon, 4 Jul 2022 11:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bings: net: fsl,fec: update compatible item
Content-Language: en-US
To:     Wei Fang <wei.fang@nxp.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, peng.fan@nxp.com,
        ping.bai@nxp.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com
References: <20220704101056.24821-1-wei.fang@nxp.com>
 <20220704101056.24821-2-wei.fang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704101056.24821-2-wei.fang@nxp.com>
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

On 04/07/2022 12:10, Wei Fang wrote:
> Add compatible item for i.MX8ULP platform.

Wrong subject prefix (dt-bindings).

Wrong subject contents - do not use some generic sentences like "update
X", just write what you are doing or what you want to achieve. For example:
dt-bindings: net: fsl,fec: add i.MX8 ULP FEC

> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,fec.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> index daa2f79a294f..6642c246951b 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -40,6 +40,10 @@ properties:
>            - enum:
>                - fsl,imx7d-fec
>            - const: fsl,imx6sx-fec
> +      - items:
> +          - enum:
> +              - fsl,imx8ulp-fec
> +          - const: fsl,imx6ul-fec

This is wrong.  fsl,imx6ul-fec has to be followed by fsl,imx6q-fec. I
think someone made similar mistakes earlier so this is a mess.

>        - items:
>            - const: fsl,imx8mq-fec
>            - const: fsl,imx6sx-fec


Best regards,
Krzysztof
