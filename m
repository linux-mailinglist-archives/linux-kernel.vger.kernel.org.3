Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78D9496749
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiAUV1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:27:12 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46835 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiAUV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:27:11 -0500
Received: by mail-ot1-f45.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so13324225otc.13;
        Fri, 21 Jan 2022 13:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGElPy2VACsBdFnkh6MdJpINb1+42Tm0MAH//73tJqU=;
        b=i3s+iJXS1gZIBPTtdd4e/MuWxyzSod+QeWAzlYvA2jMCz7R3Ye9BAqP7vkyJC9ARn/
         IP0n6oou/9SnRmSm3E5FsPbrQM7tgeo1gQV0nTDC3gB2H6Q1NHTti/E/JPL05iFwj3XP
         thDH3VcMvgRZCSjfTwsbb1bUt5o7JEA/i4DC+f6YvEEjXw3qwjELuck5V8vQV015VPfO
         TK9LEfH8uvNeu+08z3Vxbw3pRQHDxY35F6XweGI4GvDIemiI+X7/luiu5Yo4jpfS18kD
         y+NvJEVUvNGHmoT37d9SD2/rCaOAl0NwltB2t4TpylUvvGxBB89cervnBgJaj6l6V5E0
         ULyA==
X-Gm-Message-State: AOAM530SWrTqjFmAi4AbSRHV8BxDQCfeULLu1b5WcTJLNpYjiHcDTK0y
        Mg04iE+B1Z6M42XmzCceKA==
X-Google-Smtp-Source: ABdhPJwygzWkhErXMaYWnI0oDmdrjDawCFds/EJVU76juuAX/N0kolybjRGafXge9r46h1+sDrkEcA==
X-Received: by 2002:a9d:2ae9:: with SMTP id e96mr4103155otb.130.1642800430655;
        Fri, 21 Jan 2022 13:27:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh10sm1735740oib.24.2022.01.21.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:27:09 -0800 (PST)
Received: (nullmailer pid 1614542 invoked by uid 1000);
        Fri, 21 Jan 2022 21:27:08 -0000
Date:   Fri, 21 Jan 2022 15:27:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: imx8m-noc: Add
 fsl,icc-id property
Message-ID: <YeslLJqwhX668+oa@robh.at.kernel.org>
References: <20220106164150.3474048-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106164150.3474048-1-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 06:41:48PM +0200, Abel Vesa wrote:
> Add documentation for fsl,icc-id property.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
> 
> Changes since v3:
>  * fixed typo in property description
> 
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> index b8204ed22dd5..dc7f6b6f508a 100644
> --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> @@ -47,6 +47,11 @@ properties:
>    operating-points-v2: true
>    opp-table: true
>  
> +  fsl,icc-id:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description:
> +      unique ID used for linking i.MX bus or ddrc node to interconnect

Where does this unique ID come from and how is it used? Why aren't cells 
in 'interconnects' sufficient for this?

> +
>    fsl,ddrc:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description:
> -- 
> 2.31.1
> 
> 
