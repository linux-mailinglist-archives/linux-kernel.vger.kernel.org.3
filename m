Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162D536DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbiE1Ret (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiE1Rer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:34:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC7312;
        Sat, 28 May 2022 10:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4E160F68;
        Sat, 28 May 2022 17:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5889EC34100;
        Sat, 28 May 2022 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653759286;
        bh=yeRDBl3fGRJ9paZDzF8sBkWNRLREA17JNf2uoZPoAxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tGY92kiHIY5uu81GQg6aYbmwqKmgip2QGDziFjy9V3v9/0XQ8GAzn+d4B9pCXL2fP
         FE68JZqPJB0r6USanjHvDqmKaAICBmCUmUOEWqSh9YmCIqdSeDXavmGgN/6Mq8PNkw
         QmipkaFFyLUqBT4EE3qHQI1/sne+y1IgaSUT/6bmjugB/rE5/XUnSiCuZlZzM+dqb8
         snNWSqPzVIcQo/dQHR51GfMQWpC0uqdKYhKo13BlXxTOtFhzPiXFqaN6PTK2PwJ3Mj
         +qP7HYMFUt+ldBzbqQFMkQ+NiF92Ys3zRD1BPWuowHO9B6SjGhzpPT0vE5HyfJm8OS
         5y0a7T4Us611g==
Date:   Sat, 28 May 2022 18:43:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <20220528184337.0855c8cc@jic23-huawei>
In-Reply-To: <20220525183255.lc7hmmcfj47yrxc3@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
        <20220525181532.6805-4-ddrokosov@sberdevices.ru>
        <20220525183255.lc7hmmcfj47yrxc3@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 18:32:45 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan and Rob,
> 
> I didn't change two places which you mentioned in the v1 review, please
> find my comments below.
> 
> On Wed, May 25, 2022 at 06:15:33PM +0000, Dmitry Rokosov wrote:
> 
> > +  interrupt-names:
> > +    const: irq  
> I stay interrupt-names node here, because otherwise dt_binding_check
> command shows such a warning:
> 
> ====
>   CHECK   Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: accelerometer@62: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> ====
> 
> I can't delete this node from the example as well, because it's required for
> msa311 dts i2c irq declaration.

Sorry, you've lost me - what breaks if you drop it from the example?
I'd expect to see no interrupt-names being documented or in the example.

> 
> Please help me to resolve this problem properly if possible. If we can
> ignore such warning I'll delete interrupt-names in the next patchset's
> version.

We can't ignore the warning, so this comes down to what am I missing with
the need for it in the example...

> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +  
> Properties #address-cells and #size-cells are still located in the
> schema example, because otherwise dt_binding_check raises the below 
> warnings if we delete these properties:

They should be there for the i2c node, (as they are required for an i2c bus master
node) but you had them documented as being in the msa311 node.  If it's
not in the
accelerometer@62 {

}

section of the example documetnation doesn't belong on this file (it will be
elsewhere). 

The request is to drop the documentation of them (as we are documenting
the msa311 part of the binding only).  They should indeed still be there
in the example.

Jonathan



> 
> =====
>   DTC     Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:27.17-30: Warning (reg_format): /example-0/i2c/accelerometer@62:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:24.13-32.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for I2C bus
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:24.13-32.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for I2C bus
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:25.30-31.15: Warning (avoid_default_addr_size): /example-0/i2c/accelerometer@62: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:25.30-31.15: Warning (avoid_default_addr_size): /example-0/i2c/accelerometer@62: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.yaml: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
> =====
> 
> What is best way to resolve such issues without providing #address-cells
> and #size-cells values?
> 

