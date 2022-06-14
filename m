Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0454BD39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiFNWCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiFNWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:02:37 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FAD5581;
        Tue, 14 Jun 2022 15:02:34 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id p1so7569355ilj.9;
        Tue, 14 Jun 2022 15:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0nxRd9AE8Oe6xN5njg7BT1Z7XjTAG7bzfY/YVaHWxW0=;
        b=RoUuMFnliUzMEiYKVdMgoyitIDiWLkRlrYluMKR9M8VNsLvstw9m0hA4EsMJTbElb7
         EAAaZx+1asi1aI5E/pIv7UNlMuLZ2dz/81cW+dskI8x5a2j7lyiB5E+GIq8RH3FJ1YTC
         pjUHsTxiS8Hdf5ddCFZ/3X6GYjPKA72URnU8DEef3lpF81Gg+eYzi5sfLJMXEjP6Yztn
         ovLYPNvq3Vyl0mdlXOiUbtgu55J3J1SKeTubyl0DLmS1SMcsHDF7z/gUuYdZog21adSj
         yrIFXcuFAYUo6fyoAbm2pY/5MGw5V7+H2RSSs/rHBIRZtCNaqeERjd2z3cw28/cxefRY
         nEvQ==
X-Gm-Message-State: AJIora8oYwcfRB34mcKuv4hICNvfbSzVMXt0cZ8MDvbbZPvB7sfQ9TWs
        J/YZ4/8NQDhcxzsAidBInG9D1quCjw==
X-Google-Smtp-Source: AGRyM1s5JXgBzROW2REr1JyDPeUi7FdtaT5Ia8u5KZ46ee7E98SZvgRNcVp8ywM58DLAA4k2gAbIpw==
X-Received: by 2002:a92:c567:0:b0:2d1:c3df:eff8 with SMTP id b7-20020a92c567000000b002d1c3dfeff8mr4160022ilj.84.1655244153238;
        Tue, 14 Jun 2022 15:02:33 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g17-20020a022711000000b00331fdc68ccesm5320943jaa.140.2022.06.14.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:02:32 -0700 (PDT)
Received: (nullmailer pid 2793685 invoked by uid 1000);
        Tue, 14 Jun 2022 22:02:30 -0000
Date:   Tue, 14 Jun 2022 16:02:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 01/23] dt-bindings: ata: ahci-platform: Move
 dma-coherent to sata-common.yaml
Message-ID: <20220614220230.GA2793572-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-2-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 10 Jun 2022 11:17:39 +0300, Serge Semin wrote:
> Seeing doubtfully any SATA device working without embedded DMA engine
> let's permit the device nodes being equipped with the dma-coherent
> property in case if the platform is capable of cache-coherent DMAs.
> 
> As a side-effect we can drop the explicit dma-coherent property definition
> from the particular device schemas. Currently it concerns the Broadcom
> SATA AHCI controller only.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 
> Changelog v4:
> - Move the dma-coherent property to the sata-common.yaml schema instead
>   of removing it.
> - Remove the Hannes' rb tag.
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml  | 2 --
>  Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 --
>  Documentation/devicetree/bindings/ata/sata-common.yaml    | 2 ++
>  3 files changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
