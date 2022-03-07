Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7254D04CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiCGRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiCGRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:01:25 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74376C1C3;
        Mon,  7 Mar 2022 09:00:30 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so5847354ooh.8;
        Mon, 07 Mar 2022 09:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gIqvsVuKj0bmzWmxEJWkf2QmkNfqBuOw31l6fZNNHA=;
        b=2UC68IK2XXEkinqs4BQn1bpHN+SbFNqXn3p1mU7Ya2LSCARXF7hePUBEU+8ChxsRZV
         u8zSDgogHBtdJR8RixWfiB0+N/O0cOL4pLNOqrFTia7fjlU+09xxAC7L3lIJa8BLwhX9
         il/8fuwEYZY9PbLdsPeBChZq2mb2P15nNDHB2xyYhsk5SQaHvE8wNCwjGT3mIEnEpde1
         jY76RJQDqQqqiVp8dIMyMp1Xr4z9LPZytOAkfob2D3pN/86WVpKQSjnpDAcHdnXAGdMK
         n3jj7QJFC7g8fT7o9YIdseUxnqKwkYoR5MbUo52Oam91C4xp+6riqxCqp2mZqZSvkbDT
         YQTg==
X-Gm-Message-State: AOAM532sw6WLfRDcxksHIhFPQwkGo3bIsYYKs3LkmaXb+49u3kzXU2Qc
        poxxlWy+VCfe/vRYDKBe1w==
X-Google-Smtp-Source: ABdhPJz/GOWVesh7UGjjHVCC0K2DVCJ0vgsEuh3sHrQM74Ly2KtoME4lmaL/B88SNsxEMnD1zzZQvw==
X-Received: by 2002:a05:6870:e352:b0:d6:e15f:2d40 with SMTP id a18-20020a056870e35200b000d6e15f2d40mr15181748oae.137.1646672429885;
        Mon, 07 Mar 2022 09:00:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0f42000000b005ad59a0fe01sm6531777ott.35.2022.03.07.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:00:29 -0800 (PST)
Received: (nullmailer pid 2757845 invoked by uid 1000);
        Mon, 07 Mar 2022 17:00:28 -0000
Date:   Mon, 7 Mar 2022 11:00:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
Message-ID: <YiY6LNfEGhz1hSYg@robh.at.kernel.org>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-3-robh@kernel.org>
 <CAMuHMdUzu2PMN7ZerX=D0KsiqKZFDW5dVe3BY77wR=H-grrPVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUzu2PMN7ZerX=D0KsiqKZFDW5dVe3BY77wR=H-grrPVA@mail.gmail.com>
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

On Mon, Mar 07, 2022 at 01:20:29PM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > Switch the DT validation to use DTB files directly instead of a DTS to
> > YAML conversion.
> >
> > The original motivation for supporting validation on DTB files was to
> > enable running validation on a running system (e.g. 'dt-validate
> > /sys/firmware/fdt') or other cases where the original source DTS is not
> > available.
> >
> > The YAML format was not without issues. Using DTBs with the schema type
> > information solves some of those problems. The YAML format relies on the
> > DTS source level information including bracketing of properties, size
> > directives, and phandle tags all of which are lost in a DTB file. While
> > standardizing the bracketing is a good thing, it does cause a lot of
> > extra warnings and churn to fix them.
> >
> > Another issue has been signed types are not validated correctly as sign
> > information is not propagated to YAML. Using the schema type information
> > allows for proper handling of signed types. YAML also can't represent
> > the full range of 64-bit integers as numbers are stored as floats by
> > most/all parsers.
> >
> > The DTB validation works by decoding property values using the type
> > information in the schemas themselves. The main corner case this does
> > not work for is matrix types where neither dimension is fixed. For
> > now, checking the dimensions in these cases are skipped.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Thanks for your patch!
> 
> While investigating why a newly added device node to DTS was not
> instantiated as a platform device, I discovered an issue with this
> patch: "make dtbs" no longer rebuilds DTB files that need a rebuild.
> 
> How to reproduce:
> 
>     $ git checkout next-20220307
>     # apply this series and its dependency:
>     # dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES
>     # dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
>     # dt-bindings: kbuild: Use DTB files for validation
>     $ make ARCH=arm shmobile_defconfig
>     $ make ARCH=arm dtbs
>     $ touch arch/arm/boot/dts/r8a7791.dtsi
>     $ make ARCH=arm dtbs
>     # The above command does NOT cause:
>     # DTC     arch/arm/boot/dts/r8a7791-koelsch.dtb
>     # DTC     arch/arm/boot/dts/r8a7791-porter.dtb
> 
> I don't see anything wrong with this patch at first sight, though.

Was this a clean tree?

I think I reproduced it, but then couldn't... But then after a 'make 
clean', 'make dtbs' would error out. I think the issue in both cases was 
processed-schema.json always a dependency when it should be conditional 
on 'dtbs_check'. The patch below fixes that. Can you give it a try too.


diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 4629af60160b..9d5320a47ef8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -349,12 +349,12 @@ $(multi-dtb-y): FORCE
        $(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
+ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
-DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
+DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
-ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
 quiet_cmd_dtb_check =  CHECK   $@
       cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
 endif
