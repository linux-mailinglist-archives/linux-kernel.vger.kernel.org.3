Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B84CFE15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiCGMVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiCGMVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:21:39 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA780205;
        Mon,  7 Mar 2022 04:20:44 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id c4so13042935qtx.1;
        Mon, 07 Mar 2022 04:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA+CXUO6P4fAUy+V5ltfmnHQ4MtoGN85RPLenercpMw=;
        b=oDbWQ1XQqlO1J1QKoMLjxXEAncOtyiwWX4EU2cErqVp7D7yM8UT9KISSchEUPAFxsC
         T2JMVIPT3EQGwQtEL0e2nxtEuFrLWLJLnciAvgDkdwuShZfFb/LkIl8XgwCn5tcQ+cSn
         dkdxxqfMjdbiQ5+oHgz+8PCcW/OSthGPAueewJXgElaBmhtMw03fjeXRNkxE2yqc/fFZ
         5JEma/ai26OQXi2eU4s+NtW5sVQYoE7Uoh0r/VYqaCxof9klLSPOACqpsuPh3Upo2Qa2
         3g8yxhGNmSIOcC3A88NXmtqWYHcwjje2zmNdXjHgg8w6FH0B41WymjSkspNoXaY5bpfk
         +I6A==
X-Gm-Message-State: AOAM5302l2BhlGPED8FOc/MJVQxP273C0VYfC3fhCI0mMwJ9M9+kM97P
        45HVo5WoIAdcQEXbt82H0TKCqgfNGfopwg==
X-Google-Smtp-Source: ABdhPJx1O6UYc5QncG4QsMPP27Y8qio7zSSGv3EeNZ22kO0TKmM7y13+mmu/A19Hl+KVk5i2UinVEw==
X-Received: by 2002:ac8:7d0d:0:b0:2e0:4e16:d4ad with SMTP id g13-20020ac87d0d000000b002e04e16d4admr9107101qtb.551.1646655643422;
        Mon, 07 Mar 2022 04:20:43 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b00648af7287desm5861118qkb.26.2022.03.07.04.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 04:20:42 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id h126so30546425ybc.1;
        Mon, 07 Mar 2022 04:20:42 -0800 (PST)
X-Received: by 2002:a25:8486:0:b0:619:9fba:895e with SMTP id
 v6-20020a258486000000b006199fba895emr7575129ybk.342.1646655641820; Mon, 07
 Mar 2022 04:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20220303224237.2497570-1-robh@kernel.org> <20220303224237.2497570-3-robh@kernel.org>
