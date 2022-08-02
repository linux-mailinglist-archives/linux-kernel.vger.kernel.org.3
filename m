Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A9A587E52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiHBOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiHBOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:46:06 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302BA286C7;
        Tue,  2 Aug 2022 07:46:05 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id d4so7097893ilc.8;
        Tue, 02 Aug 2022 07:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YWdMhY/w6xJGnTNrD3+yPIQp9IMoWMfQJOwkWlFi+RQ=;
        b=UkfW133lkPqM4U5g4pZNc5TWRf77vc0/jF1Ip42D0q+33NTLSi/zumy1ARwbUnRF7M
         6Mg14nQJumaeG1GqJ3wn76MNOIkUhBLUaBzqXiG7OrPX7wChWJ8UpZJ/TmSFdCfRm9gw
         H+Vm+3o8ID1fnpbZsf9WNZfLd0uMm1ctbQz+MQtipGj9BkwVqHNF0dY8KAC+UWzR9f3N
         l2s3XN5ogPtppoTx3eegxt1MAQycLMzzlL9OGST4XGnZf5lWirBrqnAVbcx0Tvy7fnrf
         GVhJe1WiVGY5I79cdpkEe/adU048JiRW75WO+wRvOIop1W3aS7d0tqKY3VhDMBjaNncs
         k/PA==
X-Gm-Message-State: ACgBeo3GPxPt2xFtkl2KvOq8n5dE9gzZmWWT+mFFqj5dDFw4ncW+0/v9
        dvkDUf1zD8e1D2hGM/WwkQ==
X-Google-Smtp-Source: AA6agR5WgaywX71Mi/tssUPXgR+p0/h9FgYemIjJDIjmuwbCJAULertTvwumkbhjtOaFmgv9kXdbvQ==
X-Received: by 2002:a05:6e02:1d18:b0:2de:b805:99f1 with SMTP id i24-20020a056e021d1800b002deb80599f1mr3169607ila.61.1659451564182;
        Tue, 02 Aug 2022 07:46:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j4-20020a026304000000b00341d7c43ed5sm6405840jac.73.2022.08.02.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:46:03 -0700 (PDT)
Received: (nullmailer pid 79583 invoked by uid 1000);
        Tue, 02 Aug 2022 14:46:02 -0000
Date:   Tue, 2 Aug 2022 08:46:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: Add schema for common DAI
 params
Message-ID: <20220802144602.GA30116-robh@kernel.org>
References: <1659370052-18966-1-git-send-email-spujar@nvidia.com>
 <1659370052-18966-2-git-send-email-spujar@nvidia.com>
 <1659382247.124005.1380281.nullmailer@robh.at.kernel.org>
 <982b3f0c-0b6c-d531-3d75-27d5ca1aabec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982b3f0c-0b6c-d531-3d75-27d5ca1aabec@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:15:28PM +0530, Sameer Pujar wrote:
> Hi Rob, Krzysztof
> 
> On 02-08-2022 01:00, Rob Herring wrote:
> > On Mon, 01 Aug 2022 21:37:30 +0530, Sameer Pujar wrote:
> > > The "convert-channels" and "convert-rate" bindings are provided for both
> > > simple-card and audio-graph-card. However these are separately defined in
> > > their respective schemas. For any new binding addition, which is common to
> > > both, there will be duplication.
> > > 
> > > Introduce a new schema to have common DAI params properties and these can
> > > be re-used in other schemas wherever applicable.
> > > 
> > > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > >   .../bindings/sound/audio-graph-port.yaml           | 13 ++++------
> > >   .../devicetree/bindings/sound/audio-graph.yaml     |  7 +++---
> > >   .../devicetree/bindings/sound/dai-params.yaml      | 28 ++++++++++++++++++++++
> > >   .../devicetree/bindings/sound/simple-card.yaml     | 16 ++++---------
> > >   4 files changed, 40 insertions(+), 24 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/sound/dai-params.yaml
> > > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-rate: 'oneOf' conditional failed, one must be fixed:
> >          'type' is a required property
> >                  hint: A vendor boolean property can use "type: boolean"
> >          'description' is a required property
> >                  hint: A vendor boolean property can use "type: boolean"
> >          Additional properties are not allowed ('$ref' was unexpected)
> >                  hint: A vendor boolean property can use "type: boolean"
> >          /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/simple-card.yaml: properties:simple-audio-card,convert-rate: 'oneOf' conditional failed, one must be fixed:
> >                  'enum' is a required property
> >                  'const' is a required property
> >                  hint: A vendor string property with exact values has an implicit type
> >                  from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> >          '/schemas/sound/dai-params.yaml#/properties/dai-sample-rate' does not match 'types.yaml#/definitions/'
> >                  hint: A vendor property needs a $ref to types.yaml
> >          '/schemas/sound/dai-params.yaml#/properties/dai-sample-rate' does not match '^#/(definitions|\\$defs)/'
> >                  hint: A vendor property can have a $ref to a a $defs schema
> >          hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> >          from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 
> I am hitting this error if I use properties/definitions from another schema.
> If I define it locally, it works. I see there are examples where properties
> from different schema are used. But not able to understand why errors are
> seen in my case. Am I missing anything here?

You either need to use 'properties' with actual property names and 
reference that schema from the node level. Or you use '$defs' if you are 
going to have references from the (DT) property level. I think I'd just 
leave simple-card out of this and do the former.
