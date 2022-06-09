Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27DC5450B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbiFIPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbiFIPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:23:51 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DFD4A90E;
        Thu,  9 Jun 2022 08:23:50 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y12so22467522ior.7;
        Thu, 09 Jun 2022 08:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=299eswKa0mqgY89iLNdNeNTHrmqc81eysaCt7mMgwl4=;
        b=Fr4DgBCj7JF8VchWptUZkZjtfouklK3q1ZrgETFak+V2GX7ar9ZG089MqgidsJm2R/
         M11hDBy3STx6aS2/1ti3ZyvjegQWzexL0z4rpMbomVxK5U7c/8eeEn8Jr3k4XcWs/Cb/
         uSGZ3BWXil/eS0Adsw8w67j60B3tMRR9FXk5vjv4BxZYIC2HEYFLb+nOXtUN+hyAJpK5
         UzwkDDtDBde42P4P2Uv9z4oPTpB6DGXcFOcVU0FKj/oPPwNQqCTNkYApGczb9P1BET2a
         WJ9SJjIROf/cmtdxYlazRmk0+ieoBKLM45u7SGl9RJ5veyse7giTNfeiNMQZtoHtM3oB
         QB6w==
X-Gm-Message-State: AOAM532I1sVjm4BwB6QgmG/pT32wsYrXsOJjwjP/ougVjf0hhvERv04n
        zSoxX7xyoQNiZqk/urG/Ng==
X-Google-Smtp-Source: ABdhPJxR1sQ+xMuX17YD4idTrOjOgFbxdnCi8dxeDujaZEfF4hOYNX5amM4P1hmcO4KrqLUgcC/Z/g==
X-Received: by 2002:a05:6602:2c41:b0:669:8bcf:c6a6 with SMTP id x1-20020a0566022c4100b006698bcfc6a6mr4956029iov.15.1654788229795;
        Thu, 09 Jun 2022 08:23:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b12-20020a5edc0c000000b00669a3f60e99sm1774533iok.31.2022.06.09.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:23:49 -0700 (PDT)
Received: (nullmailer pid 3821183 invoked by uid 1000);
        Thu, 09 Jun 2022 15:23:47 -0000
Date:   Thu, 9 Jun 2022 09:23:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: add
 fsl,startup-delay-ms
Message-ID: <20220609152347.GA3817946-robh@kernel.org>
References: <20220609123500.3492475-1-peng.fan@oss.nxp.com>
 <20220609123500.3492475-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609123500.3492475-2-peng.fan@oss.nxp.com>
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

On Thu, Jun 09, 2022 at 08:34:59PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> add fsl,startup-delay-ms property indicating delay some time after just
> kicks remote processor.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)

What's the base? Doesn't apply to v5.19-rc1 for me.

> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index 64e783234e38..56f3ed18c28c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -76,6 +76,10 @@ properties:
>        This property is to specify the resource id of the remote processor in SoC
>        which supports SCFW
>  
> +  fsl,startup-delay-ms:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Standard unit types don't need a type. 'make dt_binding_check' should 
have told you this.

> +    description: Startup time that remote processor ready for communication
> +
>  required:
>    - compatible
>  
> -- 
> 2.25.1
> 
> 
