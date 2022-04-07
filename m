Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0848F4F87A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbiDGTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDGTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:05:07 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55722F3E5;
        Thu,  7 Apr 2022 12:03:05 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7376791fac.7;
        Thu, 07 Apr 2022 12:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NQ6NbUsNxmOVH45bPoaIurWw7GEZCEr+aG9zT4r8iZk=;
        b=GuoRTcHc9BrU1WYY4ew0sprG/1ibx9HAkoZBtsk2EU4K2wdeBUapN8cLb0MJQ7le78
         mjQjyVpVZ3HIt1uUPCAgZqXKXlW3MNllYpoJdi/ukqjpfGTscXalTxycvucAHG+3VBoZ
         xxfLn6uoB4IArcowu32vYvSt1Kly0TfJqbsMjRZy16Tk7KC3lIQlFdSyWpk7CtEKMvTo
         PvEtPJPRB9LNEdmrJo9e5N8Ixko4JH0nQg0FdwydYXO5gKiPEUHAHbZzlnCXZcnTUdFP
         2rAaoLOXyubMGgwGs6eacdencKwbAd54BpkCKwmJ30psMpbnrZpfZJItxvnzvQ50nr3I
         Eqzg==
X-Gm-Message-State: AOAM533Cf3w/zo0h0dIA4MKsEkN575MSVw+pkmm/wCRrEMk1CztQ6A4P
        COy7RkE9jkJKPjk8eXJJbM05NxX0Pw==
X-Google-Smtp-Source: ABdhPJwjcQsN14WCT4vuJ2Ixk7iwlioV4sNsxqAdHX8vMZZKKLCQdUfhAOOFojZ3iNXQynPHiVIlJg==
X-Received: by 2002:a05:6870:e9a7:b0:de:e59a:7376 with SMTP id r39-20020a056870e9a700b000dee59a7376mr7688592oao.194.1649358184393;
        Thu, 07 Apr 2022 12:03:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r25-20020a4aea99000000b0032447305d70sm7598890ooh.23.2022.04.07.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:03:03 -0700 (PDT)
Received: (nullmailer pid 1789446 invoked by uid 1000);
        Thu, 07 Apr 2022 19:03:03 -0000
Date:   Thu, 7 Apr 2022 14:03:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: align SPI NOR node name with dtschema
Message-ID: <Yk81Z5G+2B9arV9a@robh.at.kernel.org>
References: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
 <Yk8AJcFRmYEryqra@sirena.org.uk>
 <67f75e49-e0c1-463f-da39-4a2efe7cce3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f75e49-e0c1-463f-da39-4a2efe7cce3c@linaro.org>
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

On Thu, Apr 07, 2022 at 05:23:40PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2022 17:15, Mark Brown wrote:
> > On Thu, Apr 07, 2022 at 04:34:05PM +0200, Krzysztof Kozlowski wrote:
> >> The node names should be generic and SPI NOR dtschema expects "flash".
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt | 2 +-
> >>  Documentation/devicetree/bindings/spi/spi-davinci.txt           | 2 +-
> >>  Documentation/devicetree/bindings/spi/spi-pl022.yaml            | 2 +-
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > 
> > but it would be easier to split this into per subsystem stuff.
> 
> With DTS changes I had 22 patches, so splitting is a trade-off. If
> that's preferred (actually can reduce conflicts), I'll split it and send
> a v2.

I've applied it.

Really, I would have just fixed spi-pl022.yaml. In general, I'm not that 
interested in taking fixes on the .txt bindings.

Rob
