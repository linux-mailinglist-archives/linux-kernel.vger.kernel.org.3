Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CC4CD5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiCDOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiCDOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:04:42 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F0C42B4;
        Fri,  4 Mar 2022 06:03:54 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id x6-20020a4a4106000000b003193022319cso9492384ooa.4;
        Fri, 04 Mar 2022 06:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTCaqh1O5XZhW/tijBJV7Ss/XPMf3dURen6yyNYb0EQ=;
        b=xiDkQfQMiEuUg9DEPiVEkdYQqhBhYG5VB3pNF1Wp8JnrJfQlhZScaitAsbq4cFr6KD
         PEL9IoLTWDXJhIiLISFUZBVrBL350fKhVU9wR9mG6SCkUyif85eYa2/wTWv8wRoNWpyX
         N4BmsrzMBbRTfGJ9gn+idoBv9SstUdDBzUJ8+SKOPZ0qDt0kt6LGcW5Idz449fR0c9zl
         XezI2WU0Yj4iHryaVIQJU5LQ/5Bb4USvm4Y8eo1tySqctfnXijQSgTGC9NzvtobtV6uN
         v0+0W57n0p9HqjiAc/ccY8KaWL+2UcXs2yUAnAqyr7p9HwYhUQ2yK8q1/OhNc5NW1laO
         sm7A==
X-Gm-Message-State: AOAM53207xy8L+I9w9xkky1T3clMKlcXWxVRFaw8Y5GpAjNBu/dDTh+L
        VOF0g6Z5Bhp9g47uybUOQQ==
X-Google-Smtp-Source: ABdhPJzlcguZd7/kRywp7vnasuZ98v2l+ZlfGdO34EqRbIxBXgOkpq9Li2lPIWptMOUgquTIzJcfDA==
X-Received: by 2002:a4a:3447:0:b0:31b:f530:bc52 with SMTP id n7-20020a4a3447000000b0031bf530bc52mr21697770oof.74.1646402633607;
        Fri, 04 Mar 2022 06:03:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i28-20020a056808055c00b002d51e377248sm2664769oig.33.2022.03.04.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:03:52 -0800 (PST)
Received: (nullmailer pid 3837496 invoked by uid 1000);
        Fri, 04 Mar 2022 14:03:51 -0000
Date:   Fri, 4 Mar 2022 08:03:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
 dt-validate
Message-ID: <YiIcRzBjuCgY7OMV@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-2-robh@kernel.org>
 <YiH8lWq8gOnaQ+7G@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiH8lWq8gOnaQ+7G@pendragon.ideasonboard.com>
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

On Fri, Mar 04, 2022 at 01:48:37PM +0200, Laurent Pinchart wrote:
> On Thu, Mar 03, 2022 at 04:42:36PM -0600, Rob Herring wrote:
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
> > ---
> >  Documentation/devicetree/bindings/Makefile | 28 +++-------------------
> >  scripts/Makefile.lib                       |  3 +--
> >  2 files changed, 4 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> > index 61ec18ecc931..246ba0ecab64 100644
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
> >  DT_SCHEMA_LINT := $(shell which yamllint || \
> >    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
> >  
> > -DT_SCHEMA_MIN_VERSION = 2021.2.1
> > +DT_SCHEMA_MIN_VERSION = 2022.3
> >  
> >  PHONY += check_dtschema_version
> >  check_dtschema_version:
> > @@ -25,9 +25,6 @@ quiet_cmd_extract_ex = DTEX    $@
> >  $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
> >  	$(call if_changed,extract_ex)
> >  
> > -# Use full schemas when checking %.example.dts
> > -DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
> > -
> >  find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> >  		-name 'processed-schema*' ! \
> >  		-name '*.example.dt.yaml' \)
> > @@ -70,29 +67,10 @@ override DTC_FLAGS := \
> >  # Disable undocumented compatible checks until warning free
> >  override DT_CHECKER_FLAGS ?=
> >  
> > -$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
> > +$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
> >  	$(call if_changed_rule,chkdt)
> >  
> > -ifeq ($(DT_SCHEMA_FILES),)
> > -
> > -# Unless DT_SCHEMA_FILES is specified, use the full schema for dtbs_check too.
> > -# Just copy processed-schema-examples.json
> > -
> > -$(obj)/processed-schema.json: $(obj)/processed-schema-examples.json FORCE
> > -	$(call if_changed,copy)
> > -
> > -else
> > -
> > -# If DT_SCHEMA_FILES is specified, use it for processed-schema.json
> > -
> > -$(obj)/processed-schema.json: DT_MK_SCHEMA_FLAGS := -u
> > -$(obj)/processed-schema.json: $(CHK_DT_DOCS) check_dtschema_version FORCE
> > -	$(call if_changed,mk_schema)
> > -
> > -endif
> > -
> > -always-$(CHECK_DT_BINDING) += processed-schema-examples.json
> > -always-$(CHECK_DTBS)       += processed-schema.json
> > +always-y += processed-schema.json
> >  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
> >  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
> >  
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 79be57fdd32a..9f1e8442564e 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -361,9 +361,8 @@ $(multi-dtb-y): FORCE
> >  $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
> >  
> >  DT_CHECKER ?= dt-validate
> > -DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),,-m)
> > +DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > -# DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
> >  DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> 
> This could now use := instead of ?=

Yes, though I think it is possible we may still want to override it. 
Other than debugging perhaps, I don't have an immediate reason.

> Apart from the fact that 2022.3 hasn't been tagged yet as pointed out by
> Geert, this looks fine to me (but I'm no expert in this area).

It's now there.

Rob
