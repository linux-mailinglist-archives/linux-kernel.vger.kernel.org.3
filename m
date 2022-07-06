Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28A4568EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiGFQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiGFQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:15:20 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA917AA2;
        Wed,  6 Jul 2022 09:15:19 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id v185so14427946ioe.11;
        Wed, 06 Jul 2022 09:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yIuMK+Epa4CeSgafcIsVixZuNX7hOleHdf6ygTqGQic=;
        b=KyPDdrCKAep8qU83RXPBG6KW1vNzc2QUV/dTQPp9hpiIjwPdbBDDC4kgskodiNBK9x
         LDMTx/LSFPCmrF/uT9UfOEDSP2Fr5jQ7iH1vxOvcfYAlHhFyk6CFIKuKazVRZzpek0s4
         +uQLnCnZFyvGeeqdxhZVS+qyGx06oIcYgX8INgDP5rnA0QRyoRMw22J5limjChguXVQY
         fCBSFLrKktrhu+0JrzwHm0AhF8KIOrqhHaCLcXM3ZXUezVwCz4KzqQWsJtPDeeMbFjl6
         ilkpYpODy/DvGHuzU+6kr22/hmFIUXbuz0QTtWvGkdilRI5vE9X/3L1zmUXy2Q+3/GIs
         xsfg==
X-Gm-Message-State: AJIora9I0QXSQ7R2Bv+53LvMSeTL1jtp1rx5/3UJqnpltopFh583ypo6
        QiFQCJ1T223G+/MR59/W+g==
X-Google-Smtp-Source: AGRyM1tgaH87vbPXIyTm51/rl0HRCmr9Zvj2FpHEwqOBNW/fakBKe/7zvs2hlfs05Iy5v7d+JKaY6Q==
X-Received: by 2002:a02:9709:0:b0:339:ef87:c30b with SMTP id x9-20020a029709000000b00339ef87c30bmr25332247jai.214.1657124118887;
        Wed, 06 Jul 2022 09:15:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16-20020a02b110000000b0032e271a558csm15962003jah.168.2022.07.06.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:15:18 -0700 (PDT)
Received: (nullmailer pid 143080 invoked by uid 1000);
        Wed, 06 Jul 2022 16:15:17 -0000
Date:   Wed, 6 Jul 2022 10:15:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jimmy Chen =?utf-8?B?KOmZs+awuOmBlCk=?= <jimmy.chen@moxa.com>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add an entry for MOXA platform board
Message-ID: <20220706161517.GA140402-robh@kernel.org>
References: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 07:22:23AM +0000, Jimmy Chen (陳永達) wrote:
> UC-8220 & UC-8210 hardware compatibility model
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  .../devicetree/bindings/arm/moxa.yaml         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/moxa.yaml

What's the relationship to moxart.yaml?

> 
> diff --git a/Documentation/devicetree/bindings/arm/moxa.yaml b/Documentation/devicetree/bindings/arm/moxa.yaml
> new file mode 100644
> index 000000000000..73f4bf883b06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/moxa.yaml
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/moxa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MOXA platform device tree bindings
> +
> +maintainers:
> +  - Jimmy Chen <jimmy.chen@moxa.com>
> +
> +properties:
> +  compatible:
> +    description: UC-82XX-LX embedded computer
> +    items:
> +      - const: moxa,uc-8210
> +      - const: moxa,uc-8220
> +
> +additionalProperties: true
> +...
> +
> -- 
> 2.20.1
> 
