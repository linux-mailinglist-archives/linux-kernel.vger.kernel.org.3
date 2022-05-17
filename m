Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE34152ABC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352600AbiEQTPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiEQTPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:15:44 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBAE3AB;
        Tue, 17 May 2022 12:15:41 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so25400539fac.7;
        Tue, 17 May 2022 12:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fTl6QIMXPj3pDV74OjNY4tTiZZKBY8RMpeS8yT4YiI=;
        b=NDQ2mfgdsvRB5MCMKTO9NEHhCFKUR9XxCBwQpLe2b6ILseDPPDeev4KnmZPKeakjr1
         G8Pw/K82UWw6cVNvpQb9RJOdtFzkncu5hmcaPBL5u8NuP0kEg95m1xTlWZgg1XS2XAbf
         jmo4ZOwSD9cS0OjGk/NzUTKUsMZp/TkReZkv0CMlpxZL31fibi16xWm4svrCmp/DvGK7
         sG/RXPJKvSY5PoQ8IS5F6laVYHalp+DwJHWCjtRDcuxeSHa/3laOww3ra8i/ILg/gp6l
         29+aCHP/Or3gt3QeUK1kZLmKiItdal3m4rIiZRHVOltTfoCQfPWlHUx+NuNd0Y8GAJDQ
         NMog==
X-Gm-Message-State: AOAM532k5m+2QKB4vz9Gieo+cbJ2Ijf8sztp16jW+g3Z6qa9VxxgCWHU
        ETnksVNwUivUkhOFYOAWUw==
X-Google-Smtp-Source: ABdhPJwRVrgWkB95MWZ/1gq0L6l55pcppNFMAoEUrHSQpRdkcIkJ3HVVUVNZ7ANjKJ+0t+/wPdTcLQ==
X-Received: by 2002:a05:6870:e30e:b0:de:ab76:eed7 with SMTP id z14-20020a056870e30e00b000deab76eed7mr19243989oad.101.1652814940792;
        Tue, 17 May 2022 12:15:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m29-20020a056870059d00b000e99b1909d4sm145052oap.25.2022.05.17.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:15:40 -0700 (PDT)
Received: (nullmailer pid 1453516 invoked by uid 1000);
        Tue, 17 May 2022 19:15:39 -0000
Date:   Tue, 17 May 2022 14:15:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v3 04/23] dt-bindings: ata: sata: Extend number of SATA
 ports
Message-ID: <20220517191539.GA1453482-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-5-Sergey.Semin@baikalelectronics.ru>
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

On Thu, 12 May 2022 02:17:51 +0300, Serge Semin wrote:
> The denoted in the description upper limit only concerns the Port
> Multipliers, but not the actual SATA ports. It's an external device
> attached to a SATA port in order to access more than one SATA-drive. So
> when it's attached to a SATA port it just extends the port capability
> while the number of actual SATA ports stays the same. For instance on AHCI
> controllers the number of actual ports is determined by the CAP.NP field
> and the PI (Ports Implemented) register. AFAICS in general the maximum
> number of SATA ports depends on the particular controller implementation.
> Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
> 5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
> controller can't be configured with more than 8 ports activated. So let's
> discard the SATA ports reg-property restrictions and just make sure that
> it consists of a single reg-item.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Add comma and replace "channel" with "SATA port" in the reg property
>   description (@Damien).
> ---
>  Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
