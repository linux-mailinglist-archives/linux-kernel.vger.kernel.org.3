Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7609519103
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiECVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiECVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:55:12 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF12F387;
        Tue,  3 May 2022 14:51:39 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e5e433d66dso18525465fac.5;
        Tue, 03 May 2022 14:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mufD53y5m93auFkRsBYFt8Hu8B8QkCw7tadNt8CTlQ0=;
        b=3LaYWsz6BMIS8djNYlGDd3yQkCTaTpRi8dqj+Q1tXtga4aytIjaBjeFTixZw/XkTif
         G+0RUn95u41IQGeDybWdB8g6t6YHRZCuVys7tqvr7uJhNatVSmxeW40HBfM3aZ6dHifx
         AGtqYWK/DtzAise/vdV4EP4icbxV6gD5m1Rl+sbNuV66mWBPZLVunzO5/a5oswrMtXQS
         mxh+iBg0YCFQsJhCFuhKKRd/c4mAgziJB9dbP5/G48/ximn2GItXiBywiTBPCKSRl1IH
         NgXRcIAcAz0fd5qhniNarS0yk7E8xsZHlhH+2YJb6jP0n9Pb4tuiHKhfjXAxPhPsVLbr
         JZRQ==
X-Gm-Message-State: AOAM5319hnwnq6zco8mNduizY84YCKibkwdKCihY4HML2v0mAQ1Zr84C
        QJ6GL/srorKscUbOXoG+hGIxsBfgVQ==
X-Google-Smtp-Source: ABdhPJySBesfmCadidVN9N5StqxUW+dbQBwVygP33ZdYIZmO3wRh0veTKXl7gczZh4GqgzYI/r5Big==
X-Received: by 2002:a05:6870:8920:b0:e5:e38e:fd7c with SMTP id i32-20020a056870892000b000e5e38efd7cmr2563616oao.202.1651614698844;
        Tue, 03 May 2022 14:51:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i13-20020a54408d000000b00325cda1ffb9sm3707611oii.56.2022.05.03.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:51:38 -0700 (PDT)
Received: (nullmailer pid 95414 invoked by uid 1000);
        Tue, 03 May 2022 21:51:37 -0000
Date:   Tue, 3 May 2022 16:51:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Message-ID: <YnGj6eZGx+8gVKGW@robh.at.kernel.org>
References: <20220429131349.21229-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429131349.21229-1-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:13:48PM +0200, Pali Rohár wrote:
> GPIO is optional and used for WDI logic.

Nowhere is WDI defined.

> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> index ab9641e845db..a97aa0135ef9 100644
> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> @@ -27,6 +27,10 @@ properties:
>      description: This is a 1-byte memory-mapped address
>      maxItems: 1
>  
> +  gpios:

Usually, we want a name here. Maybe wdi-gpios, but I don't know what WDI 
is nor have I read the pin name in the datasheet for inspiration.

> +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.20.1
> 
> 
