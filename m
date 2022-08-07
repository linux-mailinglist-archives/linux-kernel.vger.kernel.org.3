Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11BB58B9AF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiHGFZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHGFZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:25:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BD101E3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:25:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so10130289pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elx3tlR1SPQEOpAX6pa/qEPgTPewsMAdzIedzE8gNBY=;
        b=KSAmVz7/p0LQMqXbhAbmsdTh7Y354s9j+26eC3tHR9D085FNZlYl3ZA9BUJ2TgD7mN
         rKVXnc4ee6RjbE6NLHh7CedZtMmJkyL0uvIkG8d/Qb0cpaX45WZmmPdl/HbJWOr/hPtg
         7uUCrEkadwdtwcA3Dm/zNGuaXSn/yX5bKnxQxDYXVIUs43VFKfDS1UoU0pRoPg7pu7z8
         1+HvAEIJsJkZLz+HvLceUNV3yTWar9n4XHKpXFAUAEcYAKmbBtGIJM1jvwsEYJX+09kS
         8iXlFoTkaCuBmd4uEfuWDywvIzI5Sx6CCJz22HEKMuY054ZSOrBCuY+WNs5lLBZkprG+
         TZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elx3tlR1SPQEOpAX6pa/qEPgTPewsMAdzIedzE8gNBY=;
        b=B6NZNjgKlWZHz7sK++n4J62pCfwL0OIlwgYchn+raowHc7TFaNPLBrZFrI/bh4dGyJ
         9Pr/OUqgqntQPUnnloT5oTc+Xp9phG9pUXTXyq34c4wILTm71j5bLAEzXM3iykKk+zo5
         cRSXbVA9mQjv2yc+j4+VVz3MZ82YsJuTuyJjRoE8eurMjQHF2u5+IRYDmdYTjA43GUHc
         rg9ijr0nSuCyb1f3yLFpWhl+LXSQ67Pb6PN+i7JGW4P1FwDqSiY8Md/RIx/KsWyeBCou
         HuoE9jco/Ke7WUMQTpQV+3x2UfzLde8qS1TteL7vxdPxocUxgPeHb4d9xg+y/TCaNQIi
         liug==
X-Gm-Message-State: ACgBeo34n/w3YcYpbjiNfFN/wbXxzyeEh0WN0P4PAGppxqcup9293WuQ
        A9pAd0p8eEWUNMinua3xAo91HQ==
X-Google-Smtp-Source: AA6agR4dMh81huEgB2PK+6BfqbAmVthoWiD6yUjsQYbGQII147WERV1Sl0eyD8vffN2CQe4fE9SlHA==
X-Received: by 2002:a17:902:8b88:b0:16d:2a70:26d9 with SMTP id ay8-20020a1709028b8800b0016d2a7026d9mr13807918plb.84.1659849950907;
        Sat, 06 Aug 2022 22:25:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0052dce4edceesm5874337pfr.169.2022.08.06.22.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:25:50 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:25:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 11/14] perf test: Add unroll thread test tool
Message-ID: <20220807052546.GI34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-12-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-12-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:53PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add test tool to be driven by further test scripts. This is a simple C
> based test that is for arm64 with some inline ASM to manually unroll a
> lot of code to have a very long sequence of commands.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/shell/coresight/Makefile     |  3 +-
>  .../coresight/unroll_loop_thread/.gitignore   |  1 +
>  .../coresight/unroll_loop_thread/Makefile     | 33 +++++++++
>  .../unroll_loop_thread/unroll_loop_thread.c   | 74 +++++++++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> 
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> index 004974a71fb8..3b2b876cd9e2 100644
> --- a/tools/perf/tests/shell/coresight/Makefile
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -7,7 +7,8 @@ include ../../../../../tools/scripts/utilities.mak
>  SUBDIRS = \
>  	asm_pure_loop \
>  	memcpy_thread \
> -	thread_loop
> +	thread_loop \
> +	unroll_loop_thread
>  
>  all: $(SUBDIRS)
>  $(SUBDIRS):
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
> new file mode 100644
> index 000000000000..2cb4e996dbf3
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
> @@ -0,0 +1 @@
> +unroll_loop_thread
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
> new file mode 100644
> index 000000000000..6264c4e3abd1
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../Makefile.miniconfig
> +
> +# Binary to produce
> +BIN=unroll_loop_thread
> +# Any linking/libraries needed for the binary - empty if none needed
> +LIB=-pthread
> +
> +all: $(BIN)
> +
> +$(BIN): $(BIN).c
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +# Build line
> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +# Install the test tool in the right place
> +	$(call QUIET_INSTALL, tests) \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +	$(Q)$(RM) -f $(BIN)
> +
> +.PHONY: all clean install-tests
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> new file mode 100644
> index 000000000000..cb9d22c7dfb9
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +struct args {
> +	pthread_t th;
> +	unsigned int in, out;

nitpick: "out" field is not used, drop it?

With this minor fixing, the patch LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +	void *ret;
> +};
> +
> +static void *thrfn(void *arg)
> +{
> +	struct args *a = arg;
> +	unsigned int i, in = a->in;
> +
> +	for (i = 0; i < 10000; i++) {
> +		asm volatile (
> +// force an unroll of thia add instruction so we can test long runs of code
> +#define SNIP1 "add %[in], %[in], #1\n"
> +// 10
> +#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
> +// 100
> +#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
> +// 1000
> +#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
> +// 10000
> +#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
> +// 100000
> +			SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
> +			: /* out */
> +			: /* in */ [in] "r" (in)
> +			: /* clobber */
> +		);
> +	}
> +}
> +
> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
> +{
> +	pthread_t t;
> +	pthread_attr_t attr;
> +
> +	pthread_attr_init(&attr);
> +	pthread_create(&t, &attr, fn, arg);
> +	return t;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int i, thr;
> +	pthread_t threads[256];
> +	struct args args[256];
> +
> +	if (argc < 2) {
> +		printf("ERR: %s [numthreads]\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	thr = atoi(argv[1]);
> +	if ((thr > 256) || (thr < 1)) {
> +		printf("ERR: threads 1-256\n");
> +		exit(1);
> +	}
> +	for (i = 0; i < thr; i++) {
> +		args[i].in = rand();
> +		args[i].th = new_thr(thrfn, &(args[i]));
> +	}
> +	for (i = 0; i < thr; i++)
> +		pthread_join(args[i].th, &(args[i].ret));
> +	return 0;
> +}
> -- 
> 2.32.0
> 
