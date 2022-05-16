Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01E528D66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbiEPStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiEPStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:49:16 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE993EAAD;
        Mon, 16 May 2022 11:49:15 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so10673652otk.1;
        Mon, 16 May 2022 11:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtCUUUT+nHAc8CW7oHLx12ILRqYzV6X9OXA+TWI+EEw=;
        b=z0HbrgTnEKZxtnHVeZPk14h5kqRkhbW0mC3tagI4rdbbiF3yIMXNmWzVk61YGV16aI
         X4SBmvTU0jmYwE93EQUCmTUCSfEpzxrIvBULPtfNUjlOID1vdb5nD65OF0QQon1EFDDl
         SmAhjPX8dCrBVreFuhDDE+SOVSi9YSiiw2W4wkkDWTe5bLWmY733jsUu3j0dbZzIyH4W
         xBlMbAibV7vJmxNuQCZ2BbO0i2JkVGGh5GWtTDg1RTP1RYa7009QQ9dCYCCbyC+LwAb1
         8hI0DuBvG0WEGsVHcX3vwtjhM63eF6JDTGnjAUgZfhbv5d8VY4T5eRx/0Kaj18YRy+pA
         igPw==
X-Gm-Message-State: AOAM533MrgsVpcDHHhgONu+WCgRp+KMJ+3HDpdLdnCNrCkOJ/YNKcfBm
        3QU1Q12P/At63+DcRG1q5Q==
X-Google-Smtp-Source: ABdhPJxWWS6qu5qSJOpfAr1qWYqIWns8KVfKkkW1r2Y0uSLIoj2zOsjB8OHgBlBnp2+p9gsPvcRjZQ==
X-Received: by 2002:a05:6830:264f:b0:606:7dbc:aebb with SMTP id f15-20020a056830264f00b006067dbcaebbmr6641366otu.93.1652726954709;
        Mon, 16 May 2022 11:49:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m19-20020a4add13000000b0035f627ac898sm4375618oou.10.2022.05.16.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:49:13 -0700 (PDT)
Received: (nullmailer pid 3068015 invoked by uid 1000);
        Mon, 16 May 2022 18:49:12 -0000
Date:   Mon, 16 May 2022 13:49:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
Message-ID: <20220516184912.GA3063673-robh@kernel.org>
References: <20220503154353.4367-1-ansuelsmth@gmail.com>
 <20220503154353.4367-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503154353.4367-3-ansuelsmth@gmail.com>
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

On Tue, May 03, 2022 at 05:43:53PM +0200, Ansuel Smith wrote:
> Document new qcom,boot_pages binding used to apply special

s/boot_pages/boot-pages/

> read/write configuration to boot pages.
> 
> QCOM apply a special configuration where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> index 84ad7ff30121..fafeca0cafff 100644
> --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> @@ -102,6 +102,26 @@ allOf:
>              - const: rx
>              - const: cmd
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-nand
> +
> +    then:
> +      properties:
> +        qcom,boot-pages:
> +          $ref: /schemas/types.yaml#/definitions/uint32-matrix

You need to define the dimensions. Something like this:

             items:
               items:
                 - description: offset
                 - description: size

> +          description:
> +            Some special page used by boot partition have spare data
> +            not protected by ECC. Use this to declare these special page
> +            by defining first the offset and then the size.
> +
> +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> +
> +            Refer to the ipq8064 example on how to use this special binding.
> +
>  required:
>    - compatible
>    - reg
> @@ -135,6 +155,8 @@ examples:
>          nand-ecc-strength = <4>;
>          nand-bus-width = <8>;
>  
> +        qcom,boot-pages = <0x0 0x58a0000>;
> +
>          partitions {
>            compatible = "fixed-partitions";
>            #address-cells = <1>;
> -- 
> 2.34.1
> 
> 
