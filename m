Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0252FD41
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiEUOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiEUOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:25:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA1366BF
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:25:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v8so16723274lfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IbbNsxWO/m2lPWhlsd3aTys0/Azk77kx0rBYcjjzxrw=;
        b=X7Xpxa/+7lKMnKDnsjZKhJ62fLY3M/Bnlu2oTHf1xVs0aDuL6HaFBRursY1TX571Mz
         CTTvITI8UTOU0bVIRqJzdeoY9tvL74IRnKuafMd0fKQhr9aSrbySUUUfjoGyIaRQ8Bsd
         rq1ehvsn+QNWX8JuMg83bVBb141ynroEuXWJ54qYYeJNfrsA7F4ia7U9kRAVJc63vT8S
         4M8f3yEPO65NtNNJ20uF0+3gHIQXGAHNLaNEEZlWrWLCWQf/zI0YohR609F9v+5+nhJi
         E9Zz7Cp9Fq5GYIbAveb2cQk/sth5VKAI5afZFuEbTy+sHdwhZvLjaJUyOwfHt6o67Z0q
         RxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IbbNsxWO/m2lPWhlsd3aTys0/Azk77kx0rBYcjjzxrw=;
        b=jLQLPJOeJLb8bCTdoWuZU8D/dnKP9JhQOFYMMT46KrlRAFRUDLFq4Z48oad4+wogRj
         3u89pU9N+M+D7eRVRhaGVF8vEUmdMbGo5xUeOqjrCnrz6rUKQp6lKNIJubCQiJ8cNM2J
         IcDdFOkXgsfxGz9FILpeRNffpWLTH7CvcelquhsXiTV4VUyuTEEhBDZ4RS6v8vFjvv1q
         eQ2sACq+mkUt9zkXepQcUGJEG093tMiXWHpXBb5Jk6JS++HH+4vLVAy+yVeHhauCtW5F
         A+5mTYYb1tJ0I4A4NmTFZpuyj2anl+HsJLsUdwBv1YFgsQ5V18OaeT0qbErdpvvtr48t
         /zgQ==
X-Gm-Message-State: AOAM531KcQ17VCl4hVAjQ4GrLYCuW/8JdUGf7zH9XJk+qjBRqlzAkugk
        pNgAPAdmVHpwurZcg3tqfji6bQ==
X-Google-Smtp-Source: ABdhPJxWmFsSb0Vzg1NAnz2GPn7MlkNF023jy6AnGMkyrTd5OmsIHxz8MDigJ2L10kwaol2EYaevwQ==
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id z14-20020a0565120c0e00b004785a9120bbmr3982177lfu.587.1653143109161;
        Sat, 21 May 2022 07:25:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r26-20020a2e995a000000b0024f3d1daea0sm724179ljj.40.2022.05.21.07.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 07:25:08 -0700 (PDT)
Message-ID: <7fd80a4b-5e60-0117-b790-359f6d94aeef@linaro.org>
Date:   Sat, 21 May 2022 16:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: mips: Convert plain text file to ReST
Content-Language: en-US
To:     Soumya Negi <soumya.negi97@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521015613.6197-1-soumya.negi97@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220521015613.6197-1-soumya.negi97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 03:56, Soumya Negi wrote:
> Converts .txt documentation file to ReST format(.rst).
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  .../devicetree/bindings/mips/cpu_irq.rst      | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.rst
> 
> diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.rst b/Documentation/devicetree/bindings/mips/cpu_irq.rst
> new file mode 100644
> index 000000000000..601cc12caa2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/cpu_irq.rst
> @@ -0,0 +1,56 @@
> +=============================
> +MIPS CPU interrupt controller
> +=============================
> +
> +On MIPS the ``mips_cpu_irq_of_init()`` helper can be used to initialize the 8 CPU
> +IRQs from a devicetree file and create a ``irq_domain`` for IRQ controller.

Bindings is not a place for code. No.

> +
> +With the ``irq_domain`` in place we can describe how the 8 IRQs are wired to the
> +platforms internal interrupt controller cascade.
> +
> +Below is an example of a platform describing the cascade inside the devicetree
> +and the code used to load it inside ``arch_init_irq()``.
> +
> +Required properties
> +-------------------
> +* compatible: Should be **"mti,cpu-interrupt-controller"**

If you wanted to add bindings, please use DT schema format (see
writing-schema, writing-bindings and example-schema files).


Best regards,
Krzysztof
