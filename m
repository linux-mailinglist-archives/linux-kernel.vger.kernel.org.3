Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D154BD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiFNWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiFNWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:17:02 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D7517E2;
        Tue, 14 Jun 2022 15:17:02 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id p1so7591150ilj.9;
        Tue, 14 Jun 2022 15:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UadqYW9XwMxHXYGhli/peFzRH3z/O7G1v62bSzxhX9Y=;
        b=OLujiVbW4/rHh4wo2X5FhWpmBays16OLs3dM8uXJwAFryxd+wniqtKehfnFSSiWn0p
         YIVkYma/vffbXzwnu0aqrdMOEu9SBbo9mjbcUTxkA01wjH6qmlrb/DMlUvxkQbeePryD
         cWI1rvk5VVZoXmDs8j6+3mUTzJ30qfAFeXKWtVnjUeuX+xP0WY+17JzCpL+eHgYqIHZS
         U+v4EFxshudr5/i8EeIeZ8x8w96HnpQM6RthHjUroNQgTH3lzO+NzJarN6NEBP1F+Qcx
         fDuUErwH65jYVdm6HVzCWSr13SeZFrIyHGFs3iuHSPrScQDeKy7h7qPXXc/NT6+5hj6t
         5erw==
X-Gm-Message-State: AJIora84qTWvN6LDGNoh/af/7C4tl87q4AEphRtMeN66k2Oq5jpUQFi3
        KdNJZOHxALE9/Nk+M225Ug==
X-Google-Smtp-Source: AGRyM1szWFI0pa+FR6vijKPpqNKE81D4UgslSOZVRfP4Pxc2uu+P4gdQEE5eMn66oYWa6KegHaoHhQ==
X-Received: by 2002:a92:d706:0:b0:2d7:3543:75f with SMTP id m6-20020a92d706000000b002d73543075fmr4367063iln.146.1655245021379;
        Tue, 14 Jun 2022 15:17:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5-20020a92c605000000b002d546bec2f6sm6040067ilm.67.2022.06.14.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:17:00 -0700 (PDT)
Received: (nullmailer pid 2823549 invoked by uid 1000);
        Tue, 14 Jun 2022 22:16:58 -0000
Date:   Tue, 14 Jun 2022 16:16:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220614221658.GA2823453-robh@kernel.org>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610081801.11854-3-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 10 Jun 2022 11:17:40 +0300, Serge Semin wrote:
> In order to create a more sophisticated AHCI controller DT bindings let's
> divide the already available generic AHCI platform YAML schema into the
> platform part and a set of the common AHCI properties. The former part
> will be used to evaluate the AHCI DT nodes mainly compatible with the
> generic AHCI controller while the later schema will be used for more
> thorough AHCI DT nodes description. For instance such YAML schemas design
> will be useful for our DW AHCI SATA controller derivative with four clock
> sources, two reset lines, one system controller reference and specific
> max Rx/Tx DMA xfers size constraints.
> 
> Note the phys and target-supply property requirement is preserved in the
> generic AHCI platform bindings because some platforms can lack of the
> explicitly specified PHYs or target device power regulators.
> 
> Also note the SATA/AHCI ports properties have been moved to the
> $defs-paragraph of the schemas. It's done in order to create the
> extendable properties hierarchy such that particular AHCI-controller
> could add vendor-specific port properties.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Folks, I don't really see why the phys/target-supply requirement has been
> added to the generic AHCI DT schema in the first place. Probably just to
> imply some meaning for the sub-nodes definition. Anyway in one of the
> further patches I am adding the DW AHCI SATA controller DT bindings which
> won't require having these properties specified in the sub-nodes, but will
> describe additional port-specific properties. That's why I get to keep the
> constraints in the ahci-platform.yaml schema instead of moving them to the
> common schema.
> 
> Changelog v2:
> - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> 
> Changelog v3:
> - Replace Jens's email address with Damien's one in the list of the
>   schema maintainers. (@Damien)
> 
> Changelog v4:
> - Drop clocks, clock-names, resets, reset-names and power-domains
>   properties from the common schema. (@Rob)
> - Create sata/ahci-port properties definition hierarchy so the sub-schemas
>   would inherit and extend the ports properties of the super-schema. (@Rob)
> ---
>  .../devicetree/bindings/ata/ahci-common.yaml  | 100 ++++++++++++++++++
>  .../bindings/ata/ahci-platform.yaml           |  72 ++-----------
>  .../devicetree/bindings/ata/sata-common.yaml  |   8 +-
>  3 files changed, 115 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
