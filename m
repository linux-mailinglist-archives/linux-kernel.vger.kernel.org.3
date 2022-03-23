Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3FF4E5113
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiCWLQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCWLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:16:05 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD741A384;
        Wed, 23 Mar 2022 04:14:36 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id qx21so2076747ejb.13;
        Wed, 23 Mar 2022 04:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dai30hWVE73XS1BdDg5fYlvRV1WNpo0cUCaApTip4lo=;
        b=YBVSqLBc/i7TjNGJzMQ6c8uy4g01xXH/skG/5HQK2YVsMpnYHGp0BzkHXScyLgp2gp
         0/gM6fmnzaWZmVYq1dAU4S4cPAUD5yeDiRUgpOTWBfRRTsgmG+U+mb9ONpmglc6k5UcJ
         DV1aod82aS6u39UwX3kTAZ96sNNKzGMJVgGON2ansWJ7LJqTE5KyLtGLfh5Ig0NS0K2u
         Hp2XA8P09s14cRSkiJ/LjwyVoSTbMG52rbnkwa7bxZ9ZhbYIsCuHo6BxDd2H397opzOP
         zui7rdWz7pP8vXGJhusgPhjp/L/QaRXlR+5OHZgOpGuvie7c58N9HXin7iBo2G9zvErl
         VYKQ==
X-Gm-Message-State: AOAM531klZI1aCq9A2Lbl/y5YyPSEiUNWoCMU5dOd6KwnfhKYrk62vjE
        bMM1uruWzDZ1W6lBoBlrPkw=
X-Google-Smtp-Source: ABdhPJxXt39QU/wVHju86BXrVhJch0OjFKWervPZkOxBPGRh1bfIYFtS/HVxO2OkprLAJEoFjwvxeA==
X-Received: by 2002:a17:907:970e:b0:6df:9b6f:8a52 with SMTP id jg14-20020a170907970e00b006df9b6f8a52mr28325822ejc.761.1648034074980;
        Wed, 23 Mar 2022 04:14:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id k19-20020a1709062a5300b006c75a94c587sm9544802eje.65.2022.03.23.04.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 04:14:33 -0700 (PDT)
Message-ID: <40f7c074-198a-5ce0-02b3-e6042975e228@kernel.org>
Date:   Wed, 23 Mar 2022 12:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/9] dt-bindings: soc: apple: Add ANS NVMe
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-3-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321165049.35985-3-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 17:50, Sven Peter wrote:
> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
> ANS2.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/soc/apple/apple,nvme-ans.yaml    | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> new file mode 100644
> index 000000000000..e1f4c1c572aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/apple/apple,nvme-ans.yaml#

Do not drop all code in soc/apple, but please use respective subsystems.
Apple is not a subsystem, is not special.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple ANS NVM Express host controller
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-nvme-ans2
> +          - apple,t6000-nvme-ans2
> +      - const: apple,nvme-ans2
> +
> +  reg:
> +    items:
> +      - description: NVMe and NVMMU registers
> +      - description: ANS2 co-processor control registers
> +
> +  reg-names:
> +    items:
> +      - const: nvme
> +      - const: ans
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains: true

maxItems



Best regards,
Krzysztof
