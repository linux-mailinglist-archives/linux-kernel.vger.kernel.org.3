Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA9578BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiGRUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiGRUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:33:21 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76932E9FE;
        Mon, 18 Jul 2022 13:33:20 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id u20so10270245iob.8;
        Mon, 18 Jul 2022 13:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAk6eC2TiGiEveH5D+C4HMKgKZtoR9XTG/x7IKc38a4=;
        b=7EVCvwBTXD5bkNuJbTtmEE0kQ57IKESzeATPy/272tkEXbNXkcDhAO1NMUtgH/jYDd
         WqCp7Uz4IsSiE4phh3QnZFw5ce459Yskz3c8QBlZsKmzDHx+DEe+ksNQ3QXJ2f3KSdTv
         sAdXhu1J2OSTqYEQqGeWkeyOcuF7jqCB4VmMdAA91iT6QAt7D00Gff0SFQzGwJ3AWpgb
         NI4bnlEe7j3h9A9vAMGl6oKWtSLF7vp1r50CPFEOlkZMwwaCjYCj2p798nVRtiXzmpdL
         mKQaSpuIHUWCnnV28ug+l3MuxeS3zFr8I/M/cMeMOhpAA9SRqCH4os6sgsWJb3+ti+Kg
         j0Pg==
X-Gm-Message-State: AJIora86ibA952aAg38tV0ptRwCzKTqeOgMEwFCOL99iYUjnmWMOfqgl
        EmqO8D/xgf73/FNwflsN1Q==
X-Google-Smtp-Source: AGRyM1viFALT2Np+Dy3PO9pVNF5FoEBBfizbj7aScI4m4hM7EYqhMMLkcEg+7ijdFlj56l8oYbykIQ==
X-Received: by 2002:a02:2718:0:b0:33f:7a76:baa4 with SMTP id g24-20020a022718000000b0033f7a76baa4mr15484126jaa.277.1658176400070;
        Mon, 18 Jul 2022 13:33:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x68-20020a0294ca000000b0034141e2510bsm5605009jah.71.2022.07.18.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:33:19 -0700 (PDT)
Received: (nullmailer pid 3501428 invoked by uid 1000);
        Mon, 18 Jul 2022 20:33:17 -0000
Date:   Mon, 18 Jul 2022 14:33:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-ide@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        devicetree@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Subject: Re: [PATCH v5 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220718203317.GA3501391-robh@kernel.org>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
 <20220713052917.27036-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713052917.27036-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 08:29:10 +0300, Serge Semin wrote:
> Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> SATA controller except a few peculiarities and the platform environment
> requirements. In particular it can have at least two reference clocks to
> feed up its AHB/AXI interface and SATA PHYs domain and at least one reset
> control for the application clock domain. In addition to that the DMA
> interface of each port can be tuned up to work with the predefined maximum
> data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> device DT binding.
> 
> Note the DWC AHCI SATA controller DT-schema has been created in a way so
> to be reused for the vendor-specific DT-schemas (see for example the
> "snps,dwc-ahci" compatible string binding). One of which we are about to
> introduce.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
>   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> 
> Changelog v4:
> - Decrease the "additionalProperties" property identation otherwise it's
>   percieved as the node property instead of the key one. (@Rob)
> - Use the ahci-port properties definition from the AHCI common schema
>   in order to extend it with DWC AHCI SATA port properties. (@Rob)
> - Remove the Hannes' rb tag since the patch content has changed.
> 
> Changelog v5:
> - Fix "resets" property description: replace "clocks" with "resets".
>   (@Rob)
> - Extend "resets/clocks{-names}" property definitions. (@Rob)
> - Add "resets" property min/maxItems constraints. (@Rob)
> - Add names for the basic resets like RxOOB and PM-alive. (@Rob)
> - Add generic DWC AHCI SATA fallback for "rockchip,rk3568-dwc-ahci"
>   bindings. (@Rob)
> - Due to the change above the schema has been split up into two parts:
>   common DWC AHCI SATA properties and generic DW AHCI SATA controller
>   DT-schema. (@Rob)
> ---
>  .../bindings/ata/ahci-platform.yaml           |   8 --
>  .../bindings/ata/snps,dwc-ahci-common.yaml    | 102 ++++++++++++++++++
>  .../bindings/ata/snps,dwc-ahci.yaml           |  75 +++++++++++++
>  3 files changed, 177 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
