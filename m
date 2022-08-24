Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD959FDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiHXPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiHXPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:13:14 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5855992F67;
        Wed, 24 Aug 2022 08:13:11 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27OFCjVB013992;
        Thu, 25 Aug 2022 00:12:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27OFCjVB013992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661353966;
        bh=fVvaRhYbr7WqSGRQrnnYvU3l+AHOJziVA/x4NFlZgNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SWPfw5FByzSsAK8YH9O2qotcC/hLiEILV5uVffOA/uM4+LKlS7oFBPvuXo+DdSWxZ
         ej/+7awez8uneRqxStI64AtKE3IK+I9nLDXF9+Y+kOzEiUg39Tq2VUbCZqTUKkxNx2
         o6lRPsgFn6mFxm86EozCnPx+HnUgT6CIMj7AHDdNEZ1Wn1/gdY4LqxWSdySwcDFJxa
         dyaeveEm6PYaK2iPEqw6jYWJW9fyklqOOYPXTwn61G9PZBL75G3tGNzHxz53uIOASe
         kH60xluch7C2RzjPxplIc/q6OtBscByXqSkEpHKrodqF7d8lp/5rm0KnjrC6KWocrL
         yR+mYxrVly2vg==
X-Nifty-SrcIP: [209.85.210.52]
Received: by mail-ot1-f52.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so11992125otr.4;
        Wed, 24 Aug 2022 08:12:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo1z6lm52VFuxmSjaGnyH3/keUS6E+68CJL6ElpBqdgEOg0VGj+u
        lPqpSivUN76P59NpJiixKR77h8seQxjwYrI28ck=
X-Google-Smtp-Source: AA6agR6SVxhGHjPqzDSRHvstOHoynSvOcXtoHpO+BvUGcwbnHt28FtUhLXip+Cg3SfnsPxu9gTrs2FtahV+hGrPQY3I=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr11459091otf.225.1661353965051; Wed, 24
 Aug 2022 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220817152027.16928-1-masahiroy@kernel.org> <20220824002355.GA391120-robh@kernel.org>
In-Reply-To: <20220824002355.GA391120-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Aug 2022 00:12:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSc9Txf7dLL=Fb-uG3n9vWbHDezFMAmnMuajAm7wjHwQ@mail.gmail.com>
Message-ID: <CAK7LNASSc9Txf7dLL=Fb-uG3n9vWbHDezFMAmnMuajAm7wjHwQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fix wrong use of if_changed_rule
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 9:23 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Aug 18, 2022 at 12:20:26AM +0900, Masahiro Yamada wrote:
> > The intent for if_changed_rule is to re-run the rule when the command
> > line is changed, but this if_changed_rule does not do anything for it.
>
> This is the issue with DT_SCHEMA_FILES changes not causing a rebuild?
>
> > $(cmd-check) for this rule is always empty because:
> >
> >  [1] $(cmd_$@) is empty because .processed-schema.json.cmd does not exist
> >  [2] $(cmd_$1) is empty because cmd_chkdt is not defined
> >
> > To address [1], use cmd_and_cmdsave instead of cmd.
> >
> > To address [2], rename rule_chkdt to rule_mk_schema so that the stem
> > parts of cmd_* and rule_* match, like commit 7a0496056064 ("kbuild:
> > fix DT binding schema rule to detect command line changes").
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Another possibility might be to split out yamllint and chk_bindings
> > as standalone build rules instead of running them as a side-effect
> > of the schema build. (but it it up to Rob's preference)
>
> That is the direction I'd like to go. Something like the below patch
> perhaps.
>
> The main issue (or feature?) is that 'dt_binding_lint' and
> 'dt_binding_schema' targets are still rerun every time even with the
> dummy target files.


Not a feature.
It is just because the code is wrong.


You need to add

targets += dt_binding_lint.checked

  or

always-$(CHECK_DT_BINDING) += dt_binding_lint.checked



>
> I think the top level makefile can be simplified a bit more with this
> change, but this is what I got to being somewhat functional.


I do not understand why the top Makefile needs a change.

It is just a matter of adding the timestamp files to always-y
in Documentation/devicetree/bindings/Makefile, isn'ts it?






> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1eaccf135b30..ec3d8a926331 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -34,11 +34,13 @@ CHK_DT_DOCS := $(shell $(find_cmd))
>  quiet_cmd_yamllint = LINT    $(src)
>        cmd_yamllint = ($(find_cmd) | \
>                       xargs -n200 -P$$(nproc) \
> -                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
> +                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true; \
> +                     touch $(obj)/dt_binding_lint.checked
>
> -quiet_cmd_chk_bindings = CHKDT   $@
> +quiet_cmd_chk_bindings = CHKDT   $(src)
>        cmd_chk_bindings = ($(find_cmd) | \
> -                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
> +                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true; \
> +                         touch $(obj)/dt_binding_schema.checked
>
>  quiet_cmd_mk_schema = SCHEMA  $@
>        cmd_mk_schema = f=$$(mktemp) ; \
> @@ -46,12 +48,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
>                        $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
>                       rm -f $$f
>
> -define rule_chkdt
> -       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
> -       $(call cmd,chk_bindings)
> -       $(call cmd,mk_schema)
> -endef
> -
>  DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
>
>  override DTC_FLAGS := \
> @@ -64,8 +60,25 @@ override DTC_FLAGS := \
>  # Disable undocumented compatible checks until warning free
>  override DT_CHECKER_FLAGS ?=
>
> -$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
> -       $(call if_changed_rule,chkdt)
> +dt_binding_lint: $(obj)/dt_binding_lint.checked
> +
> +$(obj)/dt_binding_lint.checked: $(CHK_DT_DOCS) $(src)/.yamllint FORCE
> +       $(call if_changed,yamllint)
> +
> +dt_binding_schema: $(obj)/dt_binding_schema.checked
> +
> +$(obj)/dt_binding_schema.checked: $(CHK_DT_DOCS) check_dtschema_version FORCE
> +       $(call if_changed,chk_bindings)
> +
> +dt_binding_examples: CHECK_DT_BINDING = y
> +
> +dt_binding_examples: $(obj)/processed-schema.json $(patsubst $(srctree)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
> +
> +dt_binding_check: dt_binding_lint dt_binding_examples dt_binding_schema
> +
> +
> +$(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
> +       $(call if_changed,mk_schema)
>
>  always-y += processed-schema.json
>  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
> diff --git a/Makefile b/Makefile
> index c7705f749601..0f197e3bd1f9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1391,7 +1391,7 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
>
>  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=y
> -dtbs: dt_binding_check
> +dtbs: dt_binding_schema
>  endif
>
>  dtbs_check: dtbs
> @@ -1409,13 +1409,14 @@ PHONY += scripts_dtc
>  scripts_dtc: scripts_basic
>         $(Q)$(MAKE) $(build)=scripts/dtc
>
> -ifneq ($(filter dt_binding_check, $(MAKECMDGOALS)),)
> +ifneq ($(filter dt_binding_examples, $(MAKECMDGOALS)),)
>  export CHECK_DT_BINDING=y
>  endif
>
> -PHONY += dt_binding_check
> -dt_binding_check: scripts_dtc
> -       $(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
> +DT_BINDING_TARGETS := dt_binding_check dt_binding_lint dt_binding_schema dt_binding_examples
> +PHONY += $(DT_BINDING_TARGETS)
> +$(DT_BINDING_TARGETS): scripts_dtc
> +       $(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
>
>  # ---------------------------------------------------------------------------
>  # Modules



-- 
Best Regards
Masahiro Yamada
