Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990A2509094
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381819AbiDTTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiDTTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:43:31 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784317056;
        Wed, 20 Apr 2022 12:40:42 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r85so3238373oie.7;
        Wed, 20 Apr 2022 12:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DLOa39jXULqAZgfEl4odR8fyhEkBZ7TBR6PbRHeUf2U=;
        b=KzRYtDkJazpGg2Gbc4F+uZ8VEYmGYE+fNNcPfBdBBallO2P5au2C6mhv/JOZ1Ct0VR
         TXVRVNlidDWjlSY8SnPSMZa0WUURp4BVDl7gTVu4b9JvTMAgKD8KQqOB2GffON3c5Qk5
         LyAe6PpzEj41iLC83bZFckUQ9QypKyvbOf41klCHwGQxXtJS4utD0LzyL6nV98u4jOQu
         lPUoJsjenRU36SsNEy1MWCoSZPPOfC1J58fBKWbVQogHSeXNonZN7eOC23WyFrcMEh28
         GaTZIk+vS6AFJKz/4AklSPBytfFobgdyIrgg4/wholgksnz8uZkf4P/g6PXkvD2/HWm2
         DMAQ==
X-Gm-Message-State: AOAM532Q6XAS6sJ3tbBnoL5rxceR0JF3FG4SA8GoHxCg1ywKpzYJGhdz
        gKpm7AXsweMR5kJktcgIjg==
X-Google-Smtp-Source: ABdhPJwdZReZs8Am9T7uB1bFgpS7/ooMCWbtjFRyeH2kYtJrcfABlnbjYom31O4tUWRByWMAwSTFEw==
X-Received: by 2002:a05:6808:1394:b0:2ec:ddb3:c82b with SMTP id c20-20020a056808139400b002ecddb3c82bmr2563771oiw.274.1650483642151;
        Wed, 20 Apr 2022 12:40:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0181000000b00324a1217e96sm6997914oor.35.2022.04.20.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 12:40:41 -0700 (PDT)
Received: (nullmailer pid 1715358 invoked by uid 1000);
        Wed, 20 Apr 2022 19:40:40 -0000
Date:   Wed, 20 Apr 2022 14:40:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?utf-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dt-binding
Message-ID: <YmBhuOMqqCNJnFGP@robh.at.kernel.org>
References: <20220407082148.571442-1-gengcixi@gmail.com>
 <20220407082148.571442-2-gengcixi@gmail.com>
 <YlcgtLmXwc2s2+oJ@robh.at.kernel.org>
 <CAF12kFuY_t4i2SpAaBvTAOagKVJOf3Awuds1O0J7xvKFgSEQQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF12kFuY_t4i2SpAaBvTAOagKVJOf3Awuds1O0J7xvKFgSEQQg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:26:29PM +0800, Cixi Geng wrote:
> Rob Herring <robh@kernel.org> 于2022年4月14日周四 03:12写道：
> >
> > On Thu, Apr 07, 2022 at 04:21:42PM +0800, Cixi Geng wrote:
> > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > >
> > > sprd,ump9620-adc is one variant of sc27xx series, add ump9620
> > > description and sample in dt-bindings.
> > >
> > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > ---
> > >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 57 +++++++++++++++++--
> > >  1 file changed, 53 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > > index caa3ee0b4b8c..0d0f317b75c5 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > > @@ -20,6 +20,7 @@ properties:
> > >        - sprd,sc2723-adc
> > >        - sprd,sc2730-adc
> > >        - sprd,sc2731-adc
> > > +      - sprd,ump9620-adc
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -34,12 +35,39 @@ properties:
> > >      maxItems: 1
> > >
> > >    nvmem-cells:
> > > -    maxItems: 2
> > > +    description: nvmem-cells.
> > >
> > >    nvmem-cell-names:
> > > -    items:
> > > -      - const: big_scale_calib
> > > -      - const: small_scale_calib
> > > +    description: Names for each nvmem-cells specified.
> >
> > These descriptions of common properties are redundant. Just use 'true'
> > for the property values.
> >
> > > +
> > > +if:
> > > +  not:
> > > +    properties:
> > > +      compatible:
> > > +        contains:
> > > +          enum:
> > > +            - sprd,ump9620-adc
> >
> > Use 'const'
> 
> Hi Rob Herring：
> did you mean I should use "- const: sprd,ump9620-adc"? or change the
> enum to const?
> but the above two modification methods have failed for me to test
> dt-bindings-check.

contains:
  const: sprd,ump9620-adc
