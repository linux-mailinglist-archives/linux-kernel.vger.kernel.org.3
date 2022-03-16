Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC344DB224
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiCPOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiCPOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:07:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3662A0B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:06:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so4425624ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/dv8PHqSbFQgaW62Qon3w9BSfFQWVC7Hfv/h9J+k9lM=;
        b=XS3aqcYlMnHxSYqWtLJgT9K4+ABiSX2Af9GgYwXo1AAu1pm62uF3DNIdAXVet44Kms
         uJleK02ShtN9Uf+Lq5T4buaRx0zhh/2+rV3PGxYgSuKzsdRmffbs484jeGEQqi/dqoI+
         C2TI/S1Voqbs/cWUGhBHT36IxhGU2hpsyFwIgVYbp47y1qV4jdv1ZT9IWZwBEpbzL7JA
         /cVdrbD41xRgzy3bPKtWSliWVVxD18Mb0GSiuK/l0zv/OPqNCfOXNfWgkjeI0vDeXBSb
         WUUERO+ZWM6HNXVmorN/smGu2e42Lft/pAsFHOocYby8ZKX57g3Hz8wF2WKQpA4r9W83
         7k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/dv8PHqSbFQgaW62Qon3w9BSfFQWVC7Hfv/h9J+k9lM=;
        b=tcveWmjHVKp4+bt9sW4gc0lQ3Ui6RvQ4sjPcJpF1sFQUTddV/LHL8ZO2i2MsBdi35f
         NYNZEir10rJgpGs8duZSEIN7pvrQLAawet24i1btIijXiNTcFZFyvigjLg9ysUS0MWO5
         U6TasWJrKLDqarhsp9xb0m8mgkCuLVNvqcdhG/aEBTKZJFmUIxTvN97/oggLMhbTY3I6
         QAC7PVvO+I7vlGWEdfsyITlmfBT2ge9O2PUgTqwgftAP/0kedqGVxo2ZxqjOAbWee6p5
         s8Cpl4B4z80fJAhJh7G1wBkNpz5SD4A1FfXd0581kq0dah9oRmSxve0bMcKlmBgnS2q7
         RwTg==
X-Gm-Message-State: AOAM530Fny7dOBhgpLDqCw7D7rez2LeOcx7JQmUdAEKwuHsbT5JN9Rue
        eBl6wY8NoGaFyJNzgJqNgD4EP7PKhyb9h9QV
X-Google-Smtp-Source: ABdhPJyGIPPot3pz+YLqKT3jIIaMeAyHMoYBJTuiQWgnBGO2quY843EA5f2VdGEpLfLy5B1w4ylpHw==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr155412ejn.278.1647439579238;
        Wed, 16 Mar 2022 07:06:19 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id gv9-20020a170906f10900b006d7128b2e6fsm952187ejb.162.2022.03.16.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:06:18 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:06:17 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220316140617.GA6190@pswork>
References: <20220307184011.GA2570@pswork>
 <20220308163600.3109f19854c7b051924f262b@kernel.org>
 <20220308174829.GA2471@pswork>
 <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
 <20220309190651.GA3735@pswork>
 <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami Hiramatsu,

