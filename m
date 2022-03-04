Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD464CD5A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiCDN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbiCDN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:56:49 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A41A94BE;
        Fri,  4 Mar 2022 05:56:01 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so7495484otn.2;
        Fri, 04 Mar 2022 05:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F4BEuWjdvB4IxC7cOosJvlKNe0JC2a1oUGDV4WHlCFQ=;
        b=pyatyDZec39hSFP3Szv3rQ/He3DbhQ6BGmrFvkgY6tl4uTyHceDVNdjqcfYtEHKhF/
         /VdZ6C5MFmjUKWLe/I7wOSi098kiIfyMmrPTqM4yqZzpxpDkWGmXGHwLh4FXEI/H+xFr
         J8XeB9+/2IkqMxBSry1OM/9VBS33XlpCMAaYRn6QKaHxV2Xwozq5oAkq2Boiued/26qO
         rhwv6wUXq0HvPok56Gqt01lZOFQ1/+G0IBk+vDKHlb4zWY8FwNEnyAExut8fpTEj0y0Y
         UBVWpPJeqmB3fhJnK22R72i+aHbwNtgUiZlnfLgFkiE9xjKw+8aXeGh0qK1xctU8h0Em
         FjeQ==
X-Gm-Message-State: AOAM5326gzvFVqMo25zUnSR8iCGQa7Wdxepp/ZpKJ5bfip+4IBUQH2/V
        bet0AFIWs3gOzRb0Fkhni+TVzsI7ZQ==
X-Google-Smtp-Source: ABdhPJy4N6TB/t01GBgXThASK/Qol3Vsv8ZZq7Oi4wOHD9586D5rAtX6jlsFuwjwYrHWqr+qTaq/dw==
X-Received: by 2002:a9d:6008:0:b0:5b0:2de8:31b1 with SMTP id h8-20020a9d6008000000b005b02de831b1mr12290119otj.381.1646402161185;
        Fri, 04 Mar 2022 05:56:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830402b00b005af1411565bsm2288310ots.78.2022.03.04.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:56:00 -0800 (PST)
Received: (nullmailer pid 3825460 invoked by uid 1000);
        Fri, 04 Mar 2022 13:55:59 -0000
Date:   Fri, 4 Mar 2022 07:55:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: kbuild: Print a warning if yamllint is not
 found
Message-ID: <YiIab+sR1vPFPGHQ@robh.at.kernel.org>
References: <20220303221417.2486268-1-robh@kernel.org>
 <CAMuHMdU+LCumdzAFtqnRECxsUzpYD_69nVgy9zE0-KXewE1FVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU+LCumdzAFtqnRECxsUzpYD_69nVgy9zE0-KXewE1FVQ@mail.gmail.com>
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

On Fri, Mar 04, 2022 at 09:59:12AM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Mar 3, 2022 at 11:15 PM Rob Herring <robh@kernel.org> wrote:
> > Running yamllint is effectively required for binding schemas, so print a
> > warning if not found rather than silently skipping running it.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -3,7 +3,8 @@ DT_DOC_CHECKER ?= dt-doc-validate
> >  DT_EXTRACT_EX ?= dt-extract-example
> >  DT_MK_SCHEMA ?= dt-mk-schema
> >
> > -DT_SCHEMA_LINT = $(shell which yamllint)
> > +DT_SCHEMA_LINT := $(shell which yamllint || \
> > +  echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
> 
> Do we want to encourage people to use pip, instead of their distro's
> package manager? At least Debian/Ubuntu provide yamllint packages.
> 
> So perhaps drop the install rule?

Okay, that's what I originally had. I'm sure someone will want to 
document 'how to install yamllint' somewhere. Maybe I'll say:

warning: python package 'yamllint' not installed, skipping

To give some hint how to install.

I'm not sure exactly, but there is a minimum version of yamllint so it 
is possible the distro versions are too old. IIRC, unknown config 
settings throw an error. I think at the time I did the config everything 
had been around for at least a year or 2 and I don't think anyone has 
reported issues.

Rob
