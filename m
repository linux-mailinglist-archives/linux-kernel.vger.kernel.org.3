Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2208546748
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbiFJNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiFJNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:23:14 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560B655F;
        Fri, 10 Jun 2022 06:23:11 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id s23so25255949iog.13;
        Fri, 10 Jun 2022 06:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zk41DWxqcCrUcOmNAlHBuuam8bwwgCEDw3C2FONqZ6o=;
        b=Setkl3N9Xjl/AfanTZ4CFVjmjKeRuD/NMTNf2/GrppJvt/a4lTAszm9xmmec42bCr6
         KLW483pIKkG/gjJUCuMnSMgg7fApHs3MjBG972vk1eoB33atZ23ac/tATRE2KhPSrf2t
         iabLeEYQDHn9eR1FKeLb7Uc+VkTgBCjoPzMfTYUkXpdpg+MpDY2R00l3LDsw/WrEet1B
         PbZHvIarykTU06FydWqOZHTRS+zFXB3BcUnzmUT87+U/qWqZu6Ar3ZOvaqdS48TzXRd4
         /lavJbMsFCoPMXiIAcIQKyeeidp5xhA2U7DfSr+ib0wrh9U0iGlrV9nVqVePYZilgCKJ
         fnPg==
X-Gm-Message-State: AOAM530ghHfLEKoavNIJIxSnsbLEzd/a5uH7rBJJG1S3Ju0j7AwVYk0K
        E19SfadCGKcFd/F/eBo0Kw==
X-Google-Smtp-Source: ABdhPJzC53GXbmd10pkreXql55ziRoJcxSWV0N2cgm8S98ToBfVY+dx9HOYXlaXmtxcJVSgoOfsa2w==
X-Received: by 2002:a05:6638:348d:b0:331:d8f0:fd9d with SMTP id t13-20020a056638348d00b00331d8f0fd9dmr8577668jal.165.1654867390891;
        Fri, 10 Jun 2022 06:23:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id x13-20020a92300d000000b002d3a3f4685dsm11733602ile.21.2022.06.10.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:23:10 -0700 (PDT)
Received: (nullmailer pid 1543585 invoked by uid 1000);
        Fri, 10 Jun 2022 13:23:08 -0000
Date:   Fri, 10 Jun 2022 07:23:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: input: Increase maximum keycode
 value to 0x2ff
Message-ID: <20220610132308.GA1530409-robh@kernel.org>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-2-robh@kernel.org>
 <dbd56518-e688-3b3b-08ae-63f66004e62a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd56518-e688-3b3b-08ae-63f66004e62a@gmx.de>
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

On Thu, Jun 09, 2022 at 07:46:51AM +0200, Heinrich Schuchardt wrote:
> On 6/8/22 23:12, Rob Herring wrote:
> > The maximum keycode value for Linux is 0x2ff, not 0xff. There's already
> > users and examples with values greater than 0xff, but the schema is not
> > yet applied in those cases.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/input/input.yaml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> > index d41d8743aad4..43d2f299c332 100644
> > --- a/Documentation/devicetree/bindings/input/input.yaml
> > +++ b/Documentation/devicetree/bindings/input/input.yaml
> > @@ -21,7 +21,7 @@ properties:
> >       $ref: /schemas/types.yaml#/definitions/uint32-array
> >       items:
> >         minimum: 0
> > -      maximum: 0xff
> > +      maximum: 0x2ff
> 
> Can this value of 0x2ff be make exportable such that we can use it as a
> reference in devicetree/bindings/input/adc-keys.yaml. E.g. define a type
> that only take values in the 0-0x2ff range?

There's no need. The $ref to input.yaml in does that effectively 
already. That's why 'linux,code' doesn't need any schema constraints 
unless it has additional constraints. max77650-onkey.yaml in patch 2 has 
an example of that. If you wanted to add a new, custom property with 
those constraints, then we could do something like this:

$defs:
  input-codes:
    minimum: 0
    maximum: 0x2ff
    ...

And then have: $ref: input.yaml#/$defs/input-codes

Rob
