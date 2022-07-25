Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A838C5807DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGYW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGYW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:56:59 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F371EC61;
        Mon, 25 Jul 2022 15:56:54 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso9698456otb.13;
        Mon, 25 Jul 2022 15:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8G3Mm+NgIeVbS725ckPK31yPoR4kpxEiiHwhot9k/Nc=;
        b=HyGnRurHgjFGzkE6AJ032h8SPiAO0SR9z2mRe6skYcmbFeGVZyLNtERRR54VWE/PJl
         cs+bk3CKFbDtVASg2Gkd2eQCo7tA+TiqZ1ilPPAhy2cDQLEbHiA9l7AivbRzpft0aHUb
         uIpY8SaLWrVRSW00C/EnQEs0IDmhqn76lrALGxdwaohOtAjvGz2djFAFlkfXY9XL5cFw
         e8kNTR8II+dY6ZIFsdZ0GnOfOC3KDsgeolFnZXmklGQzx3nfARt0Fe3ewG5kezRik1QM
         55obWTW5VZWTCJI8e+4vHpqoFH0rU4ngwRhwgMP1BSlaokCxwUT5/4GRvGCEQBWTo4pR
         pfJA==
X-Gm-Message-State: AJIora8XyyzYPdPF4Cix/hkPQxm7KzG5PWx0Rb+f7vCEiEKi9fJ9QCuI
        WsSWBo2Yfui1UzbyCtqbRziAMAq3bw==
X-Google-Smtp-Source: AGRyM1uK8ktfyXTn2VznXnPkErlmaz2g0keJTy1EP9+gYpUQVBWi5vIvutDGqn2Kvhy6iuZ6pso49A==
X-Received: by 2002:a9d:7a59:0:b0:61c:e43d:eaec with SMTP id z25-20020a9d7a59000000b0061ce43deaecmr5770927otm.7.1658789813917;
        Mon, 25 Jul 2022 15:56:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568301e8800b0061c530ec022sm5445611otr.79.2022.07.25.15.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:56:53 -0700 (PDT)
Received: (nullmailer pid 2904901 invoked by uid 1000);
        Mon, 25 Jul 2022 22:56:50 -0000
Date:   Mon, 25 Jul 2022 16:56:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
Message-ID: <20220725225650.GA2898332-robh@kernel.org>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722114136.251415-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:41:35PM +0300, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 PSPI.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> index b98203ca656d..a4e72e52af59 100644
> --- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
> @@ -3,7 +3,8 @@ Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
>  Nuvoton NPCM7xx SOC support two PSPI channels.
>  
>  Required properties:
> - - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
> + - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.

Who/What is Polog? Board/BMC vendor? If so, that should not be in SoC 
bindings.

> +				"nuvoton,npcm845-pspi" for Arbel NPCM8XX.

Same for Arbel.

To answer your question on fallback, just put:

    "nuvoton,npcm845-pspi", "nuvoton,npcm750-pspi" for NPCM8XX BMC


>   - #address-cells : should be 1. see spi-bus.txt
>   - #size-cells : should be 0. see spi-bus.txt
>   - specifies physical base address and size of the register.
> -- 
> 2.33.0
> 
> 
