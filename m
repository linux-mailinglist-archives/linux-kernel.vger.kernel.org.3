Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAA4BFC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiBVP20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBVP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:28:23 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5ABF94F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:27:57 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e22so43011752qvf.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=sRXHeZa3R3XlgQ3HiJffd+JnUn0eLfdgPeYFYoXUPrA=;
        b=OM8uvKjAqiC1AFy883I9phKcgjUhezz0SI1Zd0n1/e8N0pexuTzZYEesBLhTn2J0q5
         wuNz/qzfZoQx4gqHM/2EUgCZxcH7nIl1zwNAKSvKD24YcWjwl0AwQWwugipEssZ0ddsz
         eYkIurkODq75S+udILDkgjj4Bf8oN29wqttH1Rvrgg+K7uxImMrUBrbcrOHwuOL98oIT
         GKtf0eZHgpx7aZs3kFNxWdTYHTp1n8SL3+gOjX8PRQENJ34taYBHy0wFPXx4DStnb86x
         hqFlDVWhl2c0ecYNcteLMpF/nN3QGe2N9QH0szYwtdm/fq1JJ9F8qUNRdSuT6B/PHblj
         BcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=sRXHeZa3R3XlgQ3HiJffd+JnUn0eLfdgPeYFYoXUPrA=;
        b=7pYRDdThTvXASOSUH0FMiL+j27mB+AQhEl8IxRUjwiaw20kUGiqVzCbgVpzbzHaifB
         tCjVuQ6oGNoIM496djwvPTWdr+YanDq7AVaVWIBgQAsyjSxM0ff4tlXFr50NS5pxwVO/
         AsAPj1/V+TwfPQ3wX3wdpJaX7U/SOPPOHgJ4mh4vyW/wUHu26D7y4/IWxYjeu0nH8ynQ
         ZLUBWaAtrgSQmf46BKdVPO4FwCpl/T/Ru4Y05fADmFyAzAvtW+PFA0PJO7SGTT4bksHq
         OMUsCM4HlUoEL9rVjgRQcTX+VH5N0i43+9RAJcvzovuCJXdCqbpnlm2qXH2k9cISKqAT
         EljQ==
X-Gm-Message-State: AOAM530HVkT0hGCBFWnUfnNRZr5oXd3BkXv3KlQ0kWamwxQ43GUC4kci
        IjcvWluwe+nuZsGf6UvAludBRbnmZnwyqwoJLa8=
X-Received: by 2002:a05:622a:588:b0:2de:6f57:1576 with SMTP id
 c8-20020a05622a058800b002de6f571576mt1162223qtb.83.1645543676369; Tue, 22 Feb
 2022 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20220221135351.GA7342@ubuntu> <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
In-Reply-To: <3e1ee336-1c78-7719-826c-2a093a20ee8e@kernel.org>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Tue, 22 Feb 2022 16:27:45 +0100
Message-ID: <CAE9cyGRcDSJwrKOWER9wxHSAQzLs2ZdL+uWsme0etMV+8wKcMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: Add AVM WASP
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 21. Feb. 2022 um 17:47 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
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
>
> > +
> > +  wasp-netboot-firmware:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Should contain the name of the netboot firmware that is to be loaded
> > +      and started on the WASP SoC using mdio in order to be able to load
> > +      the initramfs image as a second stage.
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
>
> > +  reset-gpio:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: Reference and parameters for the reset gpio of the WASP SoC.
>
> Wrong suffix, unneeded type. Did you run dt_binding_check?

Hi Krzystof,

Sorry for missing the dt_binding_check.
I have switched to use devm_gpiod_get and it does not work if the
suffix is not -gpio
or -gpios (see of_find_gpio method).
Would avm,reset-gpio be ok to use here?

Thanks.
>
> "Reference and parameters" are obvious, so they should be skipped.
>
> > +
> > +  startup-gpio:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: Reference and parameters for the power switch gpio of the WASP SoC.
>
> Same.
Is avm,startup-gpio ok, like above?
>
> > +
> > +required:
> > +  - compatible
> > +  - ath9k-firmware
> > +  - ath10k-caldata
> > +  - wasp-netboot-firmware
> > +  - wasp-netboot-mdio
> > +  - wasp-initramfs-port
> > +  - wasp-initramfs-image
> > +  - reset-gpio
> > +  - startup-gpio
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    avm-wasp {
>
> Generic node name describing class of a device. AVM is company, WASP is
> product, so neither of them are generic.
>
>
> Best regards,
> Krzysztof
