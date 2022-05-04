Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6139C51A304
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351777AbiEDPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbiEDPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:07:20 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F642FFD1;
        Wed,  4 May 2022 08:03:44 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-ed8a3962f8so1441081fac.4;
        Wed, 04 May 2022 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XSZeXWgi4scPvbVkMMEIf9HkEBqk/lFaT7ukZmszpk=;
        b=sZGtUYjY43mgvIrf/c2MNmU4SDTyBzWs895Qub/gUyb+WHjTo+3bxUK4JMG9m94Hab
         PNFPCx6tqioltSH9iQq9antpTij8w+RsnB585snAiHZFFpS8I1NGqAdm/kg7P2WpxnkO
         uxSFjemIhP2I9J7WA/W7DAtaBjdhqFqcWP4QSdW1O8e4uX57kZMd3ObubBHzQgLj7G61
         wdIFRAvUWZ2K0MSNDKaVoIVZuSeX9HsDYJX4oLWSkLYoQ5SMnAQS+Ryxx3/uMtJUnR55
         OJpVCVJrgVWtEZd9FFM0Uv4wPbZBi6QPUpKNWDaeug95vKkVOGuMjpvjjkmzi030oxot
         EGvw==
X-Gm-Message-State: AOAM530KDt8yIH9ey1XDjNHqELhPpxItVOm2WD0nZyGmxflJOpI5W5dW
        CE/cHURXBBJL5N/IED99oA==
X-Google-Smtp-Source: ABdhPJwyXyp8l3/4eYbxsDquSInxw4zswI4vbcnE0ZLs7FRe5OuFOWyn3uGDkvricFp3AuWNeqamNA==
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id a22-20020a056870619600b000e1e1a25c65mr4042232oah.190.1651676623681;
        Wed, 04 May 2022 08:03:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a9d7685000000b006060322125asm5350223otl.42.2022.05.04.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:03:43 -0700 (PDT)
Received: (nullmailer pid 1707807 invoked by uid 1000);
        Wed, 04 May 2022 15:03:42 -0000
Date:   Wed, 4 May 2022 10:03:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Message-ID: <YnKVzvAITXAHqSiX@robh.at.kernel.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
 <20220503193937.3794477-2-swboyd@chromium.org>
 <faaa4ab4-8190-3cff-998e-3b6a6d3ce27c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faaa4ab4-8190-3cff-998e-3b6a6d3ce27c@linaro.org>
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

On Wed, May 04, 2022 at 08:20:40AM +0200, Krzysztof Kozlowski wrote:
> On 03/05/2022 21:39, Stephen Boyd wrote:
> > We need to configure the sleep and idle mode of the CS pins for this
> > device. Add a DT property to do this so pins are in a proper state
> > during sleep (either hi-z, grounded, or pulled up to vdd).
> > 
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > index d265eb5258c8..b3aa2ebf9661 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > @@ -126,6 +126,14 @@ properties:
> >        UINT_MAX (4294967295) represents infinite. Other values
> >        represent 1-1/N.
> >  
> > +  semtech,cs-idle-sleep:
> > +    description:
> > +      State of CS pins during sleep mode and idle time.
> > +    enum:
> > +      - hi-z
> > +      - gnd
> > +      - vdd
> 
> You need a ref to type (string).

Actually, it can be implicit for single strings.

Rob
