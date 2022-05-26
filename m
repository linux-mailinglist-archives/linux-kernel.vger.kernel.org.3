Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80A65348DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbiEZCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbiEZCXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:23:16 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE038BE4;
        Wed, 25 May 2022 19:23:14 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id f2-20020a4a8f42000000b0035e74942d42so81773ool.13;
        Wed, 25 May 2022 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gr4uy97+pYiigW6sQfOx7wYx16/DxKqRhykP61GXgd0=;
        b=a/nRX1klVUuQbmWKwaU8zC4ru9m/jAelEQMOBdIFJdeVK3iSCS3ogBGsSBjyO3Szjp
         C8lZYsWAA8cXEOBClWjdb/jCnR/i8bGGBpMW86CQMmFBZNydQW7Q8Om4xfjkMZ03cEDF
         h47yoF5rq7y8f1ENQ3aQm9cbl9ffWvnzjd/werJR5nB5hXXMN+qXetUZBSpQNi1s+YEL
         nvM/CAaI/cEmgGPI4Da8ze+Qe5Ev5iUhSO5naOIrV/fHTvm0ry8sWbr8to5kkn/3+17Y
         zjiQhVdhCHtVhPk9jhN4nX5TMVietCK+s1s/Bc9AJojTo8/FkDVIKP1wMTWZVvt0+0qm
         9Hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gr4uy97+pYiigW6sQfOx7wYx16/DxKqRhykP61GXgd0=;
        b=0yt8whYqDkuv20Fq5qb0Yhzt8FB+ouGVQDqmH62qklMFyc0VMn4gho49mFWQ8mMsp7
         LJGaxaLC9zwbR+RkYNYtxKR6tR24LIv/LFZcF8qB4EWO/eXLGWmCwm2MFA5oNu6thExF
         iyrEc6YD6yq1AML+uw3ZnTvRtknc2g6MrBZ7ah5KXsZVfw/pyneFpx2tO0XINC7mlnZq
         IZAZuXJ3k0uXbktfsBnP2ad5G2YTAZ7gCMAF0lL/n6htfke0wYc5heCHPPH1ngnW10Zn
         RgHGa3tsYrnPk+GnRl+/ts/aYd0ByXCZRHEliXmINBD0MZk6OS6Q0HBHwsmEgTmhafl+
         6YXg==
X-Gm-Message-State: AOAM5311KmRU2csAHAeVI1xnXHibKdPDuil8s17ZN/SRrjuyG8n5vrB+
        MytM0DxUtgjZNb2QZ1Mfk0Y=
X-Google-Smtp-Source: ABdhPJyxnTq1jPBqZ1PALw4j67SxxRqT7KOlj4RrWZU3aP5SyGp+cQKUizcHa2ZMFyVJeTxghbdruA==
X-Received: by 2002:a4a:b0cc:0:b0:35e:a2b4:bcf3 with SMTP id l12-20020a4ab0cc000000b0035ea2b4bcf3mr14109655oon.5.1653531794086;
        Wed, 25 May 2022 19:23:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3-20020a544f03000000b00325cf57766bsm244913oiy.1.2022.05.25.19.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 19:23:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b66103c7-6363-82dc-1e06-a1071b3aa19b@roeck-us.net>
Date:   Wed, 25 May 2022 19:23:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: watchdog: faraday: Fix typo in example
 'timeout-sec' property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526014127.2872254-1-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220526014127.2872254-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 18:41, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
> 
> The correct common watchdog property is 'timeout-sec', not 'timeout-secs'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Good find.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/faraday,ftwdt010.yaml          | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> index ca9e1beff76b..6ecd429f76b5 100644
> --- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -55,7 +55,7 @@ examples:
>         compatible = "faraday,ftwdt010";
>         reg = <0x41000000 0x1000>;
>         interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> -      timeout-secs = <5>;
> +      timeout-sec = <5>;
>       };
>     - |
>       watchdog: watchdog@98500000 {

