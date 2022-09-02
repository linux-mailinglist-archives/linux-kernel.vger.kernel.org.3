Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7585AB973
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiIBU0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIBUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:25:49 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA11847BBB;
        Fri,  2 Sep 2022 13:24:55 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so2238899otk.0;
        Fri, 02 Sep 2022 13:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vG1MH2rrlY6mMv1XGgUJJpIJquW5QeziZABMxlN3xC4=;
        b=I0nKsuEwuAGcito5pqYih3dFJ5Ir4r8ka6a1mV2xfW7/dxqyEX39vyCMX4DfgVvUHY
         k0AuHNnpkBxAGDGGSc+X7A2caZUb3wA71mMnINkPmIHko0yyZbHaA9SerVwr/+LzhsPp
         OsQnWMoeu0XiWaQeK6PftBEHrAlQBJEo3eDGgjRqG8G/UCn9ldZwML9Njz+MRfLxZctV
         5mZ3j79Iv212xUCl4uMYDwsL+1X5AwfSjFBlWTphSGvzXucdkvOTW/cpDOno5RADfW6b
         DTtNs3pMmWzI7JOglolRoLcUxaxCEkgA3CGK2fTarIYwHoBB8SAvsJNOFpCHfdbBY3MZ
         t3HA==
X-Gm-Message-State: ACgBeo2LfNxkih5ZKQngMpidnlXFwh1k2QuCzMBAT0tld9IvKUCdjVYI
        X0nDNmG7hwfazll0duR2PA==
X-Google-Smtp-Source: AA6agR7j18abGexrPaOq6Gma7XiT7wWZCvt7uenJRmbxJXX/gI5+T+rjmp1NK+HLW70suMrOSEvcyQ==
X-Received: by 2002:a9d:6853:0:b0:639:2702:bad9 with SMTP id c19-20020a9d6853000000b006392702bad9mr15414876oto.88.1662150294939;
        Fri, 02 Sep 2022 13:24:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h16-20020a4abb90000000b0044584998c9asm1000814oop.38.2022.09.02.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:24:54 -0700 (PDT)
Received: (nullmailer pid 354649 invoked by uid 1000);
        Fri, 02 Sep 2022 20:24:53 -0000
Date:   Fri, 2 Sep 2022 15:24:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: memory: Add jedec,lpddr4 and
 jedec,lpddr5 bindings
Message-ID: <20220902202453.GA338977-robh@kernel.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-4-jwerner@chromium.org>
 <983c1224-8174-3534-a276-d1ab1f9968a4@linaro.org>
 <CAODwPW_70kdn4XTCs_vhbWwjEXS8E8zC9MTa6-szb5SayvcSag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW_70kdn4XTCs_vhbWwjEXS8E8zC9MTa6-szb5SayvcSag@mail.gmail.com>
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

On Wed, Aug 31, 2022 at 06:10:51PM -0700, Julius Werner wrote:
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> > > index 0c7d2feafd77c8..e1182e75ca1a3f 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> > > @@ -53,9 +53,13 @@ properties:
> > >        - 512
> > >        - 1024
> > >        - 2048
> > > +      - 3072
> > >        - 4096
> > > +      - 6144
> > >        - 8192
> > > +      - 12288
> > >        - 16384
> > > +      - 24576
> > >        - 32768
> >
> > Either you limit now LPDDR2 and LPDDR3 to old values or instead add this
> > bigger list to LPDDR4 and LPDDR5 (if it works that way).
> 
> The problem is that each spec has its own set of valid values, e.g.
> LPDDR3 only defines 4GB, 8GB, 16GB and 32GB, and then LPDDR4 inserted
> the 6GB, 12GB and 24GB options in between there. I don't think there's
> a way to exactly describe the valid values for each version without
> having a whole separate enum list for each. Do you think checking for
> that is important enough to be worth having all that extra duplication
> between the schemas? I don't think it adds that much (e.g. a value for
> an individual memory part can still be wrong even if it is one of the
> valid values for that type, so how much use is this validation
> anyway?), but I can split it out if you want to.

I tend to agree with you that it isn't worth the complexity.


> > > +  serial-id:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description:
> > > +      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
> > > +      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
> > > +    minItems: 8
> >
> > No need for minItems.
> 
> Can you explain why? I'm okay with taking these out, but it is a real
> constraint so I'm not sure why we shouldn't be describing it here?
> (The serial ID always has exactly 8 bytes, an ID with less than 8
> would not be valid and probably a typo.)

Because if minItems is not specified, then it defaults to same as 
maxItems value. This is a departure from json-schema, but we almost 
always need a fixed number here and I didn't want to be specifying 
minItems/maxItems everywhere. We really need a 'numItems' or something.

Rob 
