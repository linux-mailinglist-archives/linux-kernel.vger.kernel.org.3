Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65D4D5511
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbiCJXKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbiCJXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:10:31 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C59199E18;
        Thu, 10 Mar 2022 15:09:30 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so5113293otl.6;
        Thu, 10 Mar 2022 15:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XksAC2LsaUpFUYISiC85YDy12CfZUY+BfAjOruDPrI8=;
        b=bn22AlwPgW+VjZOqneggTRz5ASTfu5GrM5tDKU9WSHysr8dMvoW5VB7eFqeRsn3RcJ
         T5U5RFR9Wyh9yCRNlPHQiovdd8yY08wJGCGKWmyvJYs7GxsmqFSBruMfUJzzAgc2mX/Y
         7zBy9nnKGhq7c5gyuG2bhOk6DE4FMEkXUWJn28GIx5Mbkv1743jambmyeaMLYASWwYzZ
         VGmFLCF1dT3yqYHSERUBnArSRdFptsJ43wBVg8j+UcOPUSVwHOuWqBZQ7V7SlP7TiOJQ
         bkLr6+umQ3068MVhb28MpyqbG41WFjXynL1/6yrFvSSwn+c29VgQm3wNCzws4BtsXogu
         EWJA==
X-Gm-Message-State: AOAM531NCir94QFjj0IJxtRcOKfae/f6tDIzAeYbMOFR2zoIIjfnd6C1
        DhlY2K+7c3MszDPNWm7HoA==
X-Google-Smtp-Source: ABdhPJxE/niFMjlw9YLuU12WYIz7yl2knTfT1RoTNVsWv8hMToO+k0ql1+QK+BAtS/YsOln5O30vxg==
X-Received: by 2002:a05:6830:187:b0:5b2:2092:836 with SMTP id q7-20020a056830018700b005b220920836mr3770395ota.323.1646953769321;
        Thu, 10 Mar 2022 15:09:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a056870028600b000d9be0ee766sm2751638oaf.57.2022.03.10.15.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:09:28 -0800 (PST)
Received: (nullmailer pid 2266309 invoked by uid 1000);
        Thu, 10 Mar 2022 23:09:27 -0000
Date:   Thu, 10 Mar 2022 17:09:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzysztof.kozlowski@canonical.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Message-ID: <YiqFJ+1l/h7XCQkN@robh.at.kernel.org>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
 <20220309102118.8131-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309102118.8131-3-peng.fan@oss.nxp.com>
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

On Wed, Mar 09, 2022 at 06:21:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QM compatible
> 
> There are two general purpose M4, so add reg property to indicate the
> id.

Where does the id come from? Is this just an index?

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index f25c203dd2f9..41d366cff3cd 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -20,6 +20,7 @@ properties:
>        - fsl,imx8mn-cm7
>        - fsl,imx8mp-cm7
>        - fsl,imx8qxp-cm4
> +      - fsl,imx8qm-cm4
>        - fsl,imx8ulp-cm33
>        - fsl,imx7d-cm4
>        - fsl,imx7ulp-cm4
> @@ -68,6 +69,9 @@ properties:
>    power-domains:
>      maxItems: 8
>  
> +  reg:
> +    maxItems: 1
> +
>    rsrc-id:
>      description:
>        This property is to specify the resource id of the remote processor in SoC
> -- 
> 2.30.0
> 
> 
