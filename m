Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943FB59146C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiHLQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbiHLQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:56:27 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19B915C8;
        Fri, 12 Aug 2022 09:56:26 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id l24so1246080ion.13;
        Fri, 12 Aug 2022 09:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9Cp4QeCbCvOKGEvFZUU0aNCq6FMaAD/1Ak9E24Cc4I4=;
        b=XiS9tNUdnbmNJyZ3ObWNXgKYYs4HgDRbwgaIQSfPF/9VrScvArHaCjGQBrf8a4lIv+
         /gdd9SY9OmTJoJ5jTnyKw7hQf1U4wXpXtJ+/ZQc/JWumt2f0fqsYnYL/76IaBPEm/GeB
         sRraFDj3zbduuVSfoFYInXATnP10VGPa4X//m57Dr+juXQKB4QP+lbKTmiTHifS90kOc
         pu4oR0oPffDYj4Ae0OAyvKLkiHhKq7DadjtQ0EOCkNlBXvn0tvtFNC9UxEDUhUftH411
         4rDsktb9nGUdeWukvHQro/udapZ0KUBtdIhZFEDDl+NqM9BPJugQlvPf3GCUXMYRPyjz
         VmBA==
X-Gm-Message-State: ACgBeo1tjh3B2Z9OfvTxOsUneZqWk2jf/kM1tOyjLswwwocCRFA5PtoR
        Vw6dj7WC46mirvfa4uU0bg==
X-Google-Smtp-Source: AA6agR6qTsIohfC4640GKl7RspnUlKo+Ok0JVFjlNMLyEJRpsWgvTftyGOKSWm0+rvNuYvFQwV40vw==
X-Received: by 2002:a05:6638:1483:b0:33f:7944:a30d with SMTP id j3-20020a056638148300b0033f7944a30dmr2350179jak.155.1660323385456;
        Fri, 12 Aug 2022 09:56:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id az14-20020a056638418e00b00342e029aa2dsm90467jab.40.2022.08.12.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 09:56:24 -0700 (PDT)
Received: (nullmailer pid 317914 invoked by uid 1000);
        Fri, 12 Aug 2022 16:56:23 -0000
Date:   Fri, 12 Aug 2022 10:56:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: nvidia,tegra210-quad-peripheral-props:
 correct additional properties
Message-ID: <20220812165623.GA317861-robh@kernel.org>
References: <20220810131236.428529-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810131236.428529-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 10 Aug 2022 16:12:36 +0300, Krzysztof Kozlowski wrote:
> Re-usable schemas should use additionalProperties:true, so the schema
> using it will check for evaluated properties.
> 
> Fixes: e23917822d3c ("spi: dt-bindings: split peripheral prods")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml    | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
