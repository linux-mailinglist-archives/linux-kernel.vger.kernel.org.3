Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75052AF25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiERAZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiERAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:25:33 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E726133;
        Tue, 17 May 2022 17:25:32 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e189so857039oia.8;
        Tue, 17 May 2022 17:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PN69YcQuRroEf0QfFtNKCNOl7n65i1negbEM5qktIY=;
        b=38J75vJgBiDnzThl1r83jA1e5GVsND80GTR9dVBmYbG3pLPUZqRoLTZRbAPcpivp7J
         BKbmrjsI88AvAQWEm9rinVHXT90ylEGZ8xFi82wsDSXVpy79IeTjebqkYRWzmwSxg8tb
         NdSp8frBLTcY2WJe6AM2u3ft4qGIykgMNl9lEV+A+JH6zlaZL12tT8MrjakLQDLTICkn
         wMZh9Re/GzQk/QiyRjrdyIFkxTQVGUeYGwS2fQYK1dOncli+fXSTPaQvHTrVW458lkf9
         52xXEL1xKAV3GdhA10VD+BPvLCPQraUKKm6kMncN607HqJngk4mBREgPHNatzayQYOyR
         XIWg==
X-Gm-Message-State: AOAM533FSeLi2eEQsgHtQgY3EOZ4wNGwGBX3dvzPNyETYjsQu9+vMw5M
        ylbVIRthXw7uH9Zhv/xwpw==
X-Google-Smtp-Source: ABdhPJziK8pztuaPLKL5LYFdMFqO/56+2LtDMRgd6gaQ462+ZfsGb5YXE9b65MNQRYlF7QOm36X91Q==
X-Received: by 2002:a05:6808:151f:b0:328:aaa2:10b8 with SMTP id u31-20020a056808151f00b00328aaa210b8mr17147368oiw.60.1652833531280;
        Tue, 17 May 2022 17:25:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v196-20020acaaccd000000b00325cda1ff8fsm318670oie.14.2022.05.17.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:25:30 -0700 (PDT)
Received: (nullmailer pid 1933964 invoked by uid 1000);
        Wed, 18 May 2022 00:25:29 -0000
Date:   Tue, 17 May 2022 19:25:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, krzk+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
Message-ID: <20220518002529.GA1928329-robh@kernel.org>
References: <20220511214132.2281431-1-heiko@sntech.de>
 <20220511214132.2281431-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511214132.2281431-2-heiko@sntech.de>
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

On Wed, May 11, 2022 at 11:41:30PM +0200, Heiko Stuebner wrote:
> The Zicbom operates on a block-size defined for the cpu-core,
> which does not necessarily match other cache-sizes used.
> 
> So add the necessary property for the system to know the core's
> block-size.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index d632ac76532e..b179bfd155a3 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -63,6 +63,13 @@ properties:
>        - riscv,sv48
>        - riscv,none
>  
> +  riscv,cbom-block-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Any value 0-2^32 is valid? 

> +    description:
> +      Blocksize in bytes for the Zicbom cache operations. The block
> +      size is a property of the core itself and does not necessarily
> +      match other software defined cache sizes.

What about hardware defined cache sizes? I'm scratching my head as to 
what a 'software defined cache size' is.

> +
>    riscv,isa:
>      description:
>        Identifies the specific RISC-V instruction set architecture
> -- 
> 2.35.1
> 
> 
