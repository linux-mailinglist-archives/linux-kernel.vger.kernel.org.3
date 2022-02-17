Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9984BACAA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiBQWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:35:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBQWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:35:30 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3EC1688E4;
        Thu, 17 Feb 2022 14:35:15 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id e79so5457101iof.13;
        Thu, 17 Feb 2022 14:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJCJJkJqtOsQ/CSbeUuObYQcThTPRTm035a09VI6ZJ4=;
        b=f/9n2LwuAs550FqOKTRMdD/7R0l2o+0y6+sk7ZCzkiymb5Fk/hXL5cbeM813WdhnKL
         cpj2/GwWukiAIRyYncpjrxqDWCZRbCy4TXk2L5nWjq2OeNsLV4e4ORxk527gYk1bTx3Q
         2IoXoiWwwVIpYd0eIZfmUFDFUJprPVym/Q5uvlEE1oAldkLgF1DkW02rtOdp83yN5lZm
         T95Gn87NQ/g7Ia365IFRBUcSy72mn5w48lqNkk8jJ6oaAS5AD3ViNQbj/K7KRnTmiBdm
         9rmWN0HWm0J/Bp7dYOMPeSAKgYqnWPdd/q48jz6iMLY0DUWzo11ExOYcwijc9YA1bj0f
         Rqfw==
X-Gm-Message-State: AOAM530IBrfaH9/9K70Ofq2iU01V4wWoP6rhWn4isjHzU/Hn1CMBeP+o
        ZqEkXUPQsy8V/yKyuoH0VQ==
X-Google-Smtp-Source: ABdhPJy0BMvl0r/0X5Zc06+9xSfxyHJxRc8f8yEbFq5HYdWl/tpmNswA1NCuOnIwtqi5NIlgpfhMVw==
X-Received: by 2002:a02:7a16:0:b0:313:f2f9:2ebc with SMTP id a22-20020a027a16000000b00313f2f92ebcmr3370002jac.136.1645137315031;
        Thu, 17 Feb 2022 14:35:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u15sm2891106ill.75.2022.02.17.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:35:14 -0800 (PST)
Received: (nullmailer pid 3892127 invoked by uid 1000);
        Thu, 17 Feb 2022 22:35:12 -0000
Date:   Thu, 17 Feb 2022 16:35:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: Add power-efuse binding
Message-ID: <Yg7NoLzC7zt2oihV@robh.at.kernel.org>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
 <20220217104444.7695-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217104444.7695-4-zev@bewilderbeest.net>
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

On Thu, Feb 17, 2022 at 02:44:43AM -0800, Zev Weiss wrote:
> This can be used to describe a power output supplied by a regulator
> device that the system controls.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/misc/power-efuse.yaml | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/power-efuse.yaml b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> new file mode 100644
> index 000000000000..cadce15d2ce7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/power-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic power efuse device

No idea what this is, but I doubt any such generic device exists. This 
needs sufficient description to be convincing that it is indeed generic.

> +
> +maintainers:
> + - Zev Weiss <zev@bewilderbeest.net>
> +
> +properties:
> +  compatible:
> +    const: power-efuse
> +
> +  vout-supply:
> +    description:
> +      phandle to the regulator providing power for the efuse
> +
> +  error-flags-cache-ttl-ms:
> +    description:
> +      The number of milliseconds the vout-supply regulator's error
> +      flags should be cached before re-fetching them.

What are 'error flags'? Not something I've heard with respect to 
regulators.

> +
> +required:
> +  - compatible
> +  - vout-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    efuse {
> +        compatible = "power-efuse";
> +        vout-supply = <&efuse_reg>;
> +        error-flags-cache-ttl-ms = <500>;
> +    };
> -- 
> 2.35.1
> 
> 
