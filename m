Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFF528B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiEPRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiEPRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:01:02 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDA1118;
        Mon, 16 May 2022 10:01:01 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f16a3e0529so10608964fac.2;
        Mon, 16 May 2022 10:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PGM/f+MhCyogS9J2uiaZc8hzM6yWi20RzZ/UXGniMZE=;
        b=nhVbITlZjzDLeNHy1JB6Y9tDHXmZQtTlWYdphKIlzU8aq5uM1wfSUJqRo4bKghgjzx
         axYNyz3Q6exaZJ/OS+FDaXsBmWqBsUbIkT3pTToeaSBl8407SPkoMqoIYljbWuUbgPwh
         +M7T6T++BUj7ESzYrRbZC9Ee6mO2dIHimweOZS38gXDnscCdZXj+1k5NlfwRRyhaifOB
         hmgbO0tgPEjGFzMootNsyZrwHUGv2yO7/t4Ol9ySYIsJnPAy746npGVR5F7scaQ2IgbA
         6e0BKuCSA32fsmF+uFoaluKcwgAa3MCAQ28SMrpGxr+7x+SaF3aYGaiei7Wq7PsbV2K4
         rzcw==
X-Gm-Message-State: AOAM533IN5jyjPq53AZo3Tt+pHb2akSBvx9s2M9IKB2m55IUTLRMQl/t
        T/Vv6Cg+mAYfw13MJO8tN1pQRXWINA==
X-Google-Smtp-Source: ABdhPJxPcuyWTl3Hm3q8uneVs71/9O97pkP/Wo+rxMwJ6UVBDkxctbrjym+kpKGqaBYXuoQw0M2NgQ==
X-Received: by 2002:a05:6870:434d:b0:ed:5822:c104 with SMTP id x13-20020a056870434d00b000ed5822c104mr10224822oah.236.1652720460267;
        Mon, 16 May 2022 10:01:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo26-20020a0568709a1a00b000e686d1387csm5587197oab.22.2022.05.16.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:00:59 -0700 (PDT)
Received: (nullmailer pid 2887921 invoked by uid 1000);
        Mon, 16 May 2022 17:00:58 -0000
Date:   Mon, 16 May 2022 12:00:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as
 deprecated vendor prefix
Message-ID: <20220516170058.GA2825626-robh@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-2-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511094024.175994-2-shreeya.patel@collabora.com>
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

On Wed, May 11, 2022 at 03:10:22PM +0530, Shreeya Patel wrote:
> 'liteon' is the correct vendor prefix for devices released by
> LITE-ON Technology Corp. But one of the released device which uses
> ltr216a light sensor exposes the vendor prefix name as 'ltr' through
> ACPI.

ACPI? NAK.

There are no cases of 'ltr' for DT, so fix ACPI.

> 
> Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
> following warning in case the compatible string used in ltrf216a driver
> is "ltr,ltrf216a"
> 
> WARNING: DT compatible string vendor "ltr" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> 364: FILE: drivers/iio/light/ltrf216a.c:313:
> +    { .compatible = "ltr,ltrf216a" },
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v2
>   - Add vendor prefix name as per the alphabetical order.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..02f94fba03b6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -716,6 +716,9 @@ patternProperties:
>      description: Loongson Technology Corporation Limited
>    "^lsi,.*":
>      description: LSI Corp. (LSI Logic)
> +  "^ltr,.*":
> +    description: LITE-ON Technology Corp.
> +    deprecated: true
>    "^lwn,.*":
>      description: Liebherr-Werk Nenzing GmbH
>    "^lxa,.*":
> -- 
> 2.30.2
> 
> 
