Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5FF587983
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHBJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiHBJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:03:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3585F4D80C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:03:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m9so14912220ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhuL9i9TDotSF+bYGEKALdF6iapdw0N+X68W860otKY=;
        b=OtFEcrvRm+vgI4ZkufiqiWnFlo6Oxs8kf1KZKPok63gKbrJrpSxzI+OzL5Hwb5louN
         FfW8ajOxcSSBVrxw3mF7Ihsi/8YK0HavLwyZ20zRyhpjtBCpwe8eqCQVenrQoajJqnjG
         6eVF+rMJunBzJDdihBe/uIQ8PhRaYPVAmFpbw/XU+sS8/vyI4Fg9+7dqZFlXj4WBJULI
         gur7x4m9gecmh4tFCEKyHKHj56s5wSCwYVxVQfXvzIkSU9FmnU7raRRE7sbgSjqh4JZv
         8ENKXuverbEFp6l4A0zsPhEkGb8OzRt9FhRmE4sblsY4ONPEUwL1z1g74TG52fJQy/77
         /2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhuL9i9TDotSF+bYGEKALdF6iapdw0N+X68W860otKY=;
        b=bKoflp7W/hK5p4yOd6YkkSGqTM/c6Of1+d2CC63DcBOVOXv/QBUNO0Q3Hw23v6dSFy
         kicY7uwmcwQ6n+2MTBOtUhzZL71/ABQzskyRyiQGMJ8IVJR2iVnXBMjSCUswbvjs8SG2
         oP0Dz1ptOdNQe3u+ijkLF+vmgxJuEMBZRu4CJmpqWV3aA7EsFHWDH+WWt00prcJKuu+8
         zdWxLvk5L8V078kaqAhXokGKIM4KPaFFDiWlCOKAqVI81gEv+udnOytmNSYkvB8ASSl6
         qRJOD/KnWi3PLkzuy8Hg6hnu+VcAVujQaoO6LqM9uO4BlIoucJvRB7urjB6lcbnUjpep
         kwwg==
X-Gm-Message-State: AJIora8ztRpoMj4szOPD/39VeMjNXXutC1N93RVVJNga7m9MAWP/CoEC
        p13q5BXAEgItWTy2oJYl/KAjnA==
X-Google-Smtp-Source: AGRyM1siLBI+/dKc8L+pZh7GSlKLEDSw9zaPcBpli8DOQcLzlQt+ViI/atXXJs5olL7tsXdZHr56qQ==
X-Received: by 2002:a05:651c:1542:b0:249:5d86:3164 with SMTP id y2-20020a05651c154200b002495d863164mr6169530ljp.500.1659430983581;
        Tue, 02 Aug 2022 02:03:03 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id u13-20020ac248ad000000b0048af7e1b268sm778067lfg.210.2022.08.02.02.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 02:03:03 -0700 (PDT)
Message-ID: <ec49a891-a333-85a9-ec2e-e3d7e1599282@linaro.org>
Date:   Tue, 2 Aug 2022 11:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/9] dt-bindings: sram: sunxi-sram: Add D1 compatible
 string
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220801030509.21966-1-samuel@sholland.org>
 <20220801030509.21966-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801030509.21966-2-samuel@sholland.org>
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

On 01/08/2022 05:05, Samuel Holland wrote:
> D1 needs to export a register for managing some LDO regulators, so it
> needs a unique compatible.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../bindings/sram/allwinner,sun4i-a10-system-control.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index 1c426c211e36..ab6e95a97c9f 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -39,6 +39,7 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-system-control
>            - const: allwinner,sun4i-a10-system-control
> +      - const: allwinner,sun20i-d1-system-control
>        - const: allwinner,sun50i-a64-sram-controller
>          deprecated: true
>        - const: allwinner,sun50i-a64-system-control

Please first clean up the compatible list. All these should be one enum.
You have duplicated entries for two-compatible cases. Also enum. Don't
grow this pattern...


Best regards,
Krzysztof
