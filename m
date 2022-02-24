Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B44C38C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBXW21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiBXW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:28:24 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968F18647B;
        Thu, 24 Feb 2022 14:27:53 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 12so5378068oix.12;
        Thu, 24 Feb 2022 14:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Q++PXwW9clpi7EmUird58cb/RjCfYTbDPWAmQD/krg=;
        b=NSo23BsF2GcfnuiMY8/Bu9zL5r13ggcTQnCjF85JGFDk1UWLEgPIy68ELSPyxXSOuH
         eCpbzINZ1A26MdgQX7svi0YMHWVsqSHgMtLwAxzyd8OYTg/vZo3p2P1EgTlwVu4ToueA
         y4HxyIHJnQJSzDtb5YBNF0y+hLBPMUpqUmHGu9mV6l4x5hh5LyRVa+pAjYw4Y/yWUtpA
         0mZqT9P+snQuzeakOI8k7LCmGBS1HMhULNM17/OTjD/+Hj0rsVELfxNXK9d4ioCXd0iv
         Xc1j5WlTbMo8mLWjYXe/aSsKzqzIzxCx1U98jrtj1vJ4/qC5KJOZ/lhp6LPzSWHA9AYS
         0BVQ==
X-Gm-Message-State: AOAM5332E/hOu70RSLpCBcoSUYkNAanZLnT7ZgXaO9Zyw18+ycPe6e/B
        NEhhnSTGSQdDdndZbpmY2Q==
X-Google-Smtp-Source: ABdhPJwx1FD+9eKPTOob58IWuDiHkaicOqaAuTjSLNRT4GyVqROrjSgeyKYq9MX8Tmms8n9PZP6B/A==
X-Received: by 2002:a05:6870:3121:b0:d2:8163:fd04 with SMTP id v33-20020a056870312100b000d28163fd04mr128825oaa.182.1645741673280;
        Thu, 24 Feb 2022 14:27:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l34-20020a9d1ca2000000b005acea92e8absm290399ota.42.2022.02.24.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:27:52 -0800 (PST)
Received: (nullmailer pid 3704065 invoked by uid 1000);
        Thu, 24 Feb 2022 22:27:51 -0000
Date:   Thu, 24 Feb 2022 16:27:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: input: touchscreen: edt-ft5x06: add
 report-rate
Message-ID: <YhgGZylBoxlou9ka@robh.at.kernel.org>
References: <20220217165559.313366-1-dario.binacchi@amarulasolutions.com>
 <20220217165559.313366-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217165559.313366-2-dario.binacchi@amarulasolutions.com>
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

On Thu, Feb 17, 2022 at 05:55:53PM +0100, Dario Binacchi wrote:
> It allows to change the M06/M12 default scan rate.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index 2e8da7470513..aa8517c6f65b 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -85,6 +85,14 @@ properties:
>      minimum: 0
>      maximum: 80
>  
> +  report-rate:

Use property unit suffix: report-rate-hz

This should probably be moved to touchscreen.yaml as it seems common.

> +    description: Allows setting the scan rate.
> +                 M06 supports range from 3 (30 Hz) to 14 (140 Hz).

You're using 3 or 30 in this case? Should be 30, but it's not clear. I'd 
just list the range in Hz and leave the conversion detail to the driver.

> +                 M12 supports range from 1 (1 Hz) to 255 (255 Hz).

Use '|' if formatting (newline) is significant.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 255
> +
>    touchscreen-size-x: true
>    touchscreen-size-y: true
>    touchscreen-fuzz-x: true
> -- 
> 2.32.0
> 
> 
