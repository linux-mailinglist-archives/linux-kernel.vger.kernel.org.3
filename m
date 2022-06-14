Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B368C54BD81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiFNWPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiFNWPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:15:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2682E4FC70;
        Tue, 14 Jun 2022 15:15:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so373888pjn.0;
        Tue, 14 Jun 2022 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OE/fzMqpiaW3OFuKMIGVvraecSzECkoBjR9tZsRV+uI=;
        b=DnPPZrfz0bfFY/bANga/SjMZTFaMo1iEYiOk6JRl7u03GEoCMxLja7V+93EZw0JBx9
         pZVS/hsedBJVlYu6OBJZnnLBae7ffRL51mj4pXu/32yqnaHUEbya9zGy6pg06qy4wUDO
         bsmMgodMjAVt4SlgNCfuI/Bf0oxQjp4CsCfeEwIprjNpYLYA/Pl3dRQS1AhchJpABbE/
         vZfjWaEztcuX8A2sFWpGds9g/1Iaj8lM3bHjeBU6sH0kwHHLlsSZ5/+8cu2KO4sKfQPE
         kw8mHLIPHOaz2q+c1VCVlQJLxAJ+cz20dW9ORzd3aDLR3RqGs86ca1XPT55uNCVrzn1A
         eHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OE/fzMqpiaW3OFuKMIGVvraecSzECkoBjR9tZsRV+uI=;
        b=oUlhoal47RaGSM3ns2Sw1+ep8FklwZkeGF1TichkYRNAXFE2WnyRgY8PokQBvwuM6y
         ze8hHMsuocbI0crksNRpSFOxnJ3M2e1KsT21htpR8/6fB92vV2ZO0ms1UhonJVWFg3S1
         pLiaQgMc0noZBlyB/b7FpyvbH0MCKoMkpGiPB9Q1p92pWHlw1bLrHgIOlJ2KONTrfG1j
         ftYy8+Eb8XlXVnA5O6L9XIb3iOorfklhYKcxj/+7MJfO9ZbfgdKLMC+53cuzz+fuVrmP
         yAnKn9i/xjpavAXIoCOqnI0UkU2gTq/1i/Nk0yLDYoDK9XHxS1dp2aXwu8doTRH+bLmC
         vVuQ==
X-Gm-Message-State: AJIora+nXoeCg+eg2xY6imPqjCvCdcy4C+3TWN72aXL1LXIJeJGCX8B5
        MRhutlKncoXlR8HaLkzEhro=
X-Google-Smtp-Source: AGRyM1uOwk/emmVkX0QQYsxktMPnz9B66VY8L42swcCnbDvxdt1YA+mxYj3v0VZmMSVf571E4rpaOw==
X-Received: by 2002:a17:902:ab08:b0:167:7fa1:60df with SMTP id ik8-20020a170902ab0800b001677fa160dfmr6137259plb.71.1655244945535;
        Tue, 14 Jun 2022 15:15:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 130-20020a630188000000b003fadd680908sm8395481pgb.83.2022.06.14.15.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:15:45 -0700 (PDT)
Message-ID: <0f4118eb-d04a-c674-606e-09fd231c6936@gmail.com>
Date:   Tue, 14 Jun 2022 15:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 01/23] dt-bindings: ata: ahci-platform: Move
 dma-coherent to sata-common.yaml
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-2-Sergey.Semin@baikalelectronics.ru>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220610081801.11854-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 01:17, Serge Semin wrote:
> Seeing doubtfully any SATA device working without embedded DMA engine
> let's permit the device nodes being equipped with the dma-coherent
> property in case if the platform is capable of cache-coherent DMAs.
> 
> As a side-effect we can drop the explicit dma-coherent property definition
> from the particular device schemas. Currently it concerns the Broadcom
> SATA AHCI controller only.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
