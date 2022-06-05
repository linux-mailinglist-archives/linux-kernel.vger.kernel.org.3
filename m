Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C553DE54
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbiFEVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiFEVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:21:20 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454C393F1;
        Sun,  5 Jun 2022 14:21:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id k6so6684601qkf.4;
        Sun, 05 Jun 2022 14:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uD2FXQUAnfQEohjyaZNlJQS/Q4WvFjoFs1LjbbNDzRQ=;
        b=31nskr9Soe0iuTR+/fPkW7xynILICuUkOSYcxypo48v/1UdoS5ARaqpmqsMv5LbbAr
         Wyj/qB/K4MDO5RB7ldUW7DQmiPzFk0qjH622Hy8hLCMFDX5wAzAkhluZQoA+erEuY9br
         cA6kDkKSvlHbKR4ZKG+PVB2GAIG7S7oWp9u/sW9lucIQHMFAQxdE5jdTbEdbYWKCmLYw
         TAtrV95jrlQzNbOBNJ2CaMWeij56bgqGoXYNddCRDVNqFhrzKiVoZeca+EPdoPQMv/LG
         pMgXCGh98bXE7BMa9fOMCUaPbqIMWD1vL1CBRuIufywVzFhrNFyqIwYEoGT2GWWsAGRf
         9vQA==
X-Gm-Message-State: AOAM533whHHXPNd+4SRmqvjiwUxZS5Co1m51y03EF3PGXc53hO7ntNer
        Kcw/LOQnHWyhxer7OaD7gA==
X-Google-Smtp-Source: ABdhPJyLEqAuMCay8xL9vGuZW1MrAQDWoCsfSOcxo2YtGomAaqJ23hZt9Cth7nv86v86G2h8D3cN4Q==
X-Received: by 2002:a05:620a:4553:b0:6a0:5280:defd with SMTP id u19-20020a05620a455300b006a05280defdmr13566534qkp.165.1654464077801;
        Sun, 05 Jun 2022 14:21:17 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006a5bc8e956esm10638778qkp.133.2022.06.05.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:21:17 -0700 (PDT)
Received: (nullmailer pid 3538420 invoked by uid 1000);
        Sun, 05 Jun 2022 21:21:14 -0000
Date:   Sun, 5 Jun 2022 16:21:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     horia.geanta@nxp.com, gaurav.jain@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        shawnguo@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        silvano.dininno@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy delay property
Message-ID: <20220605212114.GA3528129-robh@kernel.org>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
 <20220530180924.1792399-2-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530180924.1792399-2-vabhav.sharma@nxp.com>
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

On Mon, May 30, 2022 at 11:39:22PM +0530, Vabhav Sharma wrote:
> Add entropy delay property which defines the length (in system clocks) of
> each Entropy sample taken for TRNG configuration.
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> Reviewed-by: Varun Sethi <v.sethi@nxp.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index 8f359f473ada..1477294eda38 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -62,6 +62,12 @@ PROPERTIES
>        Definition: A standard property. Define the 'ERA' of the SEC
>            device.
>  
> +   - entropy-delay
> +      Usage: optional
> +      Value type: <u32>
> +      Definition: A property which specifies the length (in system clocks)
> +          of each Entropy sample taken.
> +

Seems like this could be common, but should be a time value (with unit 
suffix) rather than clocks. If not common, then needs a vendor prefix. 
Is this time to read a value or time between values produced? Not really 
clear from the description.

Rob
