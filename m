Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97D54020D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbiFGPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiFGPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:03:43 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33754C788;
        Tue,  7 Jun 2022 08:03:41 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h18so14410758ilj.7;
        Tue, 07 Jun 2022 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNKzlkx0zpGiRwZkuCDlK4Dewwo3rZNjJ0z5GnzZn/M=;
        b=zhufxe838KlflSHQewH9Qy32MMnlxopUfPARFudMhS1fpVUix+MsfR1agfC2iUGLuw
         dgZIVMHfZQpOHJvTuBsPE3lg7T76HoPrfOnwrXO5WRu8RFZFKxSVGZsqUj+LoiEYiAGH
         telxJpQNwAAJ8ku+G5LB7KN66GftO7aMyNup/PR0CoLf3QEVEWdpkC5ZNRtnw8KuRdNL
         MK0Fac9ZW9wKSOzFWHLlHxOodOQG1XHSIkaZxtFnK9q8MAsCDfowd6IRi4HZCD25BPc/
         QOeRvfTHFAb1/0pybhMP5x1baAiBt2g3vM0CqS3Phr9yKof5mhJebrzBep9L8qRv7th8
         QY1g==
X-Gm-Message-State: AOAM533a+Twy6YlrBYhjA1dhZFGTCSvyDX/DyUHyS/oKvuES2ULuwp/Q
        ZTo9Zh0VKUpToXZxmnB03A==
X-Google-Smtp-Source: ABdhPJyyGevfYzoesUjlKy26l6DER5X3JuiJkpM5mXxGu5oCZUr9aNH5N1Fmt+iapjPA2aimr2L/oQ==
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id d9-20020a923609000000b002c635952a25mr17174689ila.233.1654614220999;
        Tue, 07 Jun 2022 08:03:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i7-20020a02a0c7000000b0032e5417e910sm6697973jah.12.2022.06.07.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:03:40 -0700 (PDT)
Received: (nullmailer pid 3246236 invoked by uid 1000);
        Tue, 07 Jun 2022 15:03:38 -0000
Date:   Tue, 7 Jun 2022 09:03:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: input: Convert adc-keys to DT schema
Message-ID: <20220607150338.GA3189983-robh@kernel.org>
References: <20220606184243.1057145-1-robh@kernel.org>
 <7657a50f-20c0-9ad0-aecb-5b3e71feb18c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7657a50f-20c0-9ad0-aecb-5b3e71feb18c@gmx.de>
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

On Tue, Jun 07, 2022 at 09:48:33AM +0200, Heinrich Schuchardt wrote:
> On 6/6/22 20:42, Rob Herring wrote:
> > Convert the adc-keys binding to DT schema format.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/input/adc-keys.txt    |  67 ------------
> >   .../devicetree/bindings/input/adc-keys.yaml   | 103 ++++++++++++++++++
> >   2 files changed, 103 insertions(+), 67 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> >   create mode 100644 Documentation/devicetree/bindings/input/adc-keys.yaml

> > -+--------------------------------+------------------------+
> > diff --git a/Documentation/devicetree/bindings/input/adc-keys.yaml b/Documentation/devicetree/bindings/input/adc-keys.yaml
> > new file mode 100644
> > index 000000000000..a3a1af9550bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adc-keys.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/adc-keys.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADC attached resistor ladder buttons
> > +
> > +maintainers:
> > +  - Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> Thanks for converting to yaml.
> 
> I only contributed a single patch. I am not a maintainer. Please, remove
> that line.

Okay.

> scripts/get_maintainer.pl
> Documentation/devicetree/bindings/input/adc-keys.txt yields
> Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD,
> MOUSE, JOYSTICK, TOUCHSCREEN)...)

The maintainer here is supposed to be someone that cares about this 
particular binding, not who applies patches. IOW, who would care if the 
binding was deleted.

> It would be preferable to have a single reference point for
> maintainership: file /MAINTAINERS.

There's 2 main reasons why it is not. MAINTAINERS doesn't work for the 
DT only tree we generate[1]. Second, having an entry in MAINTAINERS 
for bindings is not consistent. With it in the schema, I don't have to 
check, the tools do it for me.

> > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/input/input.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: adc-keys
> > +
> > +  io-channels:
> > +    maxItems: 1
> 
> Please, add a description to each property.

Common properties don't get descriptions unless there is something 
specific about this binding to say. What would that be?

 
> > +  io-channel-names:
> > +    const: buttons
> > +
> > +  keyup-threshold-microvolt:
> > +    description:
> > +      Voltage above or equal to which all the keys are considered up.
> > +
> > +patternProperties:
> > +  '^button-':
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Each button (key) is represented as a sub-node.
> > +
> > +    properties:
> > +      label: true
> 
> Please, add a description.

No, common property.

> > +      linux,code:
> > +        description: Keycode to emit.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> Unfortunately usable values are only defined in
> include/uapi/linux/input-event-codes.h up to now. Please, consider
> adding that link to the description.

linux,code is common for lots of bindings, so really the type, 
description, and any common constraints need to be documented somewhere 
common. I'm not sure if input.yaml makes sense given that includes a 
bunch of other properties.

> It is unclear to me if using values above KEY_MAX (=0x2ff) could make
> sense of should be forbidden by this yaml file.

Shrug. I have no idea.

> For interoperability of device-trees with other operating systems we
> should have a yaml file defining an enum with used values and their meaning.

Certainly, but that's an orthogonal issue.

> > +
> > +      press-threshold-microvolt:
> > +        description:
> > +          Voltage above or equal to which this key is considered pressed. No
> > +          two values of press-threshold-microvolt may be the same. All values
> > +          of press-threshold-microvolt must be less than
> > +          keyup-threshold-microvolt.
> > +
> > +    required:
> > +      - label
> 
> Property label is not used in our the driver code. It only exists for
> human readability. Why is it marked as required? Stripping the labels
> would reduce the DT size.

From the original:

> > -Required subnode-properties:
> > -	- label: Descriptive name of the key.

But I'll drop it.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/tree/
