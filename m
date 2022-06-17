Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DA550030
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380504AbiFQWsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378699AbiFQWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:48:37 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA959956;
        Fri, 17 Jun 2022 15:48:35 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id q11so5899118iod.8;
        Fri, 17 Jun 2022 15:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bo+VS2/FgKbFAhxMturh6GXboxGeeCzAc9Y8o4zwJDo=;
        b=3khUcC0l81JRL84td9Ohu9NtxoSqriJZJPUNgcZ9IBIk3PD13tZTHMLcBC+fYAw6WJ
         ou8s6UVb3txKy5MKjpjFLDDpM5wjZ3CK0NReLdzYwDmiLcxb8gJovp+ut7NNaF2vzAkm
         bksxdWDTbI/LYQDb5pZKISPZhB45LZHMFXJxSC91dO0O6uks/6+5wParddNrE+iehA8H
         UWH47YKCbt+1FZ+BIvvV0/NR7jJlx0kuhQaPVNo6JTjlAipiqeASP6QIz4mbqx5bawSm
         XhpX8j0gHNN92KcUSFvDdrrBZH0Ylb34b4jiNIdr2HIn4x10P+nQT/kbiITeEg7i0SE/
         RxpA==
X-Gm-Message-State: AJIora8BPAlOJSakyPQkZnYlKNl6sCBPM1FbymqSzkRwdcqkhiAJJuXU
        AaIzguR87T0Su7+3BSOoSw==
X-Google-Smtp-Source: AGRyM1t31k5wSJ9zBcj+tHjNiuF/jzQCLnGNBqtiS53l9BwLc6cEERMVCsJl31o7Vg6oOVUfNs2NhQ==
X-Received: by 2002:a05:6638:19c3:b0:335:be36:36ba with SMTP id bi3-20020a05663819c300b00335be3636bamr6572686jab.28.1655506114456;
        Fri, 17 Jun 2022 15:48:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c904000000b003318614511bsm2740467jao.161.2022.06.17.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:48:34 -0700 (PDT)
Received: (nullmailer pid 2581654 invoked by uid 1000);
        Fri, 17 Jun 2022 22:48:32 -0000
Date:   Fri, 17 Jun 2022 16:48:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: renesas,hscif: Document r8a779f0
 bindings
Message-ID: <20220617224832.GA2581596-robh@kernel.org>
References: <20220613131007.10027-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613131007.10027-1-wsa+renesas@sang-engineering.com>
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

On Mon, 13 Jun 2022 15:10:07 +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
