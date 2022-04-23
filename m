Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B450CBED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiDWPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiDWPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:47:45 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A782DA96
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:44:47 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-deb9295679so11724211fac.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WI4v9jTbsIcKFzbTFV4CkXCBay54N1Oo0tLcKG2okuk=;
        b=GuCc7g12xSirTqULiexO/HNajNdmFb2nq0eVlcaz0hWMdnxOMIk5AeBAMqPyL0rYVl
         MyvXwBc0tDxT1g1wi/Na74VHs+MMpCLVOCNuBRnNQYccRZvr/MHAzIyK7mu7VWVpRxnS
         2zWuzRZCM9bVznfcRL1kSJRE+M+CxxTBdcY92OfyTcIYJBFBWe4C0NRAKHjdSUIVENHC
         Xy4MWQrTivSTA6Ul6V8DvmPaHa+OhENFObjP1VJjSASeTRgGypP/0vY2zI0L8UwjUDoG
         GUiSkSQlPu2plfvN4ZygVwuRULWkCX/AT5k4dMY1vakwjk16RPIUsOeK/9prQjRUtz9q
         LvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WI4v9jTbsIcKFzbTFV4CkXCBay54N1Oo0tLcKG2okuk=;
        b=LRp0XY7AnmsqD3QabU+7n1hWUjb8rMmdBLRIG45XG3Bft9SARJlf5lCNBsk2QOtGxg
         u9QcPR1EwCOXlFslMDXxzGI9zOuAV+R9/n+Bx6CxOjAIRAlEWAbIgZRF78r6sgDz8QKh
         eeduDNqA41KHirVAqjLZzBYRGYz5tzhI5KwKENWUI8pS9JTclIdWtfoQOpsHyXlO3jJj
         7EKesU2sCTIjLcV+gFPM4xFXYuLRdbg5ktqZ9HzSSUcvyy50RCqXyKJ9uDeM/8AXwgoC
         TshTZtI3EXPlg/jKaGSOOG0OLbt+xScMApVCyvcCoWmDNRqD7CFgPEnyHFZXDb7x3jgE
         RAEw==
X-Gm-Message-State: AOAM5323f5ZaoolfgDHS37d9FKSk+grE4eWg3XaXNJKmSbyJPGU9JMYi
        w4WHPNGfMvECAyzF6yeUii4JUw==
X-Google-Smtp-Source: ABdhPJwhzqzGCODM05j5yChA14I3TniITfBb/T0zYrHKD6GGVSxGnliKR/rMO0K34IDB5CGKJF3asg==
X-Received: by 2002:a05:6870:4414:b0:e6:244f:78ba with SMTP id u20-20020a056870441400b000e6244f78bamr7984019oah.201.1650728687284;
        Sat, 23 Apr 2022 08:44:47 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id g25-20020a544f99000000b002da70c710b8sm1933901oiy.54.2022.04.23.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:44:46 -0700 (PDT)
Date:   Sat, 23 Apr 2022 08:46:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: qcom,qmp: Mark '#clock-cells'
 as a 'optional' property
Message-ID: <YmQfZ+h5tD6KbMID@ripper>
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
 <20220418205509.1102109-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418205509.1102109-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Apr 13:55 PDT 2022, Bhupesh Sharma wrote:

> '#clock-cells' is not a required property for qmp-phy(s) in the
> '/' node, but it should be is used in 'phy@' subnode (where it is
> actually a 'required' property). Fix the same.
> 

It's not that #clock-cells is "not a required property", it's that the
clock comes out of the phy (the child node), so there is no clocks
provided by the parent device.


Please rewrite the commit message.

> This also fixes the following 'make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   '#clock-cells' is a required property
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 8b850c5ab116..c39ead81ecd7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -66,9 +66,6 @@ properties:
>        - description: Address and length of PHY's common serdes block.
>        - description: Address and length of PHY's DP_COM control block.
>  
> -  "#clock-cells":
> -    enum: [ 1, 2 ]
> -
>    "#address-cells":
>      enum: [ 1, 2 ]
>  
> @@ -112,11 +109,13 @@ patternProperties:
>      description:
>        Each device node of QMP phy is required to have as many child nodes as
>        the number of lanes the PHY has.
> +    properties:
> +      "#clock-cells":
> +        enum: [ 0, 1, 2 ]

The commit message doesn't mention the fact that 0 is also a valid
value. Perhaps just keep it [1, 2] in this patch?

Regards,
Bjorn

>  
>  required:
>    - compatible
>    - reg
> -  - "#clock-cells"
>    - "#address-cells"
>    - "#size-cells"
>    - ranges
> @@ -468,7 +467,6 @@ examples:
>      usb_2_qmpphy: phy-wrapper@88eb000 {
>          compatible = "qcom,sdm845-qmp-usb3-uni-phy";
>          reg = <0x088eb000 0x18c>;
> -        #clock-cells = <1>;
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges = <0x0 0x088eb000 0x2000>;
> -- 
> 2.35.1
> 
