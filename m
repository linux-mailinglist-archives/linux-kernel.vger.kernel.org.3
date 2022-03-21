Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B74E2FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbiCUSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCUSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:22:23 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1351588;
        Mon, 21 Mar 2022 11:20:57 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id ay7so17097718oib.8;
        Mon, 21 Mar 2022 11:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKTgpiFScEcEezkU3gQxHSkOyC+O5+goNNUME43jkTA=;
        b=mlHQhCK72BiLlsOLNKQlAknfeMNH470iyAXu8fndwo4LKY158f0PFokIn2KTrQ2J2l
         zqj6To33nFrIdqA67CqpIv/uq3s5lcmewgo88FYavJv98mXU23fKw9lnnI3kCG4amPkz
         TdRzUc3dq14lu2ZlrOUs6X5aNBRe+9OM04rEQtITz9fH8Zzi4U2Oes/T5igfDnBdLvmR
         QaX44JgFMDm/BCdK86HV3tXqqlIbMFQpwbtKMdBOGQK/50Ivi2pX85fVKtz2fzRXdjEq
         k5+AEn8ERixu41d8YbWxIf7d5jH2SrAR9Y/ZV6PzRoUrerVdteaTxipjHCBSSwHndhpx
         Qf4w==
X-Gm-Message-State: AOAM530hzFAsTYCJDcHtJrefMzIJGM2VCQ2omLN7SCvA0kqx/SzH+tQj
        NZFfQpXHMLfRkMoRAtiBInn1Ff1jUA==
X-Google-Smtp-Source: ABdhPJz4u1VvPuu/H0ZraoubwxBmduE156pa3q5rXdZ5rQ0O3JYIct5izC5OOF2g+Pbu5a/2L7SHNQ==
X-Received: by 2002:a05:6808:228f:b0:2ec:c59c:71e9 with SMTP id bo15-20020a056808228f00b002ecc59c71e9mr213176oib.153.1647886857089;
        Mon, 21 Mar 2022 11:20:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056808148400b002d9be41b179sm8154424oiw.50.2022.03.21.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:20:55 -0700 (PDT)
Received: (nullmailer pid 315279 invoked by uid 1000);
        Mon, 21 Mar 2022 18:20:54 -0000
Date:   Mon, 21 Mar 2022 13:20:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] dt-bindings: gpio: add common consumer GPIO lines
Message-ID: <YjjCBiiPUvepSqlP@robh.at.kernel.org>
References: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315083723.97822-1-krzysztof.kozlowski@canonical.com>
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

On Tue, Mar 15, 2022 at 09:37:23AM +0100, Krzysztof Kozlowski wrote:
> Typical GPIO lines like enable, powerdown, reset or wakeup are not
> documented as common, which leads to new variations of these (e.g.
> pwdn-gpios).  Add a common schema which serves also as a documentation
> for preferred naming.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/gpio/gpio-consumer-common.yaml   | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> new file mode 100644
> index 000000000000..098dc913f9e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-consumer-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common GPIO lines
> +
> +maintainers:
> +  - Bartosz Golaszewski <brgl@bgdev.pl>
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +# do not select this schema for GPIO hogs
> +select:
> +  properties:
> +    gpio-hog: false

'select: true' should be sufficient here.

> +
> +properties:
> +  enable-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Perhaps some sort of description on these.

I think these are always a single line, so 'maxItems: 1'.

> +
> +  reset-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  powerdown-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  pwdn-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Use powerdown-gpios
> +    deprecated: true
> +
> +  wakeup-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +additionalProperties: true
> -- 
> 2.32.0
> 
> 
