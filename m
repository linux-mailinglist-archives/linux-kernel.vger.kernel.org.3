Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB9539A87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiFAAvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFAAvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:51:47 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724DE09F;
        Tue, 31 May 2022 17:51:45 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id l9-20020a056830268900b006054381dd35so198226otu.4;
        Tue, 31 May 2022 17:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ANUzpUtdAXNE0kNU2IE/l1wVtJZLEJWOERU20g49xRc=;
        b=BY5fZ6xu5neREUr/3XrejVfoLy774ebxVm419UhP6cOaQ6oE0TljwWVXtVLXLMYlvx
         wMPlb8gqk4SRSp2XP/EZWuD+qEDktgssNMQxz+pKGq8vWBzzs6wfFn2z3swGYQxMwsrm
         0n9McKy1qBx4F/mWakljBb2SLeirPl8IWtPa4jknY6cPb9YA3KG333Pkip5LD5YE2/TU
         a9Y7emUGhIqbMKU3hee/gJJDM1HXoVVmfdD4RC04wo/gsg2EGt/iArlvcNzKmtblxbM4
         knF4oDu/3LDcjzxhkProV6WlGS99WRdqH2aXdEOpPNR86rjzdB2v0rjw7q7udpAYmFSC
         u7SQ==
X-Gm-Message-State: AOAM533YSDSd0zKytnJ0ZAMriWLbdND/1KdWtDQ++mBpcv/O1krL3aU7
        dBuj+48lL0+lrAh02Jsm6Q==
X-Google-Smtp-Source: ABdhPJyMgwX3ACzMOmLAbMegRjP2DBdN3jZf0pv57O4KUJyvnm2M+yRTb7IBEi7Yg3WP9e01hbDVmw==
X-Received: by 2002:a9d:6e8d:0:b0:60b:83f9:7e9a with SMTP id a13-20020a9d6e8d000000b0060b83f97e9amr4989157otr.30.1654044704908;
        Tue, 31 May 2022 17:51:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w82-20020aca6255000000b0032694a9925esm223093oib.10.2022.05.31.17.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 17:51:44 -0700 (PDT)
Received: (nullmailer pid 2650548 invoked by uid 1000);
        Wed, 01 Jun 2022 00:51:43 -0000
Date:   Tue, 31 May 2022 19:51:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220601005143.GA2398472-robh@kernel.org>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
 <20220517191055.GA1424316-robh@kernel.org>
 <20220522150247.zznapdonuq7dsbup@mobilestation>
 <20220524151914.GB3730540-robh@kernel.org>
 <20220527101057.b5z7ase6y4naoxvk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527101057.b5z7ase6y4naoxvk@mobilestation>
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

On Fri, May 27, 2022 at 01:10:57PM +0300, Serge Semin wrote:
> On Tue, May 24, 2022 at 10:19:14AM -0500, Rob Herring wrote:
> > On Sun, May 22, 2022 at 06:02:47PM +0300, Serge Semin wrote:
> > > On Tue, May 17, 2022 at 02:10:55PM -0500, Rob Herring wrote:
> > > > On Thu, May 12, 2022 at 02:17:49AM +0300, Serge Semin wrote:
> > > > > In order to create a more sophisticated AHCI controller DT bindings let's
> > > > > divide the already available generic AHCI platform YAML schema into the
> > > > > platform part and a set of the common AHCI properties. The former part
> > > > > will be used to evaluate the AHCI DT nodes mainly compatible with the
> > > > > generic AHCI controller while the later schema will be used for more
> > > > > thorough AHCI DT nodes description. For instance such YAML schemas design
> > > > > will be useful for our DW AHCI SATA controller derivative with four clock
> > > > > sources, two reset lines, one system controller reference and specific
> > > > > max Rx/Tx DMA xfers size constraints.
> > > > > 
> > > > > Note the phys and target-supply property requirement is preserved in the
> > > > > generic AHCI platform bindings because some platforms can lack of the
> > > > > explicitly specified PHYs or target device power regulators.

[...]

> > > > > +patternProperties:
> > > > > +  "^sata-port@[0-9a-f]+$":
> > > > > +    type: object
> > > > > +    description:
> > > > > +      It is optionally possible to describe the ports as sub-nodes so
> > > > > +      to enable each port independently when dealing with multiple PHYs.
> > > > > +
> > > > > +    properties:
> > > > > +      reg:
> > > > > +        description: AHCI SATA port identifier
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      phys:
> > > > > +        description: Individual AHCI SATA port PHY
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      phy-names:
> > > > > +        description: AHCI SATA port PHY ID
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      target-supply:
> > > > > +        description: Power regulator for SATA port target device
> > > > > +
> > > > > +    required:
> > > > > +      - reg
> > > > > +
> > > > > +    additionalProperties: true
> > > > 
> > > 
> > > > If device specific bindings can add their own properties (as this 
> > > > allows), then all the common sata-port properties needs to be its own 
> > > > schema document. That way the device binding can reference it, define 
> > > > extra properties and set 'unevaluatedProperties: false'.
> > > > 
> > > 
> > > Could you please be more specific the way it is supposed to look? We
> > > have already got the sata-port@.* object defined in the sata-common.yaml
> > > super-schema. Here I just redefine it with more specific properties.
> > 
> 
> > If you want an example, see spi-peripheral-props.yaml and the change 
> > that introduced it.
> > 
> > If properties are defined in multiple locations, we have to be able to 
> > combine all those schemas to a single (logical, not single file) schema 
> > to apply it. That's the only way all the disjoint properties can be 
> > evaluated.
> 
> Hm, why do you refer to the cdns,qspi-nor-peripheral-props.yaml and
> samsung,spi-peripheral-props.yaml schema from the common
> spi-peripheral-props.yaml schema? In that case you permit having the
> vendor-specific properties used in all controllers. It doesn't seem
> right. Isn't it would be more natural to create a generic-to-private
> hierarchy? Like this:

