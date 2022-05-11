Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C736523447
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiEKNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiEKNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:33:35 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E916CF6A;
        Wed, 11 May 2022 06:33:34 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id i66so2667776oia.11;
        Wed, 11 May 2022 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DW4Zo6I0qtUel+PxEOSPDTjH1lXWwkGs8gdgcVAYgw=;
        b=gn8gqNJxNpKt22bBNb2VSLkjGyG7DRInUTNB6CJpb7JLbrZJT61Fn0xvWAz8TNAE3U
         KxoagKRlq+iFNvxwHp3CbNHey1aV4Ri+RUZSpDQ7d7RnVK0kMwRPNExeBlxmoYe/I4ib
         VtgcHLmPmCHs1nImiX1xOGTTccMBFTq2HbP1gHGOWdq24l2oPQBhcBLrj5+noHUVXc5P
         ATBBs01DbcB82wtkelM3Ty8U0xgVLbgGHejBv84M5wxKz2+VQGxbppRQzHb/yktBOP5D
         36rn8NTEouSmMPFP7h8DtGhHjRymxD+QnLiyilbkGnNyZ8nQXVhL5bg8qlYUWdW+Z869
         G11g==
X-Gm-Message-State: AOAM5338GQI/W10fLh4TEM7NegkCQbHgE36V+jDlwPu5Bu5hQgL/rF6t
        JeuAsWGVXAIJkFQvATmOfTGeBr1Csw==
X-Google-Smtp-Source: ABdhPJwG1tYUKi5wD7Ar62zqbqLO+MgmnmzlJd9Sjcj58rJ+Oh3zmGJvqGliThZhV2w2e7nZu6yvNw==
X-Received: by 2002:a05:6808:211e:b0:326:828a:6901 with SMTP id r30-20020a056808211e00b00326828a6901mr2455777oiw.115.1652276014183;
        Wed, 11 May 2022 06:33:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q64-20020acad943000000b003264e122a9asm714139oig.54.2022.05.11.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:33:33 -0700 (PDT)
Received: (nullmailer pid 177414 invoked by uid 1000);
        Wed, 11 May 2022 13:33:32 -0000
Date:   Wed, 11 May 2022 08:33:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 04/10] dt-bindings: riscv: microchip: document icicle
 reference design
Message-ID: <20220511133332.GA177299-robh@kernel.org>
References: <20220509142610.128590-1-conor.dooley@microchip.com>
 <20220509142610.128590-5-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509142610.128590-5-conor.dooley@microchip.com>
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

On Mon, 09 May 2022 15:26:05 +0100, Conor Dooley wrote:
> Add a compatible for the icicle kit's reference design. This represents
> the FPGA fabric's contents & is versioned to denote which release of the
> reference design it applies to.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
