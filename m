Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3830B58B926
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiHGD7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 23:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHGD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:59:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208BDEDC
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:59:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so10061717pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 20:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URl/Ah66j2z7q62e1MD8yrkcBVsaeHd/9cg9F1m4Esw=;
        b=K6po2FHKZpvjZSqwxARU0xO0mu4oOrWCaFlDpqCNeMAmhfYJ87lKHdK/CEBTZ2pJYf
         39dXDjS6SLBdnrEqCSWnCiqU6Ru7GZy6bZ4lRVenq8C+cgz2YCGfXNXleEMa86eDKY2N
         +3ODw6+orppCU0P7ItfrwraW4CrhL2IN+KxiYSva8f7RbJ6qE1j0cyqRgEne7n4feSxE
         Q40Zoio12gX1dRgfEGlO1YqmwJOBwsDSv2wKI7uCykbBnTrCFFjNZNXN4Sl4T7VyfjZ/
         u8SbBzC3i2tGbZeDR8uHPDurQIXWSjbuDFPxB93y/GAv1rWEDhM4oPWVWV5Vmfw9+SL6
         YDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URl/Ah66j2z7q62e1MD8yrkcBVsaeHd/9cg9F1m4Esw=;
        b=5g5cRVBhFefmHMqBou5aQgEq7Gi9z7Uv1WSDGbTn4voODlOsIZrj8+lKZY+rjOqkJc
         JyTAyjd8dZiiUQTEpRQ8TAfBJHtncQ78jLM2+Xv/UZOQj51sbgZRzc6vJf8yxG6emxAU
         l1wlMS8Yejh65ZfGdXDy0x1CWzjzOtdN+WQnNk0eM86zWMjr260iIR8Qdwi9yAFsnr3d
         h/pvyHWNHEhqUB7o/dl8b8jjdiXF8sghj6aMtTudK2JvFJFuw2ZQ2DhaZRRECscTErEN
         tZIDFdzOLkaqFztJlMix8KCW2qZO81TZVrzbxaGCzovyKwhlpWRa4bCUPpIW3beC/Qti
         p7WA==
X-Gm-Message-State: ACgBeo3bxl4vf2xUtXwEhK3SDGTHTbnesoTQpPCc6aEU0TB6jyknGBrg
        LkcCanXHaGlhuTjA9qT8rm8Odw==
X-Google-Smtp-Source: AA6agR6fU+QxpiChH45tukqVqGbQrbs3TodrcGgoiUiy0zxRMWhlX2lXKp7+UNEgGT3+dE/i9Vmuaw==
X-Received: by 2002:a17:902:7ec2:b0:16f:9432:b120 with SMTP id p2-20020a1709027ec200b0016f9432b120mr8661940plb.5.1659844773557;
        Sat, 06 Aug 2022 20:59:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7960a000000b0051be585ab1dsm5734094pfg.200.2022.08.06.20.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 20:59:33 -0700 (PDT)
Date:   Sun, 7 Aug 2022 11:59:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 03/14] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <20220807035928.GA34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-4-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-4-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:45PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> This adds the initial build infrastructure (makefiles maintainers
> information) for adding follow-on tests for CoreSight.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  MAINTAINERS                                   |  1 +
>  tools/perf/Makefile.perf                      | 18 ++++++++++---
>  tools/perf/tests/shell/coresight/Makefile     | 26 +++++++++++++++++++
>  .../tests/shell/coresight/Makefile.miniconfig | 24 +++++++++++++++++
>  4 files changed, 66 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 171563d8dc14..87e4ac463429 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1989,6 +1989,7 @@ F:	drivers/hwtracing/coresight/*
>  F:	include/dt-bindings/arm/coresight-cti-dt.h
>  F:	include/linux/coresight*
>  F:	samples/coresight/*
> +F:	tools/perf/tests/shell/coresight/*
>  F:	tools/perf/arch/arm/util/auxtrace.c
>  F:	tools/perf/arch/arm/util/cs-etm.c
>  F:	tools/perf/arch/arm/util/cs-etm.h
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 8f738e11356d..edb621ace2e2 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -629,7 +629,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>  $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>  	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>  
> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> +TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
> +
> +tests-coresight-targets: FORCE
> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
> +
> +tests-coresight-targets-clean:
> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
> +
> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
>  
>  # Create python binding output directory if not already present
>  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> @@ -1015,7 +1023,10 @@ install-tests: all install-gtk
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
> +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
> +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
>  
>  install-bin: install-tools install-tests install-traceevent-plugins
>  
> @@ -1085,7 +1096,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>  	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> @@ -1143,5 +1154,6 @@ FORCE:
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
>  .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
>  .PHONY: libtraceevent_plugins archheaders
> +.PHONY: $(TESTS_CORESIGHT_TARGETS)

TESTS_CORESIGHT_TARGETS is not used anywhere else, should remove it?

>  endif # force_fixdep
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> new file mode 100644
> index 000000000000..3b816bb4ced3
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../../../../../tools/scripts/Makefile.include
> +include ../../../../../tools/scripts/Makefile.arch
> +include ../../../../../tools/scripts/utilities.mak
> +
> +SUBDIRS =
> +
> +all: $(SUBDIRS)
> +$(SUBDIRS):
> +	$(Q)$(MAKE) -C $@
> +
> +INSTALLDIRS = $(SUBDIRS:%=install-%)
> +
> +install-tests: $(INSTALLDIRS)
> +$(INSTALLDIRS):
> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests

I can see here you add a prefix "install-" for every sub directory
string, and then removed this prefix when invoke "make -C" command.

I know you have reason for doing this way, could you explain why not
directly use $(SUBDIRS) for INSTALLDIRS?

> +
> +CLEANDIRS = $(SUBDIRS:%=clean-%)
> +
> +clean: $(CLEANDIRS)
> +$(CLEANDIRS):
> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null

Same question of using prefix "clean-" for variable CLEANDIRS.

> +
> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
> +
> diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
> new file mode 100644
> index 000000000000..a65482d769ab
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +ifndef DESTDIR
> +prefix ?= $(HOME)
> +endif
> +
> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
> +perfexecdir = libexec/perf-core
> +perfexec_instdir = $(perfexecdir)
> +
> +ifneq ($(filter /%,$(firstword $(perfexecdir))),)
> +perfexec_instdir = $(perfexecdir)
> +else
> +perfexec_instdir = $(prefix)/$(perfexecdir)
> +endif
> +
> +perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))

I know these variables are copied from Makefile.config, just wandering
if we can directly export these variables from high level makefile, so
the sub-make can inherit the variables.

E.g. we can add below line in Makefile.config:

  export perfexec_instdir_SQ

Please let me know if you observe any issue for this.

Thanks,
Leo

> +INSTALL = install
> +INSTDIR_SUB = tests/shell/coresight
> +
> +include ../../../../../scripts/Makefile.include
> +include ../../../../../scripts/Makefile.arch
> +include ../../../../../scripts/utilities.mak
> -- 
> 2.32.0
> 
