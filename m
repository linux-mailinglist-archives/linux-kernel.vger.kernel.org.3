Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4F51634C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 11:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbiEAJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiEAJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:03:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B28062A02
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:59:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so22890406ejn.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zwZnSMoUMvauA0DcB2/3Hy6f11CAi3VR9h+0N7gLNIQ=;
        b=kO9jPewaYdfydQqL1tUmSCmn4EE8jzK7YR/xbVqpF/OIzONlX2IHxiNyYZS3gy1wV1
         gEOPAGLbKKecFS4/ikwmb8fJ/mEp0NnjBBHWRbxMgml/WfAD+fUo4PbFFVjhwYNMcJ+B
         aAkGZdx+dNp14n9IXBgSjOVVwsQjgOwczbjlWx1v3yZCw9PirCpiC1d1Oaply7ODH9mj
         D8INuP5q+cJ1BMRuqcUCQ84dK5CEKEdCQbGWfUb8MnLUqB3hEOBO5NZ77oFOuylp7Q6g
         QDxvDa7WA7KdaABXHOgNODiebnufDvJuuZytAuOfB7dx7M5Y2SsM9aL/P+q/iklDh2ed
         FtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zwZnSMoUMvauA0DcB2/3Hy6f11CAi3VR9h+0N7gLNIQ=;
        b=ttzmAKJxnMk4BHO+v/TSNeKupWh9iDxyTFQPfyDduaHhKqTsOTyLB8nVsH+3oLNfgL
         xJnURXcN/+sEFfKDbfcj1PTQCciCF8mUS42iohu+FokYpzwqgULa5R7gwJscWxzGWQ+5
         L86mfTzlYK449Fy74S3uKir4U5OLnFSb/FYITFJ0BCN+LR43PIxAxYPCXx5Fqnx/4JG0
         ROgg6W4D/WcBIybrWLg34HaPXzfLFLTziCih83Eh22St4VTnxZYxrxBO1In0qw1g0/GY
         5QYBWLHrfXXtZrIElElPenMtvwsFI9n9v+suj6+J/r+r0quBykV5uKTDlnnzSfGZSilL
         Utsw==
X-Gm-Message-State: AOAM5315wRNoOjelRIcdpkslTckq4adaGiCUybgER3FGLeMsx6m2K7KU
        isC7cRdg7sRXNvA4SRU+fib2UEBfiiiyRg==
X-Google-Smtp-Source: ABdhPJyudPfACSahB9C2aeEr9XfA8BESuGiedIMyik3JFnuTR2Cj6JKCtjMyIMKnue+s4bSlKkMrmQ==
X-Received: by 2002:a17:907:94d6:b0:6eb:6a12:df60 with SMTP id dn22-20020a17090794d600b006eb6a12df60mr7093766ejc.68.1651395597696;
        Sun, 01 May 2022 01:59:57 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv11-20020a1709072bcb00b006f3ef214e5dsm2369828ejc.195.2022.05.01.01.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:59:57 -0700 (PDT)
Message-ID: <6fdc6da4-3a34-e67c-cab8-1c9570501a8a@linaro.org>
Date:   Sun, 1 May 2022 10:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/8] dt-bindings: vendor-prefixes: add Sundance DSP
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, krzk+dt@kernel.org,
        palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220430130922.3504268-1-mail@conchuod.ie>
 <20220430130922.3504268-7-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430130922.3504268-7-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 15:09, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Sundance DSP Inc. (https://www.sundancedsp.com/) is a supplier of
> high-performance DSP and FPGA processor boards and I/O modules.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <mail@conchuod.ie>

If your @microchip.com email still works, then there is no need to
double-sign it. At the end you are still the same person... unless
you're not. :)

This applies to your other patches as well.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..1d47a38c2a2e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1197,6 +1197,8 @@ patternProperties:
>      description: Summit microelectronics
>    "^sunchip,.*":
>      description: Shenzhen Sunchip Technology Co., Ltd
> +  "^sundance,.*":
> +    description: Sundance DSP Inc.
>    "^sunplus,.*":
>      description: Sunplus Technology Co., Ltd.
>    "^SUNW,.*":


Best regards,
Krzysztof