It's not 'used in all controllers' but used in all devices. But yes, it 
does mean a device node could have any of the properties. 

The schema for the device must have all possible properties in its 
schema either directly or via $ref's. There's not a way to say if the 
parent controller is X, then apply these controller child device 
properties.

> > spi-peripheral-props.yaml:
> + properties:
> +    ...
> 
> > cdns,qspi-nor-peripheral-props.yaml:
> + allOf:
> +   - $ref: spi-peripheral-props.yaml#
> + properties:
> +   ...
> 
> > samsung,spi-peripheral-props.yaml:

Who would apply/$ref this in your schema?

> + allOf:
> +   - $ref: spi-peripheral-props.yaml#
> + properties:
> +   ...
> 
> Especially seeing you left the generic peripheral-props schema opened for
> the additional properties (additionalProperties: true). Afterwards the Cdns
> and Samsung SPI DT-schemas would refer to these peripheral props schemas
> in the sub-nodes. Like this:
> > cdns,qspi-nor.yaml:
> + ...
> + patternProperties:
> +   "^.*@[0-9a-f]+$":
> +     type: object
> +     $ref: spi-peripheral-props.yaml
> +     ...

This is the pattern that simply doesn't work. "^.*@[0-9a-f]+$" is 
entirely independent of a device schema and there's not 1 schema that 
has all possible properties.

We could at least limit nodes to allow one set of controller specific 
properties (but not necessarily the correct one):

allOf:
  - $ref: spi-peripheral-props.yaml#
  - oneOf:
      - $ref: samsung,spi-peripheral-props.yaml#
      - $ref: cdns,qspi-nor-peripheral-props.yaml#

And then in each of the above schemas we need:

anyOf:
  - required: [ vendor,prop1 ]
  - required: [ vendor,prop2 ]
  - ... for all the controller specific properties

The last part keeps the vendor specific schema from being true if none 
of the properties are present.

> > > Is it ok if I moved the sata-port@.* properties in the "definitions"
> > > section of the sata-common.yaml and ahci-common.yaml schema and
> > > re-used them right in the common bindings and, if required, in the
> > > device-specific schema?
> > 
> 
> > Yes, I guess. There's not really any advantage to doing that. A separate 
> > schema file is only a small amount of boilerplate.
> 
> IMO having the common ports definitions in the same schema file as the
> corresponding DT-bindings is more readable. You don't have to
> open additional files, switch between tabs in order to get to the
> referred sub-schema. In addition splitting that much coherent parts
> isn't good from the maintainability point of view either.
> 
> > 
> > > Please confirm that the next schema hierarchy is what you were talking
> > > about and it will be ok in this case:
> > > 
> > > > Documentation/devicetree/bindings/ata/sata-common.yaml:
> > > ...
> > > + patternProperties:
> > > +   "^sata-port@[0-9a-e]$":
> > > +     $ref: '#/definitions/sata-port'
> > > + 
> > > + definitions:
> > 
> 
> > '$defs' is preferred over 'definitions'.
> 
> Ok.
> 
> > 
> > > +   sata-port:
> > > +     type: object
> > > +   
> > > +     properties:
> > > +       reg:
> > > +         minimum: 0
> > 
> 
> > That's the default.
> > 
> > > + 
> > > +     additionalProperties: true
> > 
> > Drop this.
> 
> Ok.
> 
> > 
> > > 
> > > > Documentation/devicetree/bindings/ata/ahci-common.yaml:
> > > ...
> > > + patternProperties:
> > > +   "^sata-port@[0-9a-e]$":
> > > +     $ref: '#/definitions/ahci-port'
> > > + 
> > > + definitions:
> > > +   ahci-port:
> > > +     $ref: /schemas/ata/sata-common.yaml#/definitions/sata-port
> > > +     properties:
> > > +       reg:
> > > +         minimum: 0
> > > +         maximum: 31
> > > ...
> > > + 
> > > +     additionalProperties: true
> > 
> > Drop this.
> > 
> > > 
> > > > Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml:
> > > ...
> > > + patternProperties:
> > > +   "^sata-port@[0-9a-e]$":
> > > +     $ref: /schemas/ata/ahci-common.yaml#/definitions/ahci-port
> > > +     properties:
> > > +       reg:
> > > +         minimum: 0
> > > +         maximum: 7
> > > + 
> > > +       snps,tx-ts-max:
> > > +         $ref: /schemas/types.yaml#/definitions/uint32
> > > + 
> > > +       snps,rx-ts-max:
> > > +         $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +     unevaluatedProperties: true
> > 
> 
> > This needs to be false. 
> 
> Right. Incorrectly copy-pasted it.
> 
> > And this should work as the $ref issue is only 
> > for the top-level schema.
> 
> Do you mean that this will work for the schemas referring the
> snps,dwc-ahci.yaml schema only? I suppose the vendor-specific schemas
> still can extend it by re-designing the snps,dwc-ahci.yaml DT-binding in
> the same way as the generic SATA/AHCI schemas.

I mean it doesn't have the bug in dtschema preventing 
unevaluatedProperties from fully working correctly.

Rob
