Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E552DDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiESTs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiESTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:48:25 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B491ED8FA;
        Thu, 19 May 2022 12:48:24 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id t144so4444596oie.7;
        Thu, 19 May 2022 12:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIsxZb3blRqHveZZ1vGHzZvKm0j5k9bs5pNXv4/1iRw=;
        b=DfTudoFhP7NlkM3vwK6c5oxIiwwewS/bNl020/XClYOIi7S1+Mos2FQswnSu0QflAC
         0cg3e/MFxAm7+oH3HVSkPhLyQXtb9A5gGF5mgFgoyOnx9h8dguEs16GlIkQiw8aXJWjG
         Hlu5tzDb7McqRz8zGGRgJsumyY3aKoTJ4ZljUsnbr2GWlIfjB+5HRyBa1ZZ5rCDzPYjs
         sBAePVnZpyk5X8XSLVRyQk89za57G1JUJGZTLVd57d2yctyzlTOZi0qbmgcxUCZtzec/
         5sFjqTcaUyS5HXZPfbD5O8egtHzx4JnHGPlWopMSf/v9xuDAlPAf5gH70PQz1SKI8q4w
         6rkA==
X-Gm-Message-State: AOAM532EaURk1dSJbgnIlBX4r0Z27HvTR2pxmtt8ojPGVXNzZI4Fwddo
        1xIaSIdKivi9lEyEbLTXwg==
X-Google-Smtp-Source: ABdhPJznjYxOKubyLqrHc8K4JIoqeBTU25Rk4zIlngny0HhJr/+0rpaykQKsYWnr3T8r+X5F4uMRsA==
X-Received: by 2002:a05:6808:f8a:b0:326:de54:a750 with SMTP id o10-20020a0568080f8a00b00326de54a750mr3381561oiw.272.1652989703540;
        Thu, 19 May 2022 12:48:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d15-20020a056830004f00b0060613c844adsm105593otp.10.2022.05.19.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:48:22 -0700 (PDT)
Received: (nullmailer pid 2081471 invoked by uid 1000);
        Thu, 19 May 2022 19:48:21 -0000
Date:   Thu, 19 May 2022 14:48:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/3] dt-bindings: cros-ec: Add ChromeOS fingerprint
 binding
Message-ID: <20220519194821.GA2071376-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-4-swboyd@chromium.org>
 <20220516152003.GB2659134-robh@kernel.org>
 <CAE-0n53p1mKME=vfed2SB7UXrg9K+-vbp6JPHJBchJc-Pp1Hgg@mail.gmail.com>
 <20220518161348.GC3302100-robh@kernel.org>
 <CAE-0n53CMwtCY6XqYRXBpY5g21cFKyr8BF34t79JfK3dKg8cEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53CMwtCY6XqYRXBpY5g21cFKyr8BF34t79JfK3dKg8cEg@mail.gmail.com>
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

On Wed, May 18, 2022 at 12:56:17PM -0700, Stephen Boyd wrote:
> Quoting Rob Herring (2022-05-18 09:13:48)
> > On Mon, May 16, 2022 at 12:23:03PM -0700, Stephen Boyd wrote:
> > > Quoting Rob Herring (2022-05-16 08:20:03)
> > > > On Wed, May 11, 2022 at 06:39:21PM -0700, Stephen Boyd wrote:
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > > index 409ecef967ce..e5fe60beb9fe 100644
> > > > > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > > > +      - items:
> > > > > +          - const: google,cros-ec-i2c
> > > > > +      # For implementations of the FPMCU connected through SPI.
> > > > > +      - items:
> > > > > +          - const: google,cros-ec-fp
> > > > > +          - const: google,cros-ec-spi
> > > > > +      # For implementations of the EC is connected through SPI.
> > > > > +      - items:
> > > > > +          - const: google,cros-ec-spi
> > > > > +      # For implementations of the EC is connected through RPMSG.
> > > > > +      - items:
> > > > > +          - const: google,cros-ec-rpmsg
> > > > >
> > > > >    controller-data:
> > > > >      description:
> > > > > @@ -176,6 +189,37 @@ allOf:
> > > > >          - reg
> > > > >          - interrupts
> > > > >
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: google,cros-ec-fp
> > > > > +    then:
> > > > > +      properties:
> > > > > +        '#address-cells': false
> > > > > +        '#size-cells': false
> > > > > +        typec: false
> > > > > +        ec-pwm: false
> > > > > +        keyboard-controller: false
> > > > > +        proximity: false
> > > > > +        codecs: false
> > > > > +        cbas: false
> > > > > +
> > > > > +      patternProperties:
> > > > > +        "^i2c-tunnel[0-9]*$": false
> > > > > +        "^regulator@[0-9]+$": false
> > > > > +        "^extcon[0-9]*$": false
> > > >
> > > > Is the list of what's allowed shorter? If so, you could list those
> > > > properties and use 'additionalProperties: false'.
> > >
> > > Yes.
> > >
> > > >
> > > > Or maybe this is a sign that this should be a separate schema document.
> > >
> > > I couldn't figure that out. I tried to add new properties here but it
> > > didn't work.
> >
> > Like this?:
> >
> > then:
> >   properties:
> >     allowed-prop-1: true
> >     allowed-prop-2: true
> >     allowed-prop-3: true
> >   additionalProperties: false
> 
> It doesn't seem to combine constraints?
> 
> I get this error:
> 
> 	Documentation/devicetree/bindings/mfd/google,cros-ec.example.dt.yaml:
> 	ec@0: Additional properties are not allowed ('$nodename' was unexpected)

That would be a bug or limitation in the tools. We would need to add 
all the other properties we automatically add as well... I think either 
leaving it as-is or a separate file is going to be the better route 
here.

Rob