On Sat, Mar 12, 2022 at 03:53:58PM +0900, Masami Hiramatsu wrote:
> Hello Padmanabha,
> 
> On Wed, 9 Mar 2022 20:06:51 +0100
> Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> 
> > On Wed, Mar 09, 2022 at 05:01:24PM +0900, Masami Hiramatsu wrote:
> > > On Tue, 8 Mar 2022 18:48:29 +0100
> > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > 
> > > > Hello Masami Hiramatsu,
> > > > 
> > > > On Tue, Mar 08, 2022 at 04:36:00PM +0900, Masami Hiramatsu wrote:
> > > > > Hello Padmanabha,
> > > > > 
> > > > > On Mon, 7 Mar 2022 19:40:11 +0100
> > > > > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > > > > 
> > > > > > Hello Masami Hiramatsu,
> > > > > > 
> > > > > > Thanks for detailed explanation on boot time tracing using early boot configuration file.
> > > > > > https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf
> > > > > > 
> > > > > > Also for https://lwn.net/Articles/806002/.
> > > > > > 
> > > > > > Latter link also states we can embed boot config into the kernel image for non intrd based system.
> > > > > 
> > > > > Ah, that was an original plan, but since no one interested in, I didn't implement it.
> > > > > So we still need the initrd for bootconfig.
> > > > >
> > > > Ok.
> > > > > > 
> > > > > > I tried searching mailing lists not able to find pointer for same.
> > > > > > 
> > > > > > A hint/pointer on how-to will be very helpful. 
> > > > > 
> > > > > BTW, what is your problem, could you share your use-case?
> > > > > 
> > > > 
> > > > I have hetrogenous system which donot use intrd.
> > > > 
> > > > The use-case is to capture __system wide__ event based tracing for
> > > > boot-up sequence, which also covers early stage of default init programs
> > > > used.
> > > > 
> > > > As buffer size is limited, will have hand-picked events set configured.
> > > 
> > > Hm, so I guess you will boot linux from your custom bootloader (or binary loader on sub processor?).
> > >
> > Yes, customised implemation which loads linux. 
> > 
> > > Can you even try to add a dummy initrd? or are you OK to rebuild kernel for embedding the bootconfig data?
> > Yes, re-building the kernel image to appended bootconfig data is feasable option.
> > 
> 
> OK, please try below patch. You can embed your bootconfig in the kernel via
> CONFIG_EMBED_BOOT_CONFIG_FILE.
>
Thank you Masmi, so kind of you. Will test the latest patchset and
report the results.
> 
> From 7478a8fbfe4669ee61fcb12b85b36d7e36f992ba Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Sat, 12 Mar 2022 14:59:30 +0900
> Subject: [PATCH] bootconfig: Support embedding a bootconfig file in kernel
> 
> This allows kernel developer to embed a default bootconfig file in
> the kernel instead of embedding it in the initrd. This will be good
> for who are using the kernel without initrd, or who needs a default
> bootconfigs.
> This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
> name to CONFIG_EMBED_BOOT_CONFIG_FILE.
> Note that you still need 'bootconfig' command line option to load the
> embedded bootconfig. And if you boot with the initrd which has another
> bootconfig, the kernel will use the bootconfig in the initrd, instead
> of embedding one.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/bootconfig.h | 10 ++++++++++
>  init/Kconfig               | 19 +++++++++++++++++++
>  init/main.c                | 25 +++++++++++++------------
>  lib/bootconfig.c           | 23 +++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index a4665c7ab07c..5dbda5e3e9bb 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
>  /* XBC cleanup data structures */
>  void __init xbc_exit(void);
>  
> +/* XBC embedded bootconfig data in kernel */
> +#ifdef CONFIG_EMBED_BOOT_CONFIG
> +char * __init xbc_get_embedded_bootconfig(size_t *size);
> +#else
> +static inline char *xbc_get_embedded_bootconfig(size_t *size)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif
> diff --git a/init/Kconfig b/init/Kconfig
> index e9119bf54b1f..1b736ac7f90d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1357,6 +1357,25 @@ config BOOT_CONFIG
>  
>  	  If unsure, say Y.
>  
> +config EMBED_BOOT_CONFIG
> +	bool "Embed bootconfig file in the kernel"
> +	depends on BOOT_CONFIG
> +	default n
> +	help
> +	  Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
> +	  kernel. Usually, the bootconfig file is loaded with the initrd
> +	  image. But if the system doesn't support initrd, this option will
> +	  help you by embedding a bootconfig file while building the kernel.
> +
> +	  If unsure, say N.
> +
> +config EMBED_BOOT_CONFIG_FILE
> +	string "Embedded bootconfig file path"
> +	default ""
> +	depends on EMBED_BOOT_CONFIG
> +	help
> +	  Specify a bootconfig file which will be embedded to the kernel.
> +
>  choice
>  	prompt "Compiler optimization level"
>  	default CC_OPTIMIZE_FOR_PERFORMANCE
> diff --git a/init/main.c b/init/main.c
> index 65fa2e41a9c0..f371610bc008 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -265,7 +265,7 @@ static int __init loglevel(char *str)
>  early_param("loglevel", loglevel);
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> -static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
> +static void * __init get_boot_config_from_initrd(size_t *_size)
>  {
>  	u32 size, csum;
>  	char *data;
> @@ -299,12 +299,15 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
>  		return NULL;
>  	}
>  
> +	if (xbc_calc_checksum(data, size) != csum) {
> +		pr_err("bootconfig checksum failed\n");
> +		return NULL;
> +	}
> +
>  	/* Remove bootconfig from initramfs/initrd */
>  	initrd_end = (unsigned long)data;
>  	if (_size)
>  		*_size = size;
> -	if (_csum)
> -		*_csum = csum;
>  
>  	return data;
>  }
> @@ -408,12 +411,15 @@ static void __init setup_boot_config(void)
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
>  	const char *msg;
>  	int pos;
> -	u32 size, csum;
> +	size_t size;
>  	char *data, *err;
>  	int ret;
>  
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
> -	data = get_boot_config_from_initrd(&size, &csum);
> +	data = get_boot_config_from_initrd(&size);
> +	/* If there is no bootconfig in initrd, try embedded one. */
> +	if (!data)
> +		data = xbc_get_embedded_bootconfig(&size);
>  
>  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -432,16 +438,11 @@ static void __init setup_boot_config(void)
>  	}
>  
>  	if (size >= XBC_DATA_MAX) {
> -		pr_err("bootconfig size %d greater than max size %d\n",
> +		pr_err("bootconfig size %ld greater than max size %d\n",
>  			size, XBC_DATA_MAX);
>  		return;
>  	}
>  
> -	if (xbc_calc_checksum(data, size) != csum) {
> -		pr_err("bootconfig checksum failed\n");
> -		return;
> -	}
> -
>  	ret = xbc_init(data, size, &msg, &pos);
>  	if (ret < 0) {
>  		if (pos < 0)
> @@ -451,7 +452,7 @@ static void __init setup_boot_config(void)
>  				msg, pos);
>  	} else {
>  		xbc_get_info(&ret, NULL);
> -		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
> +		pr_info("Load bootconfig: %ld bytes %d nodes\n", size, ret);
>  		/* keys starting with "kernel." are passed via cmdline */
>  		extra_command_line = xbc_make_cmdline("kernel");
>  		/* Also, "init." keys are init arguments */
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 74f3201ab8e5..bf84f5838c08 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -12,6 +12,29 @@
>  #include <linux/kernel.h>
>  #include <linux/memblock.h>
>  #include <linux/string.h>
> +
> +#ifdef CONFIG_EMBED_BOOT_CONFIG
> +asm (
> +"	.pushsection .init.data, \"aw\"			\n"
> +"	.global embedded_bootconfig_data		\n"
> +"embedded_bootconfig_data:				\n"
> +"	.incbin \"" CONFIG_EMBED_BOOT_CONFIG_FILE "\"	\n"
> +"	.global embedded_bootconfig_data_end		\n"
> +"embedded_bootconfig_data_end:				\n"
> +"	.popsection					\n"
> +);
> +
> +extern __visible char embedded_bootconfig_data[];
> +extern __visible char embedded_bootconfig_data_end[];
> +
> +char * __init xbc_get_embedded_bootconfig(size_t *size)
> +{
> +	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
> +	return embedded_bootconfig_data;
> +}
> +
> +#endif
> +
>  #else /* !__KERNEL__ */
>  /*
>   * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> -- 
> 2.25.1
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