In-Reply-To: <20220303224237.2497570-3-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 13:20:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzu2PMN7ZerX=D0KsiqKZFDW5dVe3BY77wR=H-grrPVA@mail.gmail.com>
Message-ID: <CAMuHMdUzu2PMN7ZerX=D0KsiqKZFDW5dVe3BY77wR=H-grrPVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
To:     Rob Herring <robh@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> Switch the DT validation to use DTB files directly instead of a DTS to
> YAML conversion.
>
> The original motivation for supporting validation on DTB files was to
> enable running validation on a running system (e.g. 'dt-validate
> /sys/firmware/fdt') or other cases where the original source DTS is not
> available.
>
> The YAML format was not without issues. Using DTBs with the schema type
> information solves some of those problems. The YAML format relies on the
> DTS source level information including bracketing of properties, size
> directives, and phandle tags all of which are lost in a DTB file. While
> standardizing the bracketing is a good thing, it does cause a lot of
> extra warnings and churn to fix them.
>
> Another issue has been signed types are not validated correctly as sign
> information is not propagated to YAML. Using the schema type information
> allows for proper handling of signed types. YAML also can't represent
> the full range of 64-bit integers as numbers are stored as floats by
> most/all parsers.
>
> The DTB validation works by decoding property values using the type
> information in the schemas themselves. The main corner case this does
> not work for is matrix types where neither dimension is fixed. For
> now, checking the dimensions in these cases are skipped.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

While investigating why a newly added device node to DTS was not
instantiated as a platform device, I discovered an issue with this
patch: "make dtbs" no longer rebuilds DTB files that need a rebuild.

How to reproduce:

    $ git checkout next-20220307
    # apply this series and its dependency:
    # dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES
    # dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
    # dt-bindings: kbuild: Use DTB files for validation
    $ make ARCH=arm shmobile_defconfig
    $ make ARCH=arm dtbs
    $ touch arch/arm/boot/dts/r8a7791.dtsi
    $ make ARCH=arm dtbs
    # The above command does NOT cause:
    # DTC     arch/arm/boot/dts/r8a7791-koelsch.dtb
    # DTC     arch/arm/boot/dts/r8a7791-porter.dtb

I don't see anything wrong with this patch at first sight, though.

> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -26,8 +26,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>         $(call if_changed,extract_ex)
>
>  find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> -               -name 'processed-schema*' ! \
> -               -name '*.example.dt.yaml' \)
> +               -name 'processed-schema*' \)
>
>  find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
>  CHK_DT_DOCS := $(shell $(find_cmd))
> @@ -72,9 +71,9 @@ $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version
>
>  always-y += processed-schema.json
>  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
> -always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
> +always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
>
>  # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
>  # build artifacts here before they are processed by scripts/Makefile.clean
>  clean-files = $(shell find $(obj) \( -name '*.example.dts' -o \
> -                       -name '*.example.dt.yaml' \) -delete 2>/dev/null)
> +                       -name '*.example.dtb' \) -delete 2>/dev/null)
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 3b00fe981494..b4258bf81be5 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -123,18 +123,6 @@ project can be installed with pip::
>  Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
>  installed. Ensure they are in your PATH (~/.local/bin by default).
>
> -dtc must also be built with YAML output support enabled. This requires that
> -libyaml and its headers be installed on the host system. For some distributions
> -that involves installing the development package, such as:
> -
> -Debian::
> -
> -  apt-get install libyaml-dev
> -
> -Fedora::
> -
> -  dnf -y install libyaml-devel
> -
>  Running checks
>  ~~~~~~~~~~~~~~
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 9f1e8442564e..4629af60160b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -87,11 +87,6 @@ base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m,
>
>  always-y                       += $(dtb-y)
>
> -ifneq ($(CHECK_DTBS),)
> -always-y += $(patsubst %.dtb,%.dt.yaml, $(real-dtb-y))
> -always-y += $(patsubst %.dtbo,%.dt.yaml, $(real-dtb-y))
> -endif
> -
>  # Add subdir path
>
>  extra-y                := $(addprefix $(obj)/,$(extra-y))
> @@ -347,12 +342,6 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
>                 -d $(depfile).dtc.tmp $(dtc-tmp) ; \
>         cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> -       $(call if_changed_dep,dtc)
> -
> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> -       $(call if_changed_dep,dtc)
> -
>  quiet_cmd_fdtoverlay = DTOVL   $@
>        cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
>
> @@ -365,17 +354,22 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>  DT_BINDING_DIR := Documentation/devicetree/bindings
>  DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
>
> +ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
>  quiet_cmd_dtb_check =  CHECK   $@
> -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
> +      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +endif
>
>  define rule_dtc
>         $(call cmd_and_fixdep,dtc)
>         $(call cmd,dtb_check)
>  endef
>
> -$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>         $(call if_changed_rule,dtc)
>
> +$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> +       $(call if_changed_dep,dtc)
> +
>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>
>  # Bzip2
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 1cba78e1dce6..4d32b9497da9 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -17,20 +17,7 @@ fdtoverlay-objs      := $(libfdt) fdtoverlay.o util.o
>
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
> -
> -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> -ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
> -$(error dtc needs libyaml for DT schema validation support. \
> -       Install the necessary libyaml development package.)
> -endif
>  HOST_EXTRACFLAGS += -DNO_YAML
> -else
> -dtc-objs       += yamltree.o
> -# To include <yaml.h> installed in a non-default path
> -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> -# To link libyaml installed in a non-default path
> -HOSTLDLIBS_dtc := $(shell pkg-config --libs yaml-0.1)
> -endif
>
>  # Generated files need one more search path to include headers in source tree
>  HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
> diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
> index 32ff17ffd089..94627541533e 100755
> --- a/scripts/dtc/update-dtc-source.sh
> +++ b/scripts/dtc/update-dtc-source.sh
> @@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
>  DTC_LINUX_PATH=`pwd`/scripts/dtc
>
>  DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
> -               srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
> +               srcpos.h treesource.c util.c util.h version_gen.h \
>                 dtc-lexer.l dtc-parser.y"
>  LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
>                 fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
> --
> 2.32.0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
