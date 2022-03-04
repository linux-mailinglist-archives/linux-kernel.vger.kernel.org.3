Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218B4CD674
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCDObv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiCDObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:31:49 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0C1B6E05;
        Fri,  4 Mar 2022 06:31:01 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id a6so7962523oid.9;
        Fri, 04 Mar 2022 06:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PRcoDd6e5pTSWSDNB57phipwxCHGJPb3RfLFoPodZQ=;
        b=QGnafN8gNDseAT3enl8/d4EcrT0wBouxT07iNMEMqKYtbGOINa4bvdP9AZCrWkFBBK
         DNw3KwOj4gq7owdO5NfEAmFffk/GKWnmjy9eZzFpXgrHkkpylevav9OB+8hTZ+HuU0TA
         sCuiAD+WY81sj7DJGuBt7jxcuGnE9s06HwXtdBOk/z6zhPbQQH7HQN/50E6On6e1NLGC
         vAk9SMilcm/u6Yax4zdA/MzhJKn11BlG6F7JWdNbitia1D2xOderEn1Zfq/OOXrSEkxP
         C/b/zeEyTS1SR3CvBhZKEwC/ld33EBcgOT8baUo+rCCvZUatREa/odqjE4hJ3PBVXh/y
         0MUw==
X-Gm-Message-State: AOAM533DsiwSlvd6NNsmU6TXpi/Auy87QXwjLlhsj6twA6kRYZc9v4fa
        RPA7tAV2eL2EUSsLEi3mUPrbP8rZ2g==
X-Google-Smtp-Source: ABdhPJxgFjet6DHJYjwSA/CVxxo72Wc5mEvkMEFHT26L/8KvHO9PM+GrI9tTCN8bOrkkfts2nI26Ag==
X-Received: by 2002:a05:6808:2095:b0:2d5:328d:f61b with SMTP id s21-20020a056808209500b002d5328df61bmr9500712oiw.9.1646404260980;
        Fri, 04 Mar 2022 06:31:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r18-20020a056830081200b005ad10dfcf60sm2347847ots.67.2022.03.04.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:31:00 -0800 (PST)
Received: (nullmailer pid 3877594 invoked by uid 1000);
        Fri, 04 Mar 2022 14:30:59 -0000
Date:   Fri, 4 Mar 2022 08:30:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
 dt-validate
Message-ID: <YiIio1dJd5mvMr0v@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-2-robh@kernel.org>
 <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
 <YiIa3Ox7UBLyBtoR@robh.at.kernel.org>
 <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
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

On Fri, Mar 04, 2022 at 03:05:13PM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Fri, Mar 4, 2022 at 2:57 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Mar 04, 2022 at 10:32:29AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > > > In preparation for supporting validation of DTB files, the full
> > > > processed schema will always be needed in order to extract type
> > > > information from it. Therefore, the processed schema containing only
> > > > what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> > > > gained an option, -l or --limit, to specify which schema(s) to use for
> > > > validation.
> > > >
> > > > As the command line option is new, we the minimum dtschema version must be
> > > > updated.
> > > >
> > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/Documentation/devicetree/bindings/Makefile
> > > > +++ b/Documentation/devicetree/bindings/Makefile
> > > > @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
> > > >  DT_SCHEMA_LINT := $(shell which yamllint || \
> > > >    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
> > > >
> > > > -DT_SCHEMA_MIN_VERSION = 2021.2.1
> > > > +DT_SCHEMA_MIN_VERSION = 2022.3
> > >
> > > This doesn't work as-is, as that version hasn't been tagged yet ;-)
> >
> > I had to make sure people are paying attention. You win the prize. :)
> >
> > It's there now.
> 
> Thanks, confirmed.
> 
> With this series applied, the various salvator-xs DTS files are now
> throwing up:
> 
>     sata: size (19) error for type phandle
>     backlight: size (11) error for type phandle

Those come from the code decoding the properties[1]. Unfortunately, I 
haven't come up with a prettier way to report those with the filename. I 
may just remove it because if decoding the property fails, we'll get 
schema errors later on anyways.

But I don't see any 'sata' properties in the DTS files and 'backlight' 
is a node. Are you building with '-@'? I probably need to skip 
__symbols__ nodes. The overlay side is handled because examples are 
built as overlays (to allow unresolved phandles).

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/dtb.py#L149
