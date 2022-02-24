Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D34C30FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiBXQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiBXQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:09:55 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38730198D34;
        Thu, 24 Feb 2022 08:09:15 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id s5so3073345oic.10;
        Thu, 24 Feb 2022 08:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvLEO9/kZEQfHdrhfnopif7Jzot/9NUySUoyWbKmb+U=;
        b=35LzIHZ6+KxkL1a6O6GyXneSqw5byotkvKG9Y7eqeQvb8KjvipzRDMSJCHupoHXQAL
         D6EOOMxSWkASdV99qtS6kMupxIRcOeaw8pasYJMZz0sS+UqaqeUMIkQZMhIjqOJY7CTI
         2KCnXnV4Y441qSvTQby1KIcdc7V84Y/pKANrljEmcKAxdKBf4ZeBQaBnH+K2yIW57Arh
         rR6ToW0uHiF2qQzkny+ReTY+3AJ4yG56OCQLdP588LwG/GJlHi5dRjWXSK3+1tLckCwV
         K+V/sSO2zCbaCPpEUSpYIkW8gi1DKc+4yJ1EQswN4VZVdP/QSU08dQsJjbuK+pOFlRBO
         gajQ==
X-Gm-Message-State: AOAM5314oXBokKlsHvDCx+rF5pPMeNqA8P0payjRt2njrpOlqN4c+bNW
        lmuv8pHfh7k2e0nlP6THKvRflu22Iw==
X-Google-Smtp-Source: ABdhPJwKFU27nQR8bl6CoParBjRWn3zniqHxXTGjB8UYFOCaCKNf3LRScbmUWpAqGdYpKOQqSLaEfQ==
X-Received: by 2002:a05:6870:311a:b0:ce:c0c9:5ff with SMTP id v26-20020a056870311a00b000cec0c905ffmr6120512oaa.81.1645718876006;
        Thu, 24 Feb 2022 08:07:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d18sm1699134oiw.18.2022.02.24.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:07:55 -0800 (PST)
Received: (nullmailer pid 3163849 invoked by uid 1000);
        Thu, 24 Feb 2022 16:07:54 -0000
Date:   Thu, 24 Feb 2022 10:07:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: Add AVM WASP
Message-ID: <YhetWlZ4m2vfB40e@robh.at.kernel.org>
References: <20220221135351.GA7342@ubuntu>
 <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
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

On Mon, Feb 21, 2022 at 05:47:34PM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2022 14:53, Daniel Kestrel wrote:
> > AVM Fritzbox router boards may contain an additional ATH79
> > based SoC that has the wifi cards connected.
> > This patch adds bindings for this remote processor.
> > 
> > Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
> > ---
> >  .../bindings/remoteproc/avm,wasp-rproc.yaml   | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> > new file mode 100644
> > index 000000000000..21f3bbcc4202
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AVM WASP processor controller bindings
> > +
> > +maintainers:
> > +  - Daniel Kestrel <kestrelseventyfour@gmail.com>
> > +
> > +description: |
> > +  This document defines the bindings for the remoteproc component that loads and
> > +  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
> > +  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
> > +
> > +properties:
> > +  compatible:
> > +    const: avm,wasp
> > +
> > +  ath9k-firmware:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Should contain the name of the ath9k eeprom that is to be loaded from
> > +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
> > +      The file should be located on the firmware search path.
> 
> Are you sure this is a property of hardware? It looks like runtime
> configuration parameter.

The standardish name for this is 'firmware-name'.

'name of the ath9k eeprom' is an odd description given there is no 
eeprom in this case. Where it is loaded from exactly is outside the 
scope of this binding.

> 
> > +
> > +  ath10k-caldata:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Should contain the name of the ath10k caldata that is to be loaded from
> > +      the lantiq host flash. Wifi on the WASP SoC does not work without it.
> > +      The file should be located on the firmware search path.
> 
> Same.

Ideally, 'firmware-name' would cover both cases and just provide a base 
name that the driver transforms into file names.

> 
> > +
> > +  wasp-netboot-firmware:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Should contain the name of the netboot firmware that is to be loaded
> > +      and started on the WASP SoC using mdio in order to be able to load
> > +      the initramfs image as a second stage.

initramfs is a Linux detail and should not be in binding.

> > +      The file should be located on the firmware search path.
> 
> Same.
> 
> > +
> > +  wasp-netboot-mdio:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Reference to the Lantiq GSWIP switch mdio.
> 
> Vendor prefix.
> 
> > +
> > +  wasp-initramfs-port:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Reference to the network port, where the WASP SoC is connected to.
> 
> Vendor prefix.
> 
> > +
> > +  wasp-initramfs-image:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Should contain the name of the initramfs linux image that is to be loaded
> > +      and started on the WASP SoC.
> > +      The file should be located on the firmware search path.
> 
> initramfs path looks even less like a property of hardware... If you
> change initramfs from CPIO to initrd or GZ, hardware changes as well?

And simply not how standard initramfs loading works. Boot menu files are 
how one gives the bootloader a location of initramfs file and chosen is 
how the kernel gets the memory location it was loaded to.

Rob
