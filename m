Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7220754EB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378690AbiFPUap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiFPUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA05DA16;
        Thu, 16 Jun 2022 13:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A09261DF0;
        Thu, 16 Jun 2022 20:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22396C3411B;
        Thu, 16 Jun 2022 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655411436;
        bh=stQjKK5hULXhgTZqMOZMxI+VoTvhtjbBez+S+FBZsCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZ4taM7oD2t6T/xFHt/VoFygBcFsniVKbkMkrfaaYMsNCCxWfR5PxbjAdaCDJXywN
         Py8FZ20KJd+rCsN4btXh4HfcUP1sYkIFRQAqmKtDcJGxZWm24fYoSnJFIhJA+T27YG
         TVkq5YYEHa8uIDKvzctvf3sOCu8V4P38aBlC2dPFSFXOre2LYYVt/jJ2qqCgguDDeT
         /cgUjrCIPWGanGM8KLwuue8bdCFCv9yPAG26EIhXUVsaPmKJOO52Ekkz9NcN1k5qMQ
         L4Yk3IEkwnu3zrRgjgwqNXxiEqQgevO3eDvaQ+6tO45lRbf21Pb3SiRrG2X6v4sMHK
         kn2f51c7b5ANQ==
Date:   Fri, 17 Jun 2022 02:00:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-partitions binding
Message-ID: <20220616203035.GE2889@thinkpad>
References: <20220616001835.24393-1-ansuelsmth@gmail.com>
 <20220616001835.24393-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616001835.24393-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 02:18:35AM +0200, Christian Marangi wrote:
> Document new qcom,boot-partition binding used to apply special
> read/write layout to boot partitions.
> 
> QCOM apply a special layout where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> index 84ad7ff30121..482a2c068740 100644
> --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> @@ -102,6 +102,31 @@ allOf:
>              - const: rx
>              - const: cmd
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq806x-nand
> +
> +    then:
> +      properties:
> +        qcom,boot-partitions:
> +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +          items:
> +            items:
> +              - description: offset
> +              - description: size
> +          description:
> +            Boot partition use a different layout where the 4 bytes of spare
> +            data are not protected by ECC. Use this to declare these special
> +            partitions by defining first the offset and then the size.
> +
> +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> +            and should be declared in ascending order.
> +
> +            Refer to the ipq8064 example on how to use this special binding.
> +
>  required:
>    - compatible
>    - reg
> @@ -135,6 +160,8 @@ examples:
>          nand-ecc-strength = <4>;
>          nand-bus-width = <8>;
>  
> +        qcom,boot-partitions = <0x0 0x58a0000>;
> +
>          partitions {
>            compatible = "fixed-partitions";
>            #address-cells = <1>;
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
