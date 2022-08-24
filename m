Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8248C59F02E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiHXAX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiHXAX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:23:57 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD950075;
        Tue, 23 Aug 2022 17:23:56 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r124so2359753oig.11;
        Tue, 23 Aug 2022 17:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=z3gbS+dvNMlzyhJK3RThDNWfcjbn/dU0DQZBMqseXn0=;
        b=kYfxqaqaOUoPAN51plqIWtQjSFJ+NkddUfQUREc+EcgU3Syffzs5Mnvppds5G8Qesm
         OSK2irWsWpkYPxParH3hf0pw6KjmNrjPviGI5nYPnW0q6bylQ6FxiPyFLqD5soY/N2Rn
         mzzEKgbaJIC/mB1Hbw+7LC3umwDstea+ooHwjfjzCRKFSwpYhtJatCfw7LjFoMPybaRR
         t6iNWniUXXCcQPLPdh1hnCOhjlKqDEToQ6OmeYWttrLiD0V8hQdwVoxYv4ZraBxX+TzH
         UfCtfXJVmT3sU/DNKLes2uT/URGa3g8l3NGe0dpS5KvOhxZBoQYypTkY1YfPjS5+4HVK
         IzEg==
X-Gm-Message-State: ACgBeo2dh1gNV3fXt1rYBvqQVbx+UVjzDwYR0JWiRMelUa/XML++iPa7
        ozKYGbLzuTeg1MMn50I7mJDNGQqmCQ==
X-Google-Smtp-Source: AA6agR6mxgCTl0NfIJJjwFJDTc6t76xpU9NN2dg7Q7Pt77XqKHCJGPxaRenqC5Re0V2UnAbPZaSujg==
X-Received: by 2002:a05:6808:23cd:b0:345:efa:2a40 with SMTP id bq13-20020a05680823cd00b003450efa2a40mr2229844oib.294.1661300636163;
        Tue, 23 Aug 2022 17:23:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k37-20020a05687095a500b00101bc3380a5sm669853oao.12.2022.08.23.17.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:23:55 -0700 (PDT)
Received: (nullmailer pid 521915 invoked by uid 1000);
        Wed, 24 Aug 2022 00:23:55 -0000
Date:   Tue, 23 Aug 2022 19:23:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fix wrong use of if_changed_rule
Message-ID: <20220824002355.GA391120-robh@kernel.org>
References: <20220817152027.16928-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817152027.16928-1-masahiroy@kernel.org>
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

On Thu, Aug 18, 2022 at 12:20:26AM +0900, Masahiro Yamada wrote:
> The intent for if_changed_rule is to re-run the rule when the command
> line is changed, but this if_changed_rule does not do anything for it.

This is the issue with DT_SCHEMA_FILES changes not causing a rebuild?

> $(cmd-check) for this rule is always empty because:
> 
>  [1] $(cmd_$@) is empty because .processed-schema.json.cmd does not exist
>  [2] $(cmd_$1) is empty because cmd_chkdt is not defined
> 
> To address [1], use cmd_and_cmdsave instead of cmd.
> 
> To address [2], rename rule_chkdt to rule_mk_schema so that the stem
> parts of cmd_* and rule_* match, like commit 7a0496056064 ("kbuild:
> fix DT binding schema rule to detect command line changes").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Another possibility might be to split out yamllint and chk_bindings
> as standalone build rules instead of running them as a side-effect
> of the schema build. (but it it up to Rob's preference)

That is the direction I'd like to go. Something like the below patch 
perhaps.

The main issue (or feature?) is that 'dt_binding_lint' and 
'dt_binding_schema' targets are still rerun every time even with the 
dummy target files.

I think the top level makefile can be simplified a bit more with this 
change, but this is what I got to being somewhat functional.

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1eaccf135b30..ec3d8a926331 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -34,11 +34,13 @@ CHK_DT_DOCS := $(shell $(find_cmd))
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) \
-		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+		     $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true; \
+                     touch $(obj)/dt_binding_lint.checked
 
-quiet_cmd_chk_bindings = CHKDT   $@
+quiet_cmd_chk_bindings = CHKDT   $(src)
       cmd_chk_bindings = ($(find_cmd) | \
-                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
+                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true; \
+                         touch $(obj)/dt_binding_schema.checked
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
@@ -46,12 +48,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
-define rule_chkdt
-	$(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-	$(call cmd,chk_bindings)
-	$(call cmd,mk_schema)
-endef
-
 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 
 override DTC_FLAGS := \
@@ -64,8 +60,25 @@ override DTC_FLAGS := \
 # Disable undocumented compatible checks until warning free
 override DT_CHECKER_FLAGS ?=
 
-$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
-	$(call if_changed_rule,chkdt)
+dt_binding_lint: $(obj)/dt_binding_lint.checked
+
+$(obj)/dt_binding_lint.checked: $(CHK_DT_DOCS) $(src)/.yamllint FORCE
+	$(call if_changed,yamllint)
+
+dt_binding_schema: $(obj)/dt_binding_schema.checked
+
+$(obj)/dt_binding_schema.checked: $(CHK_DT_DOCS) check_dtschema_version FORCE
+	$(call if_changed,chk_bindings)
+
+dt_binding_examples: CHECK_DT_BINDING = y
+
+dt_binding_examples: $(obj)/processed-schema.json $(patsubst $(srctree)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
+
+dt_binding_check: dt_binding_lint dt_binding_examples dt_binding_schema
+
+
+$(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
+	$(call if_changed,mk_schema)
 
 always-y += processed-schema.json
 always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
diff --git a/Makefile b/Makefile
index c7705f749601..0f197e3bd1f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1391,7 +1391,7 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
 
 ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
-dtbs: dt_binding_check
+dtbs: dt_binding_schema
 endif
 
 dtbs_check: dtbs
@@ -1409,13 +1409,14 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
-ifneq ($(filter dt_binding_check, $(MAKECMDGOALS)),)
+ifneq ($(filter dt_binding_examples, $(MAKECMDGOALS)),)
 export CHECK_DT_BINDING=y
 endif
 
-PHONY += dt_binding_check
-dt_binding_check: scripts_dtc
-	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
+DT_BINDING_TARGETS := dt_binding_check dt_binding_lint dt_binding_schema dt_binding_examples
+PHONY += $(DT_BINDING_TARGETS)
+$(DT_BINDING_TARGETS): scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
 
 # ---------------------------------------------------------------------------
 # Modules
