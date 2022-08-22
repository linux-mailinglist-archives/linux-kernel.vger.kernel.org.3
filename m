Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB959C8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiHVTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiHVTaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:30:55 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDB5A2DA;
        Mon, 22 Aug 2022 12:26:11 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11c896b879bso14115638fac.3;
        Mon, 22 Aug 2022 12:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wfja3dpgpGFQd71CyL+Eqxhc94bh068SJCYS3i8QECM=;
        b=HgIvu92TsIdeaHEFEzFI2Rp0/9dvXoX6rDx5ntv6ma/PzNgdbdmCRh8WE9YQWiA5GD
         FlE3v98+/8zVheE1Q143O0693EyvHdYqMDAZM7kW4jGAbvnCuulICEOemYQOj4rhSAgh
         udLOYs5rqkVsgUmNHmMlQ2RXB7apriUUCIdhXP9vzc/DimEz9/VLDwzYObVJlLXJ4iPz
         tuffssZ7iHv9ae4UeWDQ8AiqijEfadWtlO/53u9Vl9a/VrJdNa0hFreZ1r4hG+KL6xXN
         N4e53Ic1M+GWN6CGfnX0x+xxyWelDEhqABJAIfcigi8/wSbN6RSy3HzW/2LQMPxbauWo
         FcFg==
X-Gm-Message-State: ACgBeo0dqrFj5A6jDHKtlLV7orSFYR7HPsU/bG//+K19pWMmVAylnu6l
        S3e/mhZTHuc/35ODcpMZag==
X-Google-Smtp-Source: AA6agR5lq+EcF8u5MMVPUiMEfbyTX71703uezHObOPXLNPPPqslQkYADJa6bf1poUrTi7HAaKRzczQ==
X-Received: by 2002:a05:6870:58a1:b0:118:8649:ab9e with SMTP id be33-20020a05687058a100b001188649ab9emr10124932oab.5.1661196370735;
        Mon, 22 Aug 2022 12:26:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 187-20020aca05c4000000b00343459324besm2739811oif.49.2022.08.22.12.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:26:10 -0700 (PDT)
Received: (nullmailer pid 315358 invoked by uid 1000);
        Mon, 22 Aug 2022 19:26:09 -0000
Date:   Mon, 22 Aug 2022 14:26:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mithil Bavishi <bavishimithil@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, sre@kernel.org, tony@atomide.com,
        linux@armlinux.org.uk, contact@paulk.fr
Subject: Re: [PATCH 09/10] dt-bindings: input: Rename twl4030-pwrbutton to
 twl-pwrbutton
Message-ID: <20220822192609.GA310932-robh@kernel.org>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
 <20220820071659.1215-10-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820071659.1215-10-bavishimithil@gmail.com>
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

On Sat, Aug 20, 2022 at 12:46:59PM +0530, Mithil Bavishi wrote:
> This changes the Documentation of the twl4030-pwrbutton to
> make it more generic as it can support other chips than
> twl4030 as well.

This should be part of patch 4.

> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  .../input/{twl4030-pwrbutton.txt => twl-pwrbutton.txt}        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/input/{twl4030-pwrbutton.txt => twl-pwrbutton.txt} (81%)
> 
> diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> similarity index 81%
> rename from Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> rename to Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> index 9a0b765d3..43addc04d 100644
> --- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> +++ b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> @@ -1,6 +1,6 @@
> -Texas Instruments TWL family (twl4030) pwrbutton module
> +Texas Instruments TWL family pwrbutton module
>  
> -This module is part of the TWL4030. For more details about the whole
> +This module is part of a TWL chip. For more details about the whole
>  chip see Documentation/devicetree/bindings/mfd/twl-family.txt.
>  
>  This module provides a simple power button event via an Interrupt.
> -- 
> 2.25.1
> 
> 
