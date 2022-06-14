Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761454BC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358568AbiFNUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356850AbiFNUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:52:10 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2CD5000C;
        Tue, 14 Jun 2022 13:51:06 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n11so10691151iod.4;
        Tue, 14 Jun 2022 13:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=35SehlekaFMujAJb5y7haSRllb1c8CzqMTDElwkUekU=;
        b=zfTLYAMo1uIo3yw8NSSVQNuAHeFWEa6V9dK0CtkQz3QvS445BuzvXbU2UXJS+I2FCu
         xbAalLxIPkYRETLsn7XV/CPV7xLxAM4A8IfEseHCoWknAqMo0KyhXSn9e7GqryuzBbop
         GSwqSh5b/ukAx51pc86FkIlu65TptcBacxS5Suw5IHfsDw5lWAqb93aFXtI6v8PnsPWA
         nfvzdfU3wJsS4I9d/H5dzBCPgQAeavZ/xJJzCT0Medg76pJnfy1gEtVeo2khZR4/OM+G
         c37XaCYoPqBdzsrgiZPEQhPhvt8bZQUs4B0DgnH/pQS6NfpD2zoNDFNhfo6qzhw5GRJs
         tjrA==
X-Gm-Message-State: AOAM531HTPhFJ/xrnFbG4z+Vse6QpiAhqypTh0SoYW+RKh1TfkrMKXq9
        PGFqTuasMw1oyUEQSvYd4A==
X-Google-Smtp-Source: ABdhPJwQk3+Na6eiyW27LMs4rmj6x3r5jGBNW89VVR1Mx7rCYkFFcTtfL4NnAHqR6nhY326D1Gl9xA==
X-Received: by 2002:a05:6638:430e:b0:332:586:5182 with SMTP id bt14-20020a056638430e00b0033205865182mr3913906jab.225.1655239853581;
        Tue, 14 Jun 2022 13:50:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w10-20020a6bf00a000000b0066a3140e986sm322597ioc.6.2022.06.14.13.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:50:53 -0700 (PDT)
Received: (nullmailer pid 2521413 invoked by uid 1000);
        Tue, 14 Jun 2022 20:50:51 -0000
Date:   Tue, 14 Jun 2022 14:50:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Message-ID: <20220614205051.GA2499840-robh@kernel.org>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-2-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613225338.393-2-vadym.kochan@plvision.eu>
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

On Tue, Jun 14, 2022 at 01:53:22AM +0300, Vadym Kochan wrote:
> From: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Describe the compatible properties for the Marvell Alleycat5/5X switches
> with integrated CPUs.
> 
> Alleycat5:
> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
> * 98DX2535: 24x1G + 4x1G Stack
> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
> * 98DX2531: 8x1G + 4x1G Stack
> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
> * 98DX2525: 24x1G + 4x1G Stack
> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
> * 98DX2521: 8x1G + 4x1G Stack
> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
> * 98DX2515: 24x1G + 4x1G Stack
> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
> * 98DX2511: 8x1G + 4x1G Stack
> 
> Alleycat5X:
> * 98DX3500: 24x1G + 6x25G
> * 98DX3501: 16x1G + 6x10G
> * 98DX3510: 48x1G + 6x25G
> * 98DX3520: 24x2.5G + 6x25G
> * 98DX3530: 48x2.5G + 6x25G
> * 98DX3540: 12x5G/6x10G + 6x25G
> * 98DX3550: 24x5G/12x10G + 6x25G
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> 
> Notes:
>     Changes in v9:
>     - Renamed $id with "ac5" prefix
>     Changes in v8:
>     - Add review from Krzysztof
>     Changes in v7:
>     - Add rd-ac5 and rd-ac5x boards to binding.
>     - Rename to armada-98dx25xx.yaml
>     Changes in v6:
>     - New
> 
>  .../bindings/arm/marvell/ac5-98dx25xx.yaml    | 32 +++++++++++++++++++

Use compatible string for filename:

marvell,ac5.yaml

>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml b/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
> new file mode 100644
> index 000000000000..1d8dd7c00c1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/ac5-98dx25xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Alleycat5/5X Platforms
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Alleycat5 (98DX25xx) Reference Design
> +        items:
> +          - enum:
> +              - marvell,rd-ac5
> +          - const: marvell,ac5
> +
> +      - description: Alleycat5X (98DX35xx) Reference Design
> +        items:
> +          - enum:
> +              - marvell,rd-ac5x
> +          - const: marvell,ac5x
> +          - const: marvell,ac5
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.17.1
> 
> 
