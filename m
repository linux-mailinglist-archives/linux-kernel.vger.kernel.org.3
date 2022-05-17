Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3652AD82
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiEQV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiEQV1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:27:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975351E52
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:27:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y41so256556pfw.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxkdUUYI6eaVEkqxADYbD3E5MxMMbiXbFP5sUgx29uM=;
        b=D7oAZFvD6ffX74ylNY03jtKawKLAlfEUFguPNPsfkOpQGmh2D6u8V7Y+AisNwb+yOg
         UmGozHKAkfUFsTDtN0NLF2bqcwoae/bJA/omfTA6P6HywUcWgDf1IhRGql6nBV8uloDr
         nhxl/QcgbqLiUdXsj1wFPHt1FkRkr3D8hYoHwZUgNLS4G4jPiojEn70M9KxWVmGvxGKX
         Zeo8f1PKIRysuEuBytwvjOoe3CWQgFGPJTBfawSIQO/+7enQ/uGph9OtcuMi7OqdualF
         VU0lwANbj+bsQcREDHFwN+QbVKsEcwM9vOOIFhplRQ5Y8bxPovukbEw3APHbc+y8lp2g
         oKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxkdUUYI6eaVEkqxADYbD3E5MxMMbiXbFP5sUgx29uM=;
        b=A+sNU9nk0xnG02WVwQXjKnMptmCSuOoF2dh8e/wIlDxXYBuajHm0r2180n9PuPZuiQ
         g997UDwzgt6zLmdibAbJnGoPIusgGYbFNMWfGo4pV7iQvNXyqJeMqIy0M8QzIk5+2cFm
         Yf3jgcrmFJV3tHFh9V8taXxVg94jNOCp4QfGi4weWlsLt3tlvsewd8vVY7rCEQN81tcx
         CRBEMd48J/Oyg88rqMAtpoKzOEdZJZc/3e87Ng8V/vUym8FsKuEi6P6klfIIEZocOHTi
         /Z9cr8CWwHYG+tdpliBF5nbDb5FkgUb9byB2mjnuENdcDKwdjBbdwcD/9L/d0bS1BY43
         OKfg==
X-Gm-Message-State: AOAM53133D6dPnWdFI8QCMv9+8g69xxuTYdliIKgyIcUBR1ucQM8rD9z
        mfZ4PZ2IJhMYXv64nC3zCMvywBy5pvA=
X-Google-Smtp-Source: ABdhPJx+giCjrS4ZdXVLEk4ZwRFXOuQAZ3aZ+4+DewbzRqJRbs2JS+0yXV1YpfvHmYgpHfHLFVONPA==
X-Received: by 2002:a63:2bc4:0:b0:3ab:1d76:64db with SMTP id r187-20020a632bc4000000b003ab1d7664dbmr20543640pgr.508.1652822830752;
        Tue, 17 May 2022 14:27:10 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id a191-20020a621ac8000000b0050dc76281e4sm173853pfa.190.2022.05.17.14.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:27:09 -0700 (PDT)
Date:   Wed, 18 May 2022 06:27:07 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v2 01/13] openrisc: Add gcc machine instruction flag
 configuration
Message-ID: <YoQTK4MiGzZ1DF0v@antec>
References: <20220517005510.3500105-1-shorne@gmail.com>
 <20220517005510.3500105-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517005510.3500105-2-shorne@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:54:58AM +0900, Stafford Horne wrote:
> OpenRISC GCC supports flags to enable the backend to output instructions
> if they are supported by a target processor.  This patch adds
> configuration flags to enable configuring these flags to tune the kernel
> for a particular CPU configuration.
> 
> In the future we could also enable all of these flags by default and
> provide instruction emulation in the kernel to make these choices easier
> for users but this is what we provide for now.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/Kconfig  | 53 ++++++++++++++++++++++++++++++++++++++++++
>  arch/openrisc/Makefile | 17 ++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 0d68adf6e02b..ea7eac20911a 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -114,6 +114,59 @@ config OPENRISC_HAVE_INST_DIV
>  	default y
>  	help
>  	  Select this if your implementation has a hardware divide instruction
> +
> +config OPENRISC_HAVE_INST_CMOV
> +	bool "Have instruction l.cmov for conditional move"
> +	default y
> +	help
> +	  This config enables gcc to generate l.cmov instructions when compiling
> +	  the kernel which in general will improve performance and reduce the
> +	  binary size.
> +
> +	  Select this if your implementation has support for the Class II
> +	  l.cmov conistional move instruction.
> +
> +	  Say N if you are unsure.
> +
> +config OPENRISC_HAVE_INST_ROR
> +	bool "Have instruction l.ror for rotate right"
> +	default y
> +	help
> +	  This config enables gcc to generate l.ror instructions when compiling
> +	  the kernel which in general will improve performance and reduce the
> +	  binary size.
> +
> +	  Select this if your implementation has support for the Class II
> +	  l.ror rotate right instruction.
> +
> +	  Say N if you are unsure.
> +
> +config OPENRISC_HAVE_INST_RORI
> +	bool "Have instruction l.rori for rotate right with immediate"
> +	default y
> +	help
> +	  This config enables gcc to generate l.rori instructions when compiling
> +	  the kernel which in general will improve performance and reduce the
> +	  binary size.
> +
> +	  Select this if your implementation has support for the Class II
> +	  l.rori rotate right with immediate instruction.
> +
> +	  Say N if you are unsure.
> +
> +config OPENRISC_HAVE_INST_SEXT
> +	bool "Have instructions l.ext* for sign extension"
> +	default y
> +	help
> +	  This config enables gcc to generate l.ext* instructions when compiling
> +	  the kernel which in general will improve performance and reduce the
> +	  binary size.
> +
> +	  Select this if your implementation has support for the Class II
> +	  l.exths, l.extbs, l.exthz and l.extbz size extend instructions.
> +
> +	  Say N if you are unsure.

Looking at this again and when generating the defconfig, the default for these
should be no,

-Stafford

> +
>  endmenu
>  
>  config NR_CPUS
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index 760b734fb822..b446510173cd 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -21,6 +21,7 @@ OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
>  LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>  
>  KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
> +KBUILD_CFLAGS	+= -msfimm -mshftimm
>  
>  all: vmlinux.bin
>  
> @@ -38,6 +39,22 @@ else
>  	KBUILD_CFLAGS += $(call cc-option,-msoft-div)
>  endif
>  
> +ifeq ($(CONFIG_OPENRISC_HAVE_INST_CMOV),y)
> +	KBUILD_CFLAGS += $(call cc-option,-mcmov)
> +endif
> +
> +ifeq ($(CONFIG_OPENRISC_HAVE_INST_ROR),y)
> +	KBUILD_CFLAGS += $(call cc-option,-mror)
> +endif
> +
> +ifeq ($(CONFIG_OPENRISC_HAVE_INST_RORI),y)
> +	KBUILD_CFLAGS += $(call cc-option,-mrori)
> +endif
> +
> +ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
> +	KBUILD_CFLAGS += $(call cc-option,-msext)
> +endif
> +
>  head-y 		:= arch/openrisc/kernel/head.o
>  
>  libs-y		+= $(LIBGCC)
> -- 
> 2.31.1
> 
