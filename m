Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74D4C81CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiCAD4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCAD4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:56:01 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6953BA6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:55:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bd1so12409823plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=15kO8bfahYJFiPLc1vZ8MJvVn1yYn8uPD0/+xIeiCzc=;
        b=EilyBazjY/CYJQ2FvktcGrpjYVDdZSwf5yyYmaY2goT1gbFkaye+c/ckNkZ1Ll8blJ
         Qr/rn5vksZA7AEnaBQFwQYJ18o+zYovqOqyhI6bNQoPdojEebEUPpLl3Ge4IUxL3ZVaf
         b7XjY+WneeUPE6Y3qY/mjHPmWQ+6/3Vs5p6Sc7IOcxBXxqS2CvuUweE69Fj2voyDSG23
         Zz1TNbiS3kDJA9NKKYrG8oAjeQj4EfLjaIsDIfj5WeeY60lz+M6TkMgj9xtpgufbSMk4
         NNsw8u3iKQOC9qva2Gsn3n2Ztopd/HR/UVTasU3n49dl7GAZZmvBamIvfylHv/pEzB57
         qqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15kO8bfahYJFiPLc1vZ8MJvVn1yYn8uPD0/+xIeiCzc=;
        b=FEZZ7VUdKVObLC5utvBmpggMHPcI7vViPppgbNfvxKzLzVCj2CW3qWSRbbJZ/qO7tb
         KYp2KJ5S+yjYTtO6yx9vldBzYbZqAImiN6/UA9mammcghvKGqISVxPJqKIkY3R0V0F9R
         fuKwi4SLT7HB87Saa2Jt/VBz2Pdfs+zpS5hRIMjOmCWcouGeuTjBQfwxFUeQ3W6Z9AIa
         JAQSmoCtXHuFmC1ZOCSsF+pSfvjx5BLstWzXYcpu6nlHlwWNQSwJWlQqHlptGcWy4NzT
         6usvrxcLB02/0fXpZaWZcYtRXW4F1shBi54d1wxDj0xjtWWk+/qlNz+t9FCq9nJThYI3
         GPOw==
X-Gm-Message-State: AOAM531mQUXgSUZCB4hKBAT1Bw0W0eyTOewTrZ3ocHu7tUSPtE9gJEQL
        wjjhEtyxczLh2ai2DXxJ1Z/hUA==
X-Google-Smtp-Source: ABdhPJxuiB7k3oJfg/cJ8oTZlkYgj+RGZQnKNSV1zCmzNyKWhT6YBLHZprxiz8RDQXnXGJu5GNMQAQ==
X-Received: by 2002:a17:902:9a02:b0:14f:2d93:92f4 with SMTP id v2-20020a1709029a0200b0014f2d9392f4mr24778661plp.160.1646106921016;
        Mon, 28 Feb 2022 19:55:21 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id h12-20020a056a00218c00b004c3a2450acasm16045071pfi.147.2022.02.28.19.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 19:55:20 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:55:14 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: phy: qcom,qmp: Mark '#clock-cells'
 as a 'optional' property
Message-ID: <20220301035514.GE269879@dragon>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:00:12PM +0530, Bhupesh Sharma wrote:
> Since '#clock-cells' is not a required property for qmp-phy(s)
> (atleast in the '/' node, but is used in 'phy@' subnode),
> so mark it as an optional property instead.

My understanding is that '#clock-cells' shouldn't be a property of qmp-phy
node itself at all (not even optional), but a required property of 'phy'
subnode.

> 
> This fixes the following 'make dtbs_check' warning(s):
> 
> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>   '#clock-cells' is a required property
> 
> Also, make the dt-bindings confirm to changes
> already made via commit 82d61e19fccb ("arm64: dts: qcom: msm8996:
>  Move '#clock-cells' to QMP PHY child node"), by moving
> '#clock-cells' property from the '/' node to the 'phy@' subnode.
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
> index e417cd667997..48cd6b6171a1 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -63,9 +63,6 @@ properties:
>        - description: Address and length of PHY's common serdes block.
>        - description: Address and length of PHY's DP_COM control block.
>  
> -  "#clock-cells":
> -    enum: [ 1, 2 ]
> -
>    "#address-cells":
>      enum: [ 1, 2 ]
>  
> @@ -109,11 +106,13 @@ patternProperties:
>      description:
>        Each device node of QMP phy is required to have as many child nodes as
>        the number of lanes the PHY has.
> +    properties:
> +      "#clock-cells":
> +        enum: [ 0, 1, 2 ]

I'm not sure how to specify this is a required property for the child
node.  Or is this already the case, @Rob?

>  
>  required:
>    - compatible
>    - reg
> -  - "#clock-cells"
>    - "#address-cells"
>    - "#size-cells"
>    - ranges
> @@ -461,7 +460,6 @@ examples:
>      usb_2_qmpphy: phy-wrapper@88eb000 {
>          compatible = "qcom,sdm845-qmp-usb3-uni-phy";
>          reg = <0x088eb000 0x18c>;
> -        #clock-cells = <1>;

These two changes look good to me.

Shawn

>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges = <0x0 0x088eb000 0x2000>;
> -- 
> 2.35.1
> 
