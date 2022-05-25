Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF71533671
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiEYFdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiEYFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:33:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC85DD26
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:33:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so28526113wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I4hK5ZCESVvpbTHTrxT0YN0GcY2Bf7iPQcvGhFggSYc=;
        b=BFIQIyLS4d5oDhY7nn7H0yXJOj8jU4DeWl616aK0oj7Qc5GhorMKOliOM+JMXQdN80
         ANZoj76/ij/MJYvYeymuAc5QyJktm1gaoCQyDoH2t6Q7bMcMMK5sTGZ0oHNyyuOvQOxF
         EK8qZ9gsRG1XrlbkKf8yTsJYb13uztqXL+62dPV6i9DJ4vEAmr4QgSS2dJimqFvvwod4
         2PrSLoE+lLkNbKTGJ/1s7nEXsxY53Uw+n5MDLz2SNmiEkbLcP/Zfk52tFl1yhXPtuiYn
         jKwy71Q4UndY5s9JISTQdLrLuQ6MRWEnEayqZVhCQbRlP6iTKS6oFLeZJ5Z80MsB91gN
         DrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I4hK5ZCESVvpbTHTrxT0YN0GcY2Bf7iPQcvGhFggSYc=;
        b=lmDKHLdZFfKqoki5OuT3EaKKlJgLStJaoxnZX9zjpWCOh8pThpS/DLqtadpWRSUfxu
         aJoPE8HB0C4GV01L5danri4f7dAu4tbrwzYWNDqh1wX+clZD6GlMoyIJ6ZXY0ynTe9zc
         9qipjnqwWJH3vrhbWlcX/iLouVx4bjdFK5ZGkVTmKGf9f3oEdyYdWbT20T2zZ9CaA+F2
         /HYCLEecY2zJJLKBx1Y57nJmK8eQeb7grcl8qMqeTKfKPRA4725IlMjtQEnDG7NejP4K
         tCze0dWblEBi8Jt9jfJvioMmM+FnA8byNIxT3pnnhIv/umK17GIqe6uJomrd8UmVRsjr
         Zz0g==
X-Gm-Message-State: AOAM532onu48nY3KhjIPfAtN3PX0EHMPgkUuruL62h2oDlm5fS8HTNCm
        dQA56WWBHQcvUMIawISAfW+QKw==
X-Google-Smtp-Source: ABdhPJzd20+RNjW06lk7cZhooGLWEZy8u7anI95p51+pEWaKkLf1VDIQpKcBRi2Z1NtA6f2UYd0Nlw==
X-Received: by 2002:a5d:59af:0:b0:20f:d6e8:a5e with SMTP id p15-20020a5d59af000000b0020fd6e80a5emr11689065wrr.507.1653456820595;
        Tue, 24 May 2022 22:33:40 -0700 (PDT)
Received: from [192.168.17.225] (bzq-82-81-222-124.cablep.bezeqint.net. [82.81.222.124])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d46ce000000b0020ff3a2a925sm1271231wrs.63.2022.05.24.22.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 22:33:39 -0700 (PDT)
Message-ID: <9b39fdbe-2bbf-c0b7-a6fa-3b05d8136336@solid-run.com>
Date:   Wed, 25 May 2022 08:33:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dt-bindings: net: adin: Fix adi,phy-output-clock
 description syntax
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6fcef2665a6cd86a021509a84c5956ec2efd93ed.1653401420.git.geert+renesas@glider.be>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <6fcef2665a6cd86a021509a84c5956ec2efd93ed.1653401420.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for fixing my mistake ... ... fast!

Am 24.05.22 um 17:11 schrieb Geert Uytterhoeven:
> "make dt_binding_check":
> 
>      Documentation/devicetree/bindings/net/adi,adin.yaml:40:77: [error] syntax error: mapping values are not allowed here (syntax)
> 
> The first line of the description ends with a colon, hence the block
> needs to be marked with a "|".
> 
> Fixes: 1f77204e11f8b9e5 ("dt-bindings: net: adin: document phy clock output properties")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   Documentation/devicetree/bindings/net/adi,adin.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
> index 77750df0c2c45e19..88611720545df2ce 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> @@ -37,7 +37,8 @@ properties:
>       default: 8
>   
>     adi,phy-output-clock:
> -    description: Select clock output on GP_CLK pin. Two clocks are available:
> +    description: |
> +      Select clock output on GP_CLK pin. Two clocks are available:
>         A 25MHz reference and a free-running 125MHz.
>         The phy can alternatively automatically switch between the reference and
>         the 125MHz clocks based on its internal state.
