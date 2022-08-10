Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407458F202
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiHJR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiHJR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:58:38 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314D642C5;
        Wed, 10 Aug 2022 10:58:37 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id r6so8675228ilc.12;
        Wed, 10 Aug 2022 10:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SY02ZkdHYX34GvboJkr16ACg+9RvpT639cg2EBcSKVU=;
        b=vNSCkkvrv4XJXAyPpFd5OL//YvIJl2gQhL7qZXi2hLLqG/0KeoofnyxhC5Ed2Py8VN
         ltMTHAKhXw14h/DPwq1+gb//ndfcuLYyHhWxDupT8oa7ZTM7OMQlunFwKjDajHCkMwLl
         qMwNTrJZpdKNz0QVFRUXRLmyq82v7ap8/HqU0N1AdmLs1VCsoSKyTnOiK9N3lfPBQB0k
         HKBNESCyZ293WlMwmwXGAbKSGhcvj++IzzBB0/CSt0HKDg6Xau87TKXBU4AkTfOlMKR+
         5iK0TDyL/yTDfBxSrZSDcu7Vl2IIDF+HQ40fHpAc3953FaT9VhAMnV3ubpK0tjkGIkVx
         Si/w==
X-Gm-Message-State: ACgBeo1aZRlBboyKMNBa+2zqVPKJlok8Meh5MRUO2BJ3wwHXn1sjxX23
        3QziGcu1Cxs7oNx7mlwiKw==
X-Google-Smtp-Source: AA6agR7CyLdpEOLqF49H79wXqu/iPyHRTwMYE1VpEee0uUoWBOyXb6YmlWzXeAdJ2yMCJbwNs+ofvA==
X-Received: by 2002:a92:2a0a:0:b0:2d9:2571:f57e with SMTP id r10-20020a922a0a000000b002d92571f57emr13004446ile.154.1660154316973;
        Wed, 10 Aug 2022 10:58:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a3-20020a027343000000b003316f4b9b26sm7743726jae.131.2022.08.10.10.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 10:58:36 -0700 (PDT)
Received: (nullmailer pid 240872 invoked by uid 1000);
        Wed, 10 Aug 2022 17:58:35 -0000
Date:   Wed, 10 Aug 2022 11:58:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] ASoC: dt-bindings: fsl, sai: Convert format to
 json-schema
Message-ID: <20220810175835.GB200295-robh@kernel.org>
References: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
 <e81d657f-edea-4c5d-e546-e3bdb379c659@linaro.org>
 <CAA+D8AP3o-sRtzBEQEPEOVXW2vACf38fWy=jJ0AGrxTrO=W4yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AP3o-sRtzBEQEPEOVXW2vACf38fWy=jJ0AGrxTrO=W4yA@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 11:01:16PM +0800, Shengjiu Wang wrote:
> On Tue, Jul 26, 2022 at 4:05 AM Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 25/07/2022 11:31, Shengjiu Wang wrote:
> > > Convert the NXP SAI binding to DT schema format using json-schema.
> > >
> > > The Synchronous Audio Interface (SAI) provides an interface that
> > > supports full-duplex serial interfaces with frame synchronization
> > > formats such as I2S, AC97, TDM, and codec/DSP interfaces.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,sai.yaml    | 175 ++++++++++++++++++
> > >  .../devicetree/bindings/sound/fsl-sai.txt     |  95 ----------
> > >  2 files changed, 175 insertions(+), 95 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > new file mode 100644
> > > index 000000000000..adcd77531eba
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> > > @@ -0,0 +1,175 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale Synchronous Audio Interface (SAI).
> > > +
> > > +maintainers:
> > > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > > +
> > > +description: |
> > > +  The SAI is based on I2S module that used communicating with audio
> > codecs,
> > > +  which provides a synchronous audio interface that supports fullduplex
> > > +  serial interfaces with frame synchronization such as I2S, AC97, TDM,
> > and
> > > +  codec/DSP interfaces.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    minItems: 1
> > > +    maxItems: 2
> >
> > You allow anything here, so it's not acceptable. This has to be strictly
> > defined.
> >
> 
> ok, I will update it.
> 
> >
> > > +    items:
> > > +      enum:
> > > +        - fsl,vf610-sai
> > > +        - fsl,imx6sx-sai
> > > +        - fsl,imx6ul-sai
> > > +        - fsl,imx7ulp-sai
> > > +        - fsl,imx8mq-sai
> > > +        - fsl,imx8qm-sai
> > > +        - fsl,imx8mm-sai
> > > +        - fsl,imx8mn-sai
> > > +        - fsl,imx8mp-sai
> > > +        - fsl,imx8ulp-sai
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: receive and transmit interrupt
> > > +
> > > +  dmas:
> > > +    minItems: 2
> >
> > No need for minItems.
> >
> 
> ok
> 
> 
> >
> > > +    maxItems: 2
> > > +    description:
> > > +      Must contain a list of pairs of references to DMA specifiers, one
> > for
> > > +      transmission, and one for reception.
> >
> > Skip description and instead describe items like you did for interrupts.
> >
> 
> ok, will update it
> 
> >
> > > +
> > > +  dma-names:
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +    items:
> > > +      enum:
> > > +        - tx
> > > +        - rx
> >
> > No, this has to be strictly defined, so items with tx and rx (or
> > reversed order).
> >
> 
> two kind of order is needed, seems I need to use
> if - then -else

No, pick the more common one for the schema and fix the dts files for 
the less common case.

Rob
