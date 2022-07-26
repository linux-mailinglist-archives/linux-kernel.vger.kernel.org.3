Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55615810BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiGZKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiGZKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:05:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A148CEC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:05:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a13so15774469ljr.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h1KNuKSprlHr1MV7SBK0x2Kig/xSgNNvfwQbrPIkEQQ=;
        b=MtUHPuESCizcQ0PNuP1E0nC3bo+0y/H9bDfPauVINS4rMsbjZKLs+Nfe+Z7Lcmyq95
         IcvJ8THHF2RltoACenq5TSn808GyELH917GpEODU5hlY+zcgqrj0zkVq7ShkEcdOXsc3
         S9R8EkmwVj2sYZWpqDB0D914BpvMBaeuN73R6EsccqV4PJ85yJXhcuZJILB0lcO0Mgad
         fa/4/emUtEE7vR2uDgSlrFZUTDnKMB/UeohNJhBxrJUArwppznAiXPqVkU9NNwDNbtX9
         1AZYgrzs59vB3rOAIOvhfx9ouWU8CQ/2eDh/NCoeKq5TgrdlqR5+5y+1pknH96Xt/2Y3
         PBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h1KNuKSprlHr1MV7SBK0x2Kig/xSgNNvfwQbrPIkEQQ=;
        b=L7IYmt8szzDbjM4AGg5fsX837CN+i9qIotcVaYpH0CdREUWt9wDXKmsNXIiJlA51q2
         LR0BSf8KGxvGLShvHUXHplrHNoKjjK+8c7y9tibR9RLA4HgH1iGiEA3U2CSYiLBgy9u8
         i5EerZGDLvrJqWHLjymyh+1EDDNn44z0cWGmL6v3yXrwV4QyHI1jhGVgGoA/TUviqMCE
         LywWINu4EsIxBpOFcTzWTpJW8hbMjL4L9vCYfaBJuyPjv62z1Go3EbZP5qk6cxM0ehMq
         G7UnlBdMlJBpeGXVOlnq3/joVHgoecRi+C2685hR8QdF8wes0zsGtEZlS7Mi9dyqGnJC
         Vb5Q==
X-Gm-Message-State: AJIora8xiS0SDWfJt4H4PFMToQAe3aQwAG6LLQSS6m8qOgKLX+/8Zd2j
        rC68a4fbuRsaBTM3XpIj74Mkpg==
X-Google-Smtp-Source: AGRyM1s0hwlJLIk5+GLowzZZkbCBEx/YXyiC9aALwSBDH1pvIuSZ+/x8wbbTUfgsTxvnD2b1ZWGFVQ==
X-Received: by 2002:a05:651c:1147:b0:25d:eb36:755d with SMTP id h7-20020a05651c114700b0025deb36755dmr5372069ljo.16.1658829907392;
        Tue, 26 Jul 2022 03:05:07 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id y19-20020a05651c107300b0025d72c1f646sm3215724ljm.58.2022.07.26.03.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:05:06 -0700 (PDT)
Message-ID: <922628f6-cbb1-b563-6464-e57959bafbcd@linaro.org>
Date:   Tue, 26 Jul 2022 12:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 23:21, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> --

This is not proper delimiter and causes the changelog to end up in commit.

Correct also wrong formatting of subject PATCH.

> v2:
> - fix #pwm-cells to be 3
> - fix indentation and ordering issues
> ---
>  .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> new file mode 100644
> index 000000000000..594085e5e26f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys PWM controller
> +
> +maintainers:
> +  - Ben Dooks <ben.dooks@sifive.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,pwm

This is very generic compatible. I doubt that you cover here all
Synopsys PWM designs, past and future. You need a specific compatible.

> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  clocks:
> +    items:
> +      - description: Interface bus clock
> +      - description: PWM reference clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: timer
> +
> +required:
> +  - "#pwm-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

Missing example.


Best regards,
Krzysztof
