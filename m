Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198C04CD5B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiCDN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiCDN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:58:39 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA711140;
        Fri,  4 Mar 2022 05:57:51 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso9429347ooc.12;
        Fri, 04 Mar 2022 05:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UbID0P8Eo3VMadcvAUxxjCahcBCQKhtm/Ne3XGGv5Hc=;
        b=Eqv1i9QBROvD77qvM2TMPz10axX4YvhhkZ08mxhbdPebkRk9FRhKxSiy9b2RuzutWJ
         QXEcODyc02oprXUWkZgsTbIPI2GoRfRTpcxQeL0X8B11AtGcPmMcd8T/autraMrNS77n
         mzRA7FV1XvC2DL2hSXJ0fuMlmeXc+PRwNiKCpFVloeArzDISszRulTeXqgpNkSSccnnr
         Pfj107JtU/XSRhJgQE4TZ9O02VAvXXvlW6T+DYSBYwedBA/Hz8/dDNaINKrXCkBCbus0
         6koA9RXXoLt+6KxufJvO7Q792iD8lSQ3MAE1mwnUyQBnaNpW33I/TPG3FAkywZUxGMPV
         +Aww==
X-Gm-Message-State: AOAM532n2VTnVwm77lPMpleCIihUS7LoPXvSzSvdzLaVcNF6aaGTm0Un
        yp9VowGy0bIgwHz9hy1Zzw==
X-Google-Smtp-Source: ABdhPJyK8lWDwChPm4CqPFJlw7gao0Q8KgeZQuFTEJoj/PxItHKBZxpDzZsQXpfDgEfTaOpWEy1eQQ==
X-Received: by 2002:a05:6870:ac21:b0:d9:c32a:ce76 with SMTP id kw33-20020a056870ac2100b000d9c32ace76mr4306965oab.141.1646402270704;
        Fri, 04 Mar 2022 05:57:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm2807838oaf.10.2022.03.04.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:57:49 -0800 (PST)
Received: (nullmailer pid 3828194 invoked by uid 1000);
        Fri, 04 Mar 2022 13:57:48 -0000
Date:   Fri, 4 Mar 2022 07:57:48 -0600
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
Message-ID: <YiIa3Ox7UBLyBtoR@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-2-robh@kernel.org>
 <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
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

On Fri, Mar 04, 2022 at 10:32:29AM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > In preparation for supporting validation of DTB files, the full
> > processed schema will always be needed in order to extract type
> > information from it. Therefore, the processed schema containing only
> > what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> > gained an option, -l or --limit, to specify which schema(s) to use for
> > validation.
> >
> > As the command line option is new, we the minimum dtschema version must be
> > updated.
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
> >  DT_SCHEMA_LINT := $(shell which yamllint || \
> >    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
> >
> > -DT_SCHEMA_MIN_VERSION = 2021.2.1
> > +DT_SCHEMA_MIN_VERSION = 2022.3
> 
> This doesn't work as-is, as that version hasn't been tagged yet ;-)

I had to make sure people are paying attention. You win the prize. :)

It's there now.

Rob
