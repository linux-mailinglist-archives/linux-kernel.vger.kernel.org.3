Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA40552BFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiERQN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbiERQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:13:53 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B9E1E15EC;
        Wed, 18 May 2022 09:13:51 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id m25so3248779oih.2;
        Wed, 18 May 2022 09:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMRzRjNkhQaoss3LUukTdqhzCy7CcmpSVBk5VUCkb9s=;
        b=zyMlM9HF46MjtpV+FhdKfoMIgHyF5yVz0iANuM00Wi4pezlIG3HCPIdgXw8Zl6dqUL
         kpw84fsUIBRSIpuvlFMQM3Yx2SiO22DAuD3HxzkoAEqVUwmyevi5zXAudaX10hF6J8UW
         6dGFSVuGTfHHR43MDr7OoSSOB5uNY9LLBRK16w25bs4QKOfTKKxC/BRM9g0lfqFqZ06T
         VAhmQARh526Da+MMhffG93S4rc0TdIbL1MkR4vhCTVlIYXNi5NAjjsBYhMHGmr9r9BJ0
         yJsPOUdoGL9FHY3QfZBRsjlIKE4xN5ucjoTuZGvOilhUztC3KFFuQhqpaBQQ36GE2Rjq
         rD5w==
X-Gm-Message-State: AOAM5325Xxqhtua1c/wUDcdmyN4GHRvmGkHkoLagOhNxT44giyPGazDh
        1qlZuX4eQdDNSLzqEN4Gkg==
X-Google-Smtp-Source: ABdhPJyM9gwyKZVov5+zkaUB7f6qEXaq1g8vl/n6jJMV9V/BxktLQUhEiUx2l0QFmP2O5mN//53iXA==
X-Received: by 2002:a05:6808:130b:b0:326:d1ff:b56f with SMTP id y11-20020a056808130b00b00326d1ffb56fmr405915oiv.222.1652890431032;
        Wed, 18 May 2022 09:13:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d5-20020a056870e24500b000e90544b79fsm1127031oac.41.2022.05.18.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 09:13:49 -0700 (PDT)
Received: (nullmailer pid 3422741 invoked by uid 1000);
        Wed, 18 May 2022 16:13:48 -0000
Date:   Wed, 18 May 2022 11:13:48 -0500
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
Message-ID: <20220518161348.GC3302100-robh@kernel.org>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-4-swboyd@chromium.org>
 <20220516152003.GB2659134-robh@kernel.org>
 <CAE-0n53p1mKME=vfed2SB7UXrg9K+-vbp6JPHJBchJc-Pp1Hgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53p1mKME=vfed2SB7UXrg9K+-vbp6JPHJBchJc-Pp1Hgg@mail.gmail.com>
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

On Mon, May 16, 2022 at 12:23:03PM -0700, Stephen Boyd wrote:
> Quoting Rob Herring (2022-05-16 08:20:03)
> > On Wed, May 11, 2022 at 06:39:21PM -0700, Stephen Boyd wrote:
> > > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > index 409ecef967ce..e5fe60beb9fe 100644
> > > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > > @@ -19,15 +19,19 @@ description:
> > >  properties:
> > >    compatible:
> > >      oneOf:
> > > -      - description:
> > > -          For implementations of the EC is connected through I2C.
> > > -        const: google,cros-ec-i2c
> > > -      - description:
> > > -          For implementations of the EC is connected through SPI.
> > > -        const: google,cros-ec-spi
> > > -      - description:
> > > -          For implementations of the EC is connected through RPMSG.
> > > -        const: google,cros-ec-rpmsg
> > > +      # For implementations of the EC is connected through I2C.
> >
> > Using 'description' was preferred.
> 
> I just learned that I should use anyOf instead of oneOf. Confusing!

Uhh, no. It can only be one of these entries at a time.


> >
> > > +      - items:
> > > +          - const: google,cros-ec-i2c
> > > +      # For implementations of the FPMCU connected through SPI.
> > > +      - items:
> > > +          - const: google,cros-ec-fp
> > > +          - const: google,cros-ec-spi
> > > +      # For implementations of the EC is connected through SPI.
> > > +      - items:
> > > +          - const: google,cros-ec-spi
> > > +      # For implementations of the EC is connected through RPMSG.
> > > +      - items:
> > > +          - const: google,cros-ec-rpmsg
> > >
> > >    controller-data:
> > >      description:
> > > @@ -176,6 +189,37 @@ allOf:
> > >          - reg
> > >          - interrupts
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: google,cros-ec-fp
> > > +    then:
> > > +      properties:
> > > +        '#address-cells': false
> > > +        '#size-cells': false
> > > +        typec: false
> > > +        ec-pwm: false
> > > +        keyboard-controller: false
> > > +        proximity: false
> > > +        codecs: false
> > > +        cbas: false
> > > +
> > > +      patternProperties:
> > > +        "^i2c-tunnel[0-9]*$": false
> > > +        "^regulator@[0-9]+$": false
> > > +        "^extcon[0-9]*$": false
> >
> > Is the list of what's allowed shorter? If so, you could list those
> > properties and use 'additionalProperties: false'.
> 
> Yes.
> 
> >
> > Or maybe this is a sign that this should be a separate schema document.
> 
> I couldn't figure that out. I tried to add new properties here but it
> didn't work.

Like this?:

then:
  properties:
    allowed-prop-1: true
    allowed-prop-2: true
    allowed-prop-3: true
  additionalProperties: false

> And then when I tried to make a different schema document
> it complained that the example for google,cros-ec-spi in here had a
> problem.

You probably need a custom 'select' so that both schemas aren't 
matching. Otherwise a schema is applied if any of the compatible strings 
match.

> Can properties be defined in this section? 

Yes, but discouraged for vendor specific properties. The if/then should 
really be just additional constraints.

Rob
