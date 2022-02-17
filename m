Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04A4BAD91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiBQXzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:55:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBQXz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:55:26 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF41275C;
        Thu, 17 Feb 2022 15:55:11 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id d17so1019628pfl.0;
        Thu, 17 Feb 2022 15:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BCApldN1My2zQDH6XsMXkRelqe28kPbQvCxdSnBtFBM=;
        b=VnWnKnerLB8LAOe/EOIbggqD2hJHiqE73FXKDLid2bus06oh+n5+H9BgzLSezv7NBG
         QrgVgWNuSsTR9BH5ioAtXdWdjtvTzhR8umLGciv+Is4JB06+Me4hQHSDsM+b7UGWrLQ8
         zIgK6qBZlGx3mZOEJMaE+xxMKJyUYhOC8CqM6Vza0k0G4DusFDZ6M3vmoCTESqIjNFml
         I+AWR57U6xlwEw3+GzR2uzBx1vPcbZbBeW64eL+Lr2HZJVjanmWD1QTjOswfcRwdipXV
         mKnf0eGx/Ste1suo62pfb+xN8yiVUXSA0sGh9V+I3qJlOwuXHzw9fFOTg5LneLla9NxK
         bItA==
X-Gm-Message-State: AOAM531fQHd1VCBohvN7ub2M7+eiwoQjCco4v+Y6OPhNiPLgAO5U5zPs
        9lYmW4GhwpjpEkU4Msz/RHBZHJ938A==
X-Google-Smtp-Source: ABdhPJw9bvTsjvdhDldL1cUq2EJu6Zpi6JB8JIv1+iC5Q31/Eu8+QPEebSWj02ReUQ/vh1mpAWrazg==
X-Received: by 2002:a05:6602:1651:b0:63d:afb6:dfa4 with SMTP id y17-20020a056602165100b0063dafb6dfa4mr3505369iow.11.1645140550700;
        Thu, 17 Feb 2022 15:29:10 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l12sm2927362ilh.36.2022.02.17.15.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:29:10 -0800 (PST)
Received: (nullmailer pid 3971998 invoked by uid 1000);
        Thu, 17 Feb 2022 23:29:08 -0000
Date:   Thu, 17 Feb 2022 17:29:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     krzysztof.kozlowski@canonical.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-crypto@vger.kernel.org, claudiu.beznea@microchip.com
Subject: Re: [PACTH v4 3/3] dt-bindings: crypto: Convert Atmel SHA to yaml
Message-ID: <Yg7aRGjPzlt8TiAh@robh.at.kernel.org>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
 <20220211093922.456634-4-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211093922.456634-4-tudor.ambarus@microchip.com>
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

On Fri, 11 Feb 2022 11:39:22 +0200, Tudor Ambarus wrote:
> Convert Atmel SHA documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "sha_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../crypto/atmel,at91sam9g46-sha.yaml         | 60 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 25 --------
>  2 files changed, 60 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt
> 

Applied, thanks!
