Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459295AF72E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIFVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIFVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:42:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F3A8308
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:42:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j12so252633pfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qqaQNOdpehqVq2XrweTVHqYoJcLxU4LOqgxU+UY60WQ=;
        b=Qs7dLb2pL3V3HdrG3Pv00KmIHSZrRFEQqdYflAlJUmtdciWsItEQ8Htkv6YneSBYwY
         Hs5g69MtDio3wFYWyiMv+3vQXaoDbTS74stSTnR7vUz9O65mWgC5c5hVw9AM8sXQ2wRx
         VTRNK5albonxpliONnuWIYHNI/t4MHcs1gF/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qqaQNOdpehqVq2XrweTVHqYoJcLxU4LOqgxU+UY60WQ=;
        b=3b30+OvxHRKF/j1FvHaGYlj0yykuZfBAR50ChZfyho96QSb+SAglY8l/w9wPRX2lFv
         yllpktqur64nWXK1p4PUUOHf92b/w/Ntz5YO5UfIvnPJQFPLsEhB1mU1AatLXL8UC3C6
         UinrM62aQ/UvHLcBJp6PhHO8zPbvcd9zGESoxTaM/yVV7fUHMrrwAOmPrP6uOIQMToLI
         pIJdPrEB6RWLDSZ+XH/mCN+A3etVrycjNG5r7OG/62rBnclHqb21KECGJ6kHfVnbHhub
         BrlkUlP4TB7613NVjQhFK62c4YvpYzUjCWjKWho1TtIHM7Wdmiuq35TFvTxUUfQ0PdZ5
         DBlg==
X-Gm-Message-State: ACgBeo1oNU/c+hKW03oPSCa9u3TzDVjMut4IIM73m6S/nBT9g+NrLT9X
        skNj2ZjGY8vUlVsU5tQ7YATTcw==
X-Google-Smtp-Source: AA6agR6IVbl9vhYt8tQVvWX6Bhb8qmGSNxPpRhfN16MoqKCPZoC5QRPOOz4Jr5nirm//GtXy6ukk6w==
X-Received: by 2002:a63:2208:0:b0:429:9444:85be with SMTP id i8-20020a632208000000b00429944485bemr597770pgi.236.1662500558614;
        Tue, 06 Sep 2022 14:42:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001752216ca51sm10545234plx.39.2022.09.06.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:42:37 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:42:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209061432.FFF96789B@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Interesting -- I wonder why this suddenly appeared. I think the fix is
the common "linker addresses need to be char arrays" fix:

diff --git a/arch/sh/include/asm/sections.h b/arch/sh/include/asm/sections.h
index 8edb824049b9..0cb0ca149ac3 100644
--- a/arch/sh/include/asm/sections.h
+++ b/arch/sh/include/asm/sections.h
@@ -4,7 +4,7 @@
 
 #include <asm-generic/sections.h>
 
-extern long __machvec_start, __machvec_end;
+extern char __machvec_start[], __machvec_end[];
 extern char __uncached_start, __uncached_end;
 extern char __start_eh_frame[], __stop_eh_frame[];
 
diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index d606679a211e..57efaf5b82ae 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -20,8 +20,8 @@
 #define MV_NAME_SIZE 32
 
 #define for_each_mv(mv) \
-	for ((mv) = (struct sh_machine_vector *)&__machvec_start; \
-	     (mv) && (unsigned long)(mv) < (unsigned long)&__machvec_end; \
+	for ((mv) = (struct sh_machine_vector *)__machvec_start; \
+	     (mv) && (unsigned long)(mv) < (unsigned long)__machvec_end; \
 	     (mv)++)
 
 static struct sh_machine_vector * __init get_mv_byname(const char *name)
@@ -87,8 +87,8 @@ void __init sh_mv_setup(void)
 	if (!machvec_selected) {
 		unsigned long machvec_size;
 
-		machvec_size = ((unsigned long)&__machvec_end -
-				(unsigned long)&__machvec_start);
+		machvec_size = ((unsigned long)__machvec_end -
+				(unsigned long)__machvec_start);
 
 		/*
 		 * Sanity check for machvec section alignment. Ensure
@@ -102,7 +102,7 @@ void __init sh_mv_setup(void)
 		 * vector (usually the only one) from .machvec.init.
 		 */
 		if (machvec_size >= sizeof(struct sh_machine_vector))
-			sh_mv = *(struct sh_machine_vector *)&__machvec_start;
+			sh_mv = *(struct sh_machine_vector *)__machvec_start;
 	}
 
 	pr_notice("Booting machvec: %s\n", get_system_type());

> 
>   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3768:1
> 
> x86_64-gcc8/x86-allmodconfig (in function dml32_ModeSupportAndSystemConfigurationFull())

This I don't know about it, but looks like a recent commit: dda4fb85e433f
Given it's a 2000 line function, I assume it could be improved! :)

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This is:

        memset(&p->irqtrace, 0, sizeof(p->irqtrace));

p->irqtrace is:

        struct irqtrace_events          irqtrace;

But that's a whole object destination... why would only s390 warn?

-Kees

-- 
Kees Cook
